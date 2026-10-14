#!/usr/bin/env python3
"""不依赖 Node.js 或 xlsxTools，将脚本目录中的 XLSM 配置编译为 gamedata.json。"""

from __future__ import annotations

import base64
import argparse
import json
import math
import os
import re
import zlib
from datetime import datetime
from pathlib import Path, PurePosixPath
from typing import Any
from xml.etree import ElementTree
from zipfile import BadZipFile, ZipFile


SPREADSHEET_NAMESPACE = "http://schemas.openxmlformats.org/spreadsheetml/2006/main"
DOCUMENT_RELATIONSHIP_NAMESPACE = (
    "http://schemas.openxmlformats.org/officeDocument/2006/relationships"
)
PACKAGE_RELATIONSHIP_NAMESPACE = (
    "http://schemas.openxmlformats.org/package/2006/relationships"
)
CELL_REFERENCE_PATTERN = re.compile(r"\$?([A-Za-z]+)\$?(\d+)")
RANGE_REFERENCE_PATTERN = re.compile(
    r"(?:[^!]+!)?\$?([A-Za-z]+)\$?(\d+):\$?([A-Za-z]+)\$?(\d+)"
)
JS_ARRAY_INDEX_PATTERN = re.compile(r"(?:0|[1-9]\d*)")


def xml_name(local_name: str) -> str:
    """返回电子表格 XML 命名空间下的完整标签名。"""
    return f"{{{SPREADSHEET_NAMESPACE}}}{local_name}"


def column_name_to_index(column_name: str) -> int:
    """将 Excel 列名转换为从 0 开始的列索引。"""
    column_index = 0
    for character in column_name.upper():
        column_index = column_index * 26 + ord(character) - ord("A") + 1
    return column_index - 1


def parse_cell_reference(reference: str) -> tuple[int, int]:
    """解析 Excel 单元格引用，返回从 0 开始的行、列索引。"""
    match = CELL_REFERENCE_PATTERN.fullmatch(reference)
    if match is None:
        raise ValueError(f"无法解析单元格引用：{reference}")
    return int(match.group(2)) - 1, column_name_to_index(match.group(1))


def parse_range_reference(reference: str) -> tuple[int, int, int, int]:
    """解析工作表有效区域，返回起止行列的从 0 开始索引。"""
    match = RANGE_REFERENCE_PATTERN.fullmatch(reference)
    if match is None:
        single_row, single_column = parse_cell_reference(reference)
        return single_row, single_column, single_row, single_column
    return (
        int(match.group(2)) - 1,
        column_name_to_index(match.group(1)),
        int(match.group(4)) - 1,
        column_name_to_index(match.group(3)),
    )


def read_xml(archive: ZipFile, member_name: str) -> ElementTree.Element:
    """从 XLSM 压缩包中读取并解析指定 XML 文件。"""
    try:
        return ElementTree.fromstring(archive.read(member_name))
    except KeyError as error:
        raise ValueError(f"XLSM 缺少必需文件：{member_name}") from error
    except ElementTree.ParseError as error:
        raise ValueError(f"XML 格式错误：{member_name}") from error


def read_shared_strings(archive: ZipFile) -> list[str]:
    """读取 XLSM 共享字符串表，并合并富文本的所有文本片段。"""
    if "xl/sharedStrings.xml" not in archive.namelist():
        return []
    root = read_xml(archive, "xl/sharedStrings.xml")
    return [
        "".join(text_node.text or "" for text_node in item.iter(xml_name("t")))
        for item in root.findall(xml_name("si"))
    ]


def resolve_first_worksheet_path(archive: ZipFile) -> tuple[str, str]:
    """根据工作簿关系找到第一张工作表的名称和 XML 路径。"""
    workbook_root = read_xml(archive, "xl/workbook.xml")
    first_sheet = workbook_root.find(f"{xml_name('sheets')}/{xml_name('sheet')}")
    if first_sheet is None:
        raise ValueError("XLSM 中没有工作表")

    relationship_id = first_sheet.get(f"{{{DOCUMENT_RELATIONSHIP_NAMESPACE}}}id")
    if not relationship_id:
        raise ValueError("第一张工作表缺少关系 ID")

    relationships_root = read_xml(archive, "xl/_rels/workbook.xml.rels")
    relationship_tag = f"{{{PACKAGE_RELATIONSHIP_NAMESPACE}}}Relationship"
    target = next(
        (
            relationship.get("Target")
            for relationship in relationships_root.findall(relationship_tag)
            if relationship.get("Id") == relationship_id
        ),
        None,
    )
    if not target:
        raise ValueError("无法定位第一张工作表文件")

    normalized_target = str(PurePosixPath("xl") / target.lstrip("/"))
    if target.startswith("/xl/"):
        normalized_target = target.lstrip("/")
    return first_sheet.get("name", "Sheet1"), normalized_target


def parse_number(raw_value: str) -> int | float:
    """按 JavaScript Number 的常规行为解析数值单元格。"""
    number = float(raw_value)
    if math.isfinite(number) and number.is_integer() and abs(number) < 1e21:
        return int(number)
    return number


def read_cell_value(cell: ElementTree.Element, shared_strings: list[str]) -> Any:
    """读取单元格的缓存值，覆盖共享字符串、布尔值和数值类型。"""
    cell_type = cell.get("t", "n")
    value_node = cell.find(xml_name("v"))

    if cell_type == "inlineStr":
        inline_node = cell.find(xml_name("is"))
        if inline_node is None:
            return ""
        return "".join(
            text_node.text or "" for text_node in inline_node.iter(xml_name("t"))
        )
    if value_node is None:
        return None

    raw_value = value_node.text or ""
    if cell_type == "s":
        try:
            return shared_strings[int(raw_value)]
        except (ValueError, IndexError) as error:
            raise ValueError(f"共享字符串索引无效：{raw_value}") from error
    if cell_type == "b":
        return raw_value == "1"
    if cell_type in {"str", "e", "d"}:
        return raw_value
    if raw_value == "":
        return None
    try:
        return parse_number(raw_value)
    except ValueError:
        return raw_value


def javascript_number_to_string(value: float) -> str:
    """将浮点数转为与 JavaScript String(number) 兼容的字符串。"""
    if math.isnan(value):
        return "NaN"
    if math.isinf(value):
        return "Infinity" if value > 0 else "-Infinity"
    if value == 0:
        return "0"

    representation = repr(value).lower()
    absolute_value = abs(value)
    if "e" in representation and 1e-6 <= absolute_value < 1e21:
        mantissa, exponent_text = representation.split("e")
        exponent = int(exponent_text)
        sign = "-" if mantissa.startswith("-") else ""
        digits = mantissa.lstrip("-").replace(".", "")
        decimal_position = mantissa.lstrip("-").find(".")
        integer_length = (
            len(mantissa.lstrip("-"))
            if decimal_position == -1
            else decimal_position
        )
        target_position = integer_length + exponent
        if target_position <= 0:
            return f"{sign}0.{('0' * -target_position)}{digits}"
        if target_position >= len(digits):
            return f"{sign}{digits}{'0' * (target_position - len(digits))}"
        return f"{sign}{digits[:target_position]}.{digits[target_position:]}"

    if "e" in representation:
        mantissa, exponent_text = representation.split("e")
        exponent = int(exponent_text)
        exponent_sign = "+" if exponent >= 0 else "-"
        return f"{mantissa}e{exponent_sign}{abs(exponent)}"
    return representation.removesuffix(".0")


def javascript_string(value: Any) -> str:
    """将单元格值转为与原 Node.js 脚本一致的字符串。"""
    if value is None:
        return "undefined"
    if isinstance(value, bool):
        return "true" if value else "false"
    if isinstance(value, float):
        return javascript_number_to_string(value)
    return str(value)


def next_short_field_name(field_index: int) -> str:
    """按原脚本的 a…z、aa、ba… 规则生成字段简写。"""
    letter = chr(ord("a") + field_index % 26)
    suffix = "a" * (field_index // 26)
    return letter + suffix


def parse_worksheet(
    worksheet_root: ElementTree.Element,
    shared_strings: list[str],
    workbook_path: Path,
    sheet_name: str,
) -> tuple[dict[str, str], list[dict[str, str]], list[dict[str, str]]]:
    """按原工具规则解析第一张工作表，并兼容未写 dimension 的合法 XLSM。"""
    cells: dict[tuple[int, int], Any] = {}
    sheet_data = worksheet_root.find(xml_name("sheetData"))
    if sheet_data is not None:
        for row in sheet_data.findall(xml_name("row")):
            next_column = 0
            for cell in row.findall(xml_name("c")):
                reference = cell.get("r")
                if reference:
                    row_index, column_index = parse_cell_reference(reference)
                else:
                    row_index = int(row.get("r", "1")) - 1
                    column_index = next_column
                cell_value = read_cell_value(cell, shared_strings)
                if cell_value is not None:
                    cells[(row_index, column_index)] = cell_value
                next_column = column_index + 1

    dimension = worksheet_root.find(xml_name("dimension"))
    if dimension is not None and dimension.get("ref"):
        start_row, start_column, end_row, end_column = parse_range_reference(
            dimension.get("ref", "")
        )
    elif cells:
        row_indexes = [position[0] for position in cells]
        column_indexes = [position[1] for position in cells]
        start_row, start_column = min(row_indexes), min(column_indexes)
        end_row, end_column = max(row_indexes), max(column_indexes)
    else:
        raise ValueError(f"{workbook_path.name} 的 {sheet_name} 缺少有效区域")

    if start_row > 0 or end_row < 3:
        print(f"警告：{workbook_path.name}, {sheet_name} 表数据不足")
    if start_column > 0 or end_column < 1:
        print(f"警告：{workbook_path.name}, {sheet_name} 表列数不足")

    field_names_by_column: dict[int, str] = {}
    short_names_by_field: dict[str, str] = {}
    field_index = 0
    for column_index in range(start_column, end_column + 1):
        header_value = cells.get((start_row, column_index))
        if not isinstance(header_value, str) or not header_value:
            continue
        if header_value.startswith("#"):
            continue
        short_name = next_short_field_name(field_index)
        field_index += 1
        field_names_by_column[column_index] = header_value
        short_names_by_field[header_value] = short_name

    compressed_rows: list[dict[str, str]] = []
    original_rows: list[dict[str, str]] = []
    for row_index in range(start_row + 3, end_row + 1):
        compressed_row: dict[str, str] = {}
        original_row: dict[str, str] = {}
        has_value = False
        for column_index in range(start_column, end_column + 1):
            field_name = field_names_by_column.get(column_index)
            if field_name is None:
                continue
            cell_value = cells.get((row_index, column_index), "")
            value = javascript_string(cell_value)
            short_name = short_names_by_field[field_name]
            compressed_row[short_name] = value
            original_row[field_name] = value
            if value != "":
                has_value = True
        if has_value:
            compressed_rows.append(compressed_row)
            original_rows.append(original_row)

    return short_names_by_field, compressed_rows, original_rows


def parse_workbook(
    workbook_path: Path,
) -> tuple[dict[str, str], list[dict[str, str]], list[dict[str, str]]]:
    """从单个 XLSM 文件读取第一张工作表的编译数据。"""
    try:
        with ZipFile(workbook_path) as archive:
            shared_strings = read_shared_strings(archive)
            sheet_name, worksheet_path = resolve_first_worksheet_path(archive)
            worksheet_root = read_xml(archive, worksheet_path)
    except BadZipFile as error:
        raise ValueError(f"{workbook_path.name} 不是有效的 XLSM 文件") from error
    return parse_worksheet(
        worksheet_root, shared_strings, workbook_path, sheet_name
    )


def is_javascript_array_index(key: str) -> bool:
    """判断字段名是否会被 JavaScript JSON.stringify 当作数组索引。"""
    if JS_ARRAY_INDEX_PATTERN.fullmatch(key) is None:
        return False
    number = int(key)
    return number < 4_294_967_295 and str(number) == key


def order_like_javascript(value: Any) -> Any:
    """递归调整字典键顺序，保持与 JavaScript 对象序列化一致。"""
    if isinstance(value, list):
        return [order_like_javascript(item) for item in value]
    if not isinstance(value, dict):
        return value

    index_keys = sorted(
        (key for key in value if is_javascript_array_index(str(key))),
        key=lambda key: int(str(key)),
    )
    other_keys = [key for key in value if key not in index_keys]
    return {
        key: order_like_javascript(value[key]) for key in [*index_keys, *other_keys]
    }


def serialize_json(value: Any) -> str:
    """以与 JSON.stringify 一致的紧凑 UTF-8 形式序列化数据。"""
    ordered_value = order_like_javascript(value)
    return json.dumps(ordered_value, ensure_ascii=False, separators=(",", ":"))


def compress_to_base64(value: str) -> str:
    """使用与 pako.deflateRaw 兼容的 raw-deflate 压缩并转为 Base64。"""
    compressor = zlib.compressobj(level=zlib.Z_DEFAULT_COMPRESSION, wbits=-15)
    compressed = compressor.compress(value.encode("utf-8")) + compressor.flush()
    return base64.b64encode(compressed).decode("ascii")


def build_game_data(directory: Path) -> dict[str, dict[str, Any]]:
    """遍历目录中的 XLSM 文件，生成原脚本的游戏配置结构。"""
    game_data: dict[str, dict[str, Any]] = {}
    for entry in sorted(directory.iterdir(), key=lambda path: path.name):
        if not entry.is_file() or ".xlsm" not in entry.name:
            continue
        workbook_name = entry.name.replace(".xlsm", "", 1)
        if workbook_name.startswith("~$") or workbook_name == "adswitch":
            continue
        field_map, rows, _ = parse_workbook(entry)
        game_data[workbook_name] = {"code": field_map, "data": rows}
    return game_data


def current_time_text() -> str:
    """按原脚本格式生成当前本地时间文本。"""
    now = datetime.now()
    return (
        f"{now.year}-{now.month:02d}-{now.day:02d} "
        f"{now.hour}:{now.minute}:{now.second}"
    )


def create_compressed_output(game_data: dict[str, Any], save_time: str) -> dict[str, Any]:
    """将已编译的表数据封装为原工具的压缩 JSON 结构。"""
    return {
        "_zinfo": compress_to_base64(serialize_json(game_data)),
        "_savetimes": save_time,
        "_zstate": 1,
    }


def write_text_atomically(output_path: Path, content: str) -> None:
    """先写入临时文件再替换目标，避免中途失败损坏原配置。"""
    temporary_path = output_path.with_name(f".{output_path.name}.tmp")
    try:
        temporary_path.write_text(content, encoding="utf-8")
        os.replace(temporary_path, output_path)
    finally:
        if temporary_path.exists():
            temporary_path.unlink()


def compile_current_directory(directory: Path) -> Path:
    """编译主目录及可选 Local 目录，并原子发布 Remote 与工程内 Config。"""
    game_data = build_game_data(directory)
    local_directory = directory / "Local"
    local_game_data = build_game_data(local_directory) if local_directory.is_dir() else None
    save_time = current_time_text()
    output = create_compressed_output(game_data, save_time)
    local_output = (
        create_compressed_output(local_game_data, save_time)
        if local_game_data is not None
        else None
    )
    project_root = directory.parent / "UnityWork"
    remote_output_path = project_root / "Remote" / "Config" / "gamedata.json"
    remote_output_path.parent.mkdir(parents=True, exist_ok=True)
    project_config_output_path = (
        project_root
        / "Assets"
        / "StreamingAssets"
        / "HotUpdate"
        / "Config"
        / "gamedata.json"
    )
    project_config_output_path.parent.mkdir(parents=True, exist_ok=True)
    project_local_output_path = (
        project_root
        / "Assets"
        / "LocalRes"
        / "Config"
        / "localData.json"
    )
    if local_output is not None and not project_local_output_path.parent.is_dir():
        raise ValueError(f"项目本地配置目录不存在：{project_local_output_path.parent}")

    serialized_output = serialize_json(output)
    write_text_atomically(remote_output_path, serialized_output)
    write_text_atomically(project_config_output_path, serialized_output)
    if local_output is not None:
        local_output_path = local_directory / "localData.json"
        serialized_local_output = serialize_json(local_output)
        write_text_atomically(local_output_path, serialized_local_output)
        write_text_atomically(project_local_output_path, serialized_local_output)
        print(f"导出LocalData成功 {local_output_path}")
        print(f"替换项目LocalData成功 {project_local_output_path}")
    print(f"修改时间: {save_time}")
    print(f"导出Remote GameData成功 {remote_output_path}")
    print(f"导入项目GameData成功 {project_config_output_path}")
    print("加密Zip压缩 zstate=1")
    return remote_output_path


def wait_for_exit() -> None:
    """在交互终端中等待用户确认，保留原 bat 脚本的暂停体验。"""
    try:
        input("请按回车键继续. . .")
    except EOFError:
        pass


def parse_arguments(arguments: list[str] | None = None) -> argparse.Namespace:
    """解析编译器命令行参数，保留双击脚本时默认等待终端输入的兼容行为。"""
    parser = argparse.ArgumentParser(description="将 XLSM 配置编译为共享 Remote Config")
    parser.add_argument(
        "--no-wait",
        action="store_true",
        help="完成后不等待回车，供 Unity Editor 自动化构建调用。",
    )
    return parser.parse_args(arguments)


def main(arguments: list[str] | None = None) -> int:
    """以脚本所在目录为输入目录执行编译，并按参数决定是否等待交互终端。"""
    options = parse_arguments(arguments)
    exit_code = 0
    try:
        compile_current_directory(Path(__file__).resolve().parent)
    except (OSError, ValueError) as error:
        print(f"编译失败：{error}")
        exit_code = 1
    if not options.no_wait:
        wait_for_exit()
    return exit_code


if __name__ == "__main__":
    raise SystemExit(main())
