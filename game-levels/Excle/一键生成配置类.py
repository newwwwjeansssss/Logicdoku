#!/usr/bin/env python3
"""根据 Excle 直属配置表增量生成 C# 配置类，并补齐运行时注册。"""

from __future__ import annotations

import argparse
import html
import os
import re
import sys
from dataclasses import dataclass
from pathlib import Path, PurePosixPath
from typing import Iterable
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
CSHARP_IDENTIFIER_PATTERN = re.compile(r"^[A-Za-z_][A-Za-z0-9_]*$")
SUPPORTED_TYPES = {
    "string": "string",
    "int": "int",
    "float": "float",
}


@dataclass(frozen=True)
class FieldSpec:
    """记录单个配置字段的名称、注释和 C# 类型。"""

    name: str
    comment: str
    csharp_type: str


@dataclass(frozen=True)
class TableSpec:
    """记录单张配置表生成 C# 类所需的结构信息。"""

    table_name: str
    class_prefix: str
    workbook_path: Path
    fields: tuple[FieldSpec, ...]

    @property
    def id_field(self) -> FieldSpec:
        """返回表中作为字典主键的 Id 字段。"""
        return next(field for field in self.fields if field.name == "Id")


@dataclass(frozen=True)
class ClassBlock:
    """记录 C# 类在源文件中的声明、类体范围及继承信息。"""

    name: str
    base_text: str
    declaration_start: int
    body_start: int
    body_end: int


@dataclass(frozen=True)
class ManagerBinding:
    """记录配置表名与现有管理类、数据类之间的绑定关系。"""

    table_name: str
    manager_name: str
    config_name: str
    key_type: str
    source_path: Path


@dataclass
class SourceDocument:
    """保存待修改源码及其原始编码和换行特征。"""

    path: Path
    text: str
    has_utf8_bom: bool
    newline: str


class GenerationError(Exception):
    """表示表结构或源码结构不满足安全增量生成条件。"""


def xml_name(local_name: str) -> str:
    """返回电子表格 XML 命名空间下的完整标签名。"""
    return f"{{{SPREADSHEET_NAMESPACE}}}{local_name}"


def column_name_to_index(column_name: str) -> int:
    """将 Excel 列名转换为从零开始的列索引。"""
    column_index = 0
    for character in column_name.upper():
        column_index = column_index * 26 + ord(character) - ord("A") + 1
    return column_index - 1


def parse_cell_reference(reference: str) -> tuple[int, int]:
    """解析 Excel 单元格引用并返回从零开始的行列索引。"""
    match = CELL_REFERENCE_PATTERN.fullmatch(reference)
    if match is None:
        raise GenerationError(f"无法解析单元格引用：{reference}")
    return int(match.group(2)) - 1, column_name_to_index(match.group(1))


def read_xml(archive: ZipFile, member_name: str) -> ElementTree.Element:
    """从工作簿压缩包读取并解析指定 XML 文件。"""
    try:
        return ElementTree.fromstring(archive.read(member_name))
    except KeyError as error:
        raise GenerationError(f"工作簿缺少必需文件：{member_name}") from error
    except ElementTree.ParseError as error:
        raise GenerationError(f"工作簿 XML 格式错误：{member_name}") from error


def read_shared_strings(archive: ZipFile) -> list[str]:
    """读取共享字符串表并合并富文本的全部文本片段。"""
    if "xl/sharedStrings.xml" not in archive.namelist():
        return []
    root = read_xml(archive, "xl/sharedStrings.xml")
    return [
        "".join(text_node.text or "" for text_node in item.iter(xml_name("t")))
        for item in root.findall(xml_name("si"))
    ]


def resolve_first_worksheet_path(archive: ZipFile) -> tuple[str, str]:
    """根据工作簿关系定位第一张工作表的名称和 XML 路径。"""
    workbook_root = read_xml(archive, "xl/workbook.xml")
    first_sheet = workbook_root.find(f"{xml_name('sheets')}/{xml_name('sheet')}")
    if first_sheet is None:
        raise GenerationError("工作簿中没有工作表")

    relationship_id = first_sheet.get(f"{{{DOCUMENT_RELATIONSHIP_NAMESPACE}}}id")
    if not relationship_id:
        raise GenerationError("第一张工作表缺少关系 ID")

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
        raise GenerationError("无法定位第一张工作表文件")

    normalized_target = str(PurePosixPath("xl") / target.lstrip("/"))
    if target.startswith("/xl/"):
        normalized_target = target.lstrip("/")
    return first_sheet.get("name", "Sheet1"), normalized_target


def read_cell_value(cell: ElementTree.Element, shared_strings: list[str]) -> str:
    """读取表头单元格文本，兼容共享字符串和内联字符串。"""
    cell_type = cell.get("t", "n")
    if cell_type == "inlineStr":
        inline_node = cell.find(xml_name("is"))
        if inline_node is None:
            return ""
        return "".join(
            text_node.text or "" for text_node in inline_node.iter(xml_name("t"))
        )

    value_node = cell.find(xml_name("v"))
    if value_node is None:
        return ""
    raw_value = value_node.text or ""
    if cell_type == "s":
        try:
            return shared_strings[int(raw_value)]
        except (ValueError, IndexError) as error:
            raise GenerationError(f"共享字符串索引无效：{raw_value}") from error
    return raw_value


def read_first_three_rows(workbook_path: Path) -> dict[tuple[int, int], str]:
    """读取第一张工作表前三行，且不依赖可能缺失的 dimension 节点。"""
    try:
        with ZipFile(workbook_path) as archive:
            shared_strings = read_shared_strings(archive)
            _, worksheet_path = resolve_first_worksheet_path(archive)
            worksheet_root = read_xml(archive, worksheet_path)
    except BadZipFile as error:
        raise GenerationError(f"{workbook_path.name} 不是有效工作簿") from error

    values: dict[tuple[int, int], str] = {}
    sheet_data = worksheet_root.find(xml_name("sheetData"))
    if sheet_data is None:
        raise GenerationError(f"{workbook_path.name} 第一张工作表没有数据")

    for row in sheet_data.findall(xml_name("row")):
        row_number = int(row.get("r", "1"))
        if row_number > 3:
            continue
        next_column = 0
        for cell in row.findall(xml_name("c")):
            reference = cell.get("r")
            if reference:
                row_index, column_index = parse_cell_reference(reference)
            else:
                row_index = row_number - 1
                column_index = next_column
            values[(row_index, column_index)] = read_cell_value(
                cell, shared_strings
            ).strip()
            next_column = column_index + 1
    return values


def to_class_prefix(table_name: str) -> str:
    """将配置表文件名转换为可读的 PascalCase C# 类名前缀。"""
    parts = [part for part in re.split(r"[^A-Za-z0-9]+", table_name) if part]
    if not parts:
        raise GenerationError(f"表名无法转换为 C# 类名：{table_name}")
    class_prefix = "".join(part[:1].upper() + part[1:] for part in parts)
    if not CSHARP_IDENTIFIER_PATTERN.fullmatch(class_prefix):
        raise GenerationError(f"生成的 C# 类名不合法：{class_prefix}")
    return class_prefix


def normalize_csharp_type(type_text: str, workbook_name: str, field_name: str) -> str:
    """将第三行类型映射为当前反射解析器支持的 C# 类型。"""
    normalized = type_text.strip().lower()
    csharp_type = SUPPORTED_TYPES.get(normalized)
    if csharp_type is None:
        supported = "、".join(SUPPORTED_TYPES)
        raise GenerationError(
            f"{workbook_name} 字段 {field_name} 的类型 {type_text!r} 不受支持；"
            f"当前仅支持 {supported}"
        )
    return csharp_type


def read_table_spec(workbook_path: Path) -> TableSpec:
    """按第一行字段、第二行注释、第三行类型生成表结构定义。"""
    values = read_first_three_rows(workbook_path)
    columns = sorted({column for row, column in values if row == 0})
    fields: list[FieldSpec] = []
    for column in columns:
        field_name = values.get((0, column), "").strip()
        if not field_name or field_name.startswith("#"):
            continue
        if not CSHARP_IDENTIFIER_PATTERN.fullmatch(field_name):
            raise GenerationError(
                f"{workbook_path.name} 字段名不是合法 C# 标识符：{field_name}"
            )
        type_text = values.get((2, column), "").strip()
        if not type_text:
            raise GenerationError(
                f"{workbook_path.name} 字段 {field_name} 的第三行类型为空"
            )
        fields.append(
            FieldSpec(
                name=field_name,
                comment=values.get((1, column), "").strip(),
                csharp_type=normalize_csharp_type(
                    type_text, workbook_path.name, field_name
                ),
            )
        )

    if not fields:
        raise GenerationError(f"{workbook_path.name} 没有可生成的字段")
    id_fields = [field for field in fields if field.name == "Id"]
    if not id_fields:
        raise GenerationError(f"{workbook_path.name} 缺少必需字段 Id")
    if len(id_fields) != 1:
        raise GenerationError(f"{workbook_path.name} 必须且只能包含一个 Id 字段")

    return TableSpec(
        table_name=workbook_path.stem,
        class_prefix=to_class_prefix(workbook_path.stem),
        workbook_path=workbook_path,
        fields=tuple(fields),
    )


def discover_workbooks(excel_directory: Path) -> list[Path]:
    """返回 Excle 目录直属且参与配置生成的工作簿。"""
    if not excel_directory.exists():
        return []
    workbooks = [
        path
        for path in excel_directory.iterdir()
        if path.is_file()
        and path.suffix.lower() in {".xlsm", ".xlsx"}
        and not path.name.startswith("~$")
        and path.stem.lower() != "adswitch"
    ]
    return sorted(workbooks, key=lambda path: path.name.lower())


def read_valid_table_specs(
    excel_directory: Path, scope_name: str, warnings: list[str]
) -> list[TableSpec]:
    """逐个读取工作簿，跳过结构无效或无法访问的单张配置表。"""
    tables: list[TableSpec] = []
    for workbook_path in discover_workbooks(excel_directory):
        try:
            tables.append(read_table_spec(workbook_path))
        except (GenerationError, OSError) as error:
            warnings.append(
                f"[{scope_name}] 跳过配置类 {workbook_path.stem}：{error}"
            )
    return tables


def read_source(path: Path) -> SourceDocument:
    """读取源码并记录 UTF-8 BOM 与原始换行格式。"""
    raw_data = path.read_bytes()
    has_utf8_bom = raw_data.startswith(b"\xef\xbb\xbf")
    text = raw_data.decode("utf-8-sig")
    newline = "\r\n" if "\r\n" in text else "\n"
    return SourceDocument(path, text, has_utf8_bom, newline)


def write_source_atomically(document: SourceDocument) -> None:
    """保留源码 BOM 与换行格式并通过临时文件原子替换。"""
    normalized_text = document.text.replace("\r\n", "\n").replace(
        "\n", document.newline
    )
    encoded = normalized_text.encode("utf-8")
    if document.has_utf8_bom:
        encoded = b"\xef\xbb\xbf" + encoded
    temporary_path = document.path.with_name(f".{document.path.name}.tmp")
    try:
        temporary_path.write_bytes(encoded)
        os.replace(temporary_path, document.path)
    finally:
        if temporary_path.exists():
            temporary_path.unlink()


def skip_quoted_or_commented_text(text: str, index: int) -> int | None:
    """跳过 C# 字符串、字符字面量和注释，避免花括号计数被内容干扰。"""
    if text.startswith("//", index):
        newline_index = text.find("\n", index + 2)
        return len(text) if newline_index == -1 else newline_index + 1
    if text.startswith("/*", index):
        comment_end = text.find("*/", index + 2)
        return len(text) if comment_end == -1 else comment_end + 2
    if text.startswith('@"', index):
        cursor = index + 2
        while cursor < len(text):
            if text.startswith('""', cursor):
                cursor += 2
                continue
            if text[cursor] == '"':
                return cursor + 1
            cursor += 1
        return len(text)
    if text[index] not in {'"', "'"}:
        return None
    delimiter = text[index]
    cursor = index + 1
    while cursor < len(text):
        if text[cursor] == "\\":
            cursor += 2
            continue
        if text[cursor] == delimiter:
            return cursor + 1
        cursor += 1
    return len(text)


def find_matching_brace(text: str, opening_brace: int) -> int:
    """在忽略字符串和注释的情况下定位匹配的右花括号。"""
    depth = 0
    cursor = opening_brace
    while cursor < len(text):
        skipped_to = skip_quoted_or_commented_text(text, cursor)
        if skipped_to is not None:
            cursor = skipped_to
            continue
        if text[cursor] == "{":
            depth += 1
        elif text[cursor] == "}":
            depth -= 1
            if depth == 0:
                return cursor
        cursor += 1
    raise GenerationError("C# 源码存在未闭合的花括号")


def find_class_blocks(text: str) -> list[ClassBlock]:
    """提取源码中的类名、继承声明及完整类体范围。"""
    blocks: list[ClassBlock] = []
    pattern = re.compile(
        r"\bclass\s+(?P<name>[A-Za-z_]\w*)\s*(?:\:\s*(?P<base>[^\{]+))?\{"
    )
    for match in pattern.finditer(text):
        opening_brace = match.end() - 1
        blocks.append(
            ClassBlock(
                name=match.group("name"),
                base_text=(match.group("base") or "").strip(),
                declaration_start=match.start(),
                body_start=opening_brace,
                body_end=find_matching_brace(text, opening_brace),
            )
        )
    return blocks


def parse_data_singleton_arguments(base_text: str) -> tuple[str, str, str] | None:
    """解析 DataSingleton 的管理类、数据类和主键类型参数。"""
    match = re.search(
        r"\bDataSingleton\s*<\s*([A-Za-z_]\w*)\s*,\s*"
        r"([A-Za-z_]\w*)\s*,\s*([^>]+?)\s*>",
        base_text,
    )
    if match is None:
        return None
    return match.group(1), match.group(2), match.group(3).strip()


def parse_data_config_key_type(base_text: str) -> str | None:
    """解析 DataConfigBase 声明中的主键类型。"""
    match = re.search(r"\bDataConfigBase\s*<\s*([^>]+?)\s*>", base_text)
    return None if match is None else match.group(1).strip()


def find_table_name_in_manager(class_text: str) -> str | None:
    """读取管理类 getTableName 方法返回的字符串表名。"""
    method_match = re.search(
        r"\bgetTableName\s*\([^)]*\)\s*(?:=>\s*\"([^\"]+)\"\s*;|"
        r"\{(?P<body>.*?)\})",
        class_text,
        re.DOTALL,
    )
    if method_match is None:
        return None
    if method_match.group(1):
        return method_match.group(1)
    return_match = re.search(r"\breturn\s+\"([^\"]+)\"\s*;", method_match.group("body"))
    return None if return_match is None else return_match.group(1)


def scan_config_sources(
    config_directory: Path,
) -> tuple[dict[str, ManagerBinding], dict[str, tuple[Path, ClassBlock]]]:
    """扫描目标目录中的管理类映射和数据类位置。"""
    managers: dict[str, ManagerBinding] = {}
    classes: dict[str, tuple[Path, ClassBlock]] = {}
    for source_path in sorted(config_directory.glob("*.cs")):
        document = read_source(source_path)
        for class_block in find_class_blocks(document.text):
            if class_block.name in classes:
                raise GenerationError(f"发现重复 C# 类：{class_block.name}")
            classes[class_block.name] = (source_path, class_block)

            singleton_arguments = parse_data_singleton_arguments(class_block.base_text)
            if singleton_arguments is None:
                continue
            manager_name, config_name, key_type = singleton_arguments
            class_text = document.text[
                class_block.declaration_start : class_block.body_end + 1
            ]
            table_name = find_table_name_in_manager(class_text)
            if table_name is None:
                continue
            if table_name in managers:
                raise GenerationError(f"表 {table_name} 存在多个 ConfigMgr 映射")
            managers[table_name] = ManagerBinding(
                table_name=table_name,
                manager_name=manager_name,
                config_name=config_name,
                key_type=key_type,
                source_path=source_path,
            )
    return managers, classes


def find_existing_properties(class_text: str) -> dict[str, str]:
    """提取数据类已有的公开自动属性及类型。"""
    property_pattern = re.compile(
        r"\bpublic\s+([A-Za-z_][\w\.<>\[\],?]*)\s+([A-Za-z_]\w*)\s*"
        r"\{\s*get\s*;\s*set\s*;\s*\}"
    )
    return {
        match.group(2): match.group(1) for match in property_pattern.finditer(class_text)
    }


def find_declared_member_names(class_text: str) -> set[str]:
    """收集类体中可能与新增属性重名的字段、属性和方法名称。"""
    member_pattern = re.compile(
        r"\b(?:public|protected|private|internal)\s+"
        r"(?:static\s+|readonly\s+|virtual\s+|override\s+|sealed\s+|async\s+)*"
        r"[A-Za-z_][\w\.<>\[\],?]*\s+([A-Za-z_]\w*)\s*(?:[=;\{\(])"
    )
    return {match.group(1) for match in member_pattern.finditer(class_text)}


def xml_summary_lines(comment: str, fallback: str, indentation: str) -> list[str]:
    """生成符合 C# XML 文档规则的中文摘要注释。"""
    summary = comment.strip().rstrip("。") or fallback.strip().rstrip("。")
    escaped_summary = html.escape(summary, quote=False)
    return [
        f"{indentation}/// <summary>",
        f"{indentation}/// {escaped_summary}。",
        f"{indentation}/// </summary>",
    ]


def build_property_source(field: FieldSpec, indentation: str, newline: str) -> str:
    """根据表字段生成带中文 XML 注释的 C# 自动属性。"""
    lines = xml_summary_lines(field.comment, f"{field.name} 配置值", indentation)
    lines.append(
        f"{indentation}public {field.csharp_type} {field.name} {{ get; set; }}"
    )
    return newline.join(lines)


def build_new_config_source(table: TableSpec, newline: str = "\n") -> str:
    """为尚无映射的表生成完整管理类和数据类源码。"""
    manager_name = f"{table.class_prefix}ConfigMgr"
    config_name = f"{table.class_prefix}Config"
    key_type = table.id_field.csharp_type
    lines = [
        "using Xs.Singleton;",
        "",
        "/// <summary>",
        f"/// {html.escape(table.table_name, quote=False)} 配置表管理器。",
        "/// </summary>",
        f"public class {manager_name} : DataSingleton<{manager_name}, {config_name}, {key_type}>",
        "{",
        "    /// <summary>",
        "    /// 返回当前配置类对应的配置表名称。",
        "    /// </summary>",
        f"    /// <returns>配置表名称 {html.escape(table.table_name, quote=False)}。</returns>",
        "    public override string getTableName()",
        "    {",
        f'        return "{table.table_name}";',
        "    }",
        "}",
        "",
        "/// <summary>",
        f"/// {html.escape(table.table_name, quote=False)} 配置表单行数据。",
        "/// </summary>",
        f"public class {config_name} : DataConfigBase<{key_type}>",
        "{",
    ]
    generated_properties = [
        build_property_source(field, "    ", newline)
        for field in table.fields
        if field.name != "Id"
    ]
    if generated_properties:
        lines.append((newline * 2).join(generated_properties))
    lines.extend(["}", ""])
    return newline.join(lines)


def build_new_local_config_source(table: TableSpec, newline: str = "\n") -> str:
    """为 Local 表生成不依赖 HotUpdate 的强类型数据类和管理类。"""
    manager_name = f"{table.class_prefix}ConfigMgr"
    config_name = f"{table.class_prefix}Config"
    lines = [
        "namespace ProjectSpace.Configs.Local",
        "{",
        "    /// <summary>",
        f"    /// {html.escape(table.table_name, quote=False)} 本地配置表管理器。",
        "    /// </summary>",
        f"    public sealed class {manager_name} : LocalConfigTable<{config_name}, {table.id_field.csharp_type}>",
        "    {",
        "        /// <summary>",
        "        /// 获取编译载荷中的原始配置表名。",
        "        /// </summary>",
        f'        public override string TableName => "{table.table_name}";',
        "",
        "        /// <summary>",
        "        /// 获取本地配置记录的唯一 Id。",
        "        /// </summary>",
        f"        protected override {table.id_field.csharp_type} GetKey({config_name} data)",
        "        {",
        "            return data.Id;",
        "        }",
        "    }",
        "",
        "    /// <summary>",
        f"    /// {html.escape(table.table_name, quote=False)} 本地配置表单行数据。",
        "    /// </summary>",
        f"    public sealed class {config_name}",
        "    {",
    ]
    properties = [
        build_property_source(field, "        ", newline) for field in table.fields
    ]
    if properties:
        lines.append((newline * 2).join(properties))
    lines.extend(["    }", "}", ""])
    return newline.join(lines)


def build_local_registry_source(tables: Iterable[TableSpec]) -> str:
    """按稳定顺序生成显式 Local 配置表注册表，避免运行时反射扫描。"""
    ordered_tables = sorted(tables, key=lambda table: table.workbook_path.name.lower())
    lines = [
        "using System.Collections.Generic;",
        "",
        "namespace ProjectSpace.Configs.Local",
        "{",
        "    /// <summary>",
        "    /// 保存当前工作簿生成的全部本地配置表实例。",
        "    /// </summary>",
        "    public static class GeneratedLocalConfigRegistry",
        "    {",
    ]
    for table in ordered_tables:
        manager_name = f"{table.class_prefix}ConfigMgr"
        lines.extend([
            "        /// <summary>",
            f"        /// 获取 {html.escape(table.table_name, quote=False)} 本地配置表。",
            "        /// </summary>",
            f"        public static {manager_name} {table.class_prefix} {{ get; }} = new {manager_name}();",
            "",
        ])
    lines.extend([
        "        /// <summary>",
        "        /// 获取需要在同一轮初始化的全部本地配置表。",
        "        /// </summary>",
        "        public static IReadOnlyList<ILocalConfigTable> All { get; } = new ILocalConfigTable[]",
        "        {",
    ])
    lines.extend(f"            {table.class_prefix}," for table in ordered_tables)
    lines.extend(["        };", "    }", "}", ""])
    return "\n".join(lines)


def add_missing_properties(
    table: TableSpec,
    binding: ManagerBinding,
    classes: dict[str, tuple[Path, ClassBlock]],
    documents: dict[Path, SourceDocument],
    warnings: list[str],
) -> list[str]:
    """向现有数据类追加表中缺失属性，同时保留全部已有成员。"""
    class_location = classes.get(binding.config_name)
    if class_location is None:
        raise GenerationError(
            f"表 {table.table_name} 对应的数据类 {binding.config_name} 不存在"
        )
    source_path, original_block = class_location
    document = documents.setdefault(source_path, read_source(source_path))
    current_blocks = {block.name: block for block in find_class_blocks(document.text)}
    class_block = current_blocks.get(binding.config_name)
    if class_block is None:
        raise GenerationError(f"无法重新定位数据类 {binding.config_name}")

    class_text = document.text[
        class_block.declaration_start : class_block.body_end + 1
    ]
    existing_properties = find_existing_properties(class_text)
    declared_members = find_declared_member_names(class_text)
    data_key_type = parse_data_config_key_type(class_block.base_text)
    expected_key_type = table.id_field.csharp_type
    if binding.key_type != expected_key_type or data_key_type != expected_key_type:
        warnings.append(
            f"表 {table.table_name} 的 Id 类型为 {expected_key_type}，"
            f"现有管理类/数据类为 {binding.key_type}/{data_key_type or '未知'}；保留原代码"
        )

    additions: list[FieldSpec] = []
    for field in table.fields:
        if field.name == "Id":
            continue
        existing_type = existing_properties.get(field.name)
        if existing_type is not None:
            if existing_type != field.csharp_type:
                warnings.append(
                    f"表 {table.table_name} 字段 {field.name} 类型为 {field.csharp_type}，"
                    f"现有属性类型为 {existing_type}；保留原类型"
                )
            continue
        if field.name in declared_members:
            warnings.append(
                f"表 {table.table_name} 字段 {field.name} 与现有成员重名但不是可写自动属性；"
                "未新增以避免编译冲突"
            )
            continue
        additions.append(field)

    if not additions:
        return []

    property_text = (document.newline * 2).join(
        build_property_source(field, "    ", document.newline) for field in additions
    )
    insertion = f"{document.newline}{property_text}{document.newline}"
    document.text = (
        document.text[: class_block.body_end]
        + insertion
        + document.text[class_block.body_end :]
    )
    return [field.name for field in additions]


def add_missing_local_properties(
    table: TableSpec,
    output_path: Path,
    documents: dict[Path, SourceDocument],
    warnings: list[str],
) -> list[str]:
    """向已有 Local 数据类追加缺失属性，同时保留其余手写成员。"""
    document = documents.setdefault(output_path, read_source(output_path))
    config_name = f"{table.class_prefix}Config"
    manager_name = f"{table.class_prefix}ConfigMgr"
    blocks = {block.name: block for block in find_class_blocks(document.text)}
    config_block = blocks.get(config_name)
    manager_block = blocks.get(manager_name)
    if config_block is None or manager_block is None:
        raise GenerationError(f"Local 文件 {output_path.name} 缺少预期类 {manager_name}/{config_name}")
    if "LocalConfigTable" not in manager_block.base_text:
        raise GenerationError(f"Local 管理类 {manager_name} 未继承 LocalConfigTable")
    class_text = document.text[config_block.declaration_start : config_block.body_end + 1]
    existing_properties = find_existing_properties(class_text)
    declared_members = find_declared_member_names(class_text)
    additions: list[FieldSpec] = []
    for field in table.fields:
        existing_type = existing_properties.get(field.name)
        if existing_type is not None:
            if existing_type != field.csharp_type:
                warnings.append(
                    f"Local 表 {table.table_name} 字段 {field.name} 类型为 {field.csharp_type}，"
                    f"现有属性类型为 {existing_type}；保留原类型"
                )
            continue
        if field.name in declared_members:
            warnings.append(
                f"Local 表 {table.table_name} 字段 {field.name} 与现有手写成员重名；未新增"
            )
            continue
        additions.append(field)
    if not additions:
        documents.pop(output_path, None)
        return []
    property_text = (document.newline * 2).join(
        build_property_source(field, "        ", document.newline) for field in additions
    )
    document.text = (
        document.text[: config_block.body_end]
        + document.newline
        + property_text
        + document.newline
        + document.text[config_block.body_end :]
    )
    return [field.name for field in additions]


def build_config_registry_source(manager_names: Iterable[str]) -> str:
    """创建由 ConfigInsResgister 集中持有正式配置表的 C# 源码。"""
    registration_lines = "\n".join(
        f"        {manager_name}.Instance," for manager_name in manager_names
    )
    return f"""using System.Collections.Generic;
using Xs.Singleton;

/// <summary>
/// 统一保存 HotUpdate 启动阶段需要加载的正式配置表，避免入口层依赖具体配置管理器。
/// </summary>
public static class ConfigInsResgister
{{
    private static readonly IReadOnlyList<DataIntetface> Tables = new DataIntetface[]
    {{
{registration_lines}
    }};

    /// <summary>
    /// 获取本轮正式配置加载需要注册的全部配置表实例。
    /// </summary>
    /// <returns>只读的配置表实例列表。</returns>
    public static IReadOnlyList<DataIntetface> GetTables()
    {{
        return Tables;
    }}
}}
"""


def ensure_manager_registrations(
    config_register_path: Path,
    manager_names: Iterable[str],
    documents: dict[Path, SourceDocument],
) -> list[str]:
    """在 ConfigInsResgister 的只读列表中幂等追加缺失的配置管理器。"""
    manager_names = list(manager_names)
    if not config_register_path.exists() and config_register_path not in documents:
        documents[config_register_path] = SourceDocument(
            config_register_path,
            build_config_registry_source(manager_names),
            False,
            "\n",
        )
        return manager_names

    document = documents.setdefault(
        config_register_path, read_source(config_register_path)
    )
    initializer_match = re.search(
        r"\bTables\s*=\s*new\s+DataIntetface\s*\[\s*\]\s*", document.text
    )
    if initializer_match is None:
        raise GenerationError("无法定位 ConfigInsResgister.Tables 初始化列表")
    initializer_start = document.text.find("{", initializer_match.end())
    if initializer_start == -1:
        raise GenerationError("ConfigInsResgister.Tables 缺少初始化体")
    initializer_end = find_matching_brace(document.text, initializer_start)
    initializer_text = document.text[initializer_start : initializer_end + 1]
    missing_manager_names = [
        manager_name
        for manager_name in manager_names
        if re.search(
            rf"\b{re.escape(manager_name)}\.Instance\s*,", initializer_text
        )
        is None
    ]
    if not missing_manager_names:
        return []

    registration_matches = list(
        re.finditer(
            r"^[ \t]*[A-Za-z_][A-Za-z0-9_]*ConfigMgr\.Instance\s*,[ \t]*$",
            initializer_text,
            re.MULTILINE,
        )
    )
    if registration_matches:
        insertion_index = initializer_start + registration_matches[-1].end()
        indentation_match = re.match(r"[ \t]*", registration_matches[-1].group(0))
        indentation = indentation_match.group(0) if indentation_match else "        "
        prefix = document.newline
    else:
        insertion_index = initializer_start + 1
        indentation = "        "
        prefix = document.newline

    registration_text = prefix + document.newline.join(
        f"{indentation}{manager_name}.Instance,"
        for manager_name in missing_manager_names
    )
    document.text = (
        document.text[:insertion_index]
        + registration_text
        + document.text[insertion_index:]
    )
    return missing_manager_names


def build_generation_plan(
    excel_directory: Path,
    config_directory: Path,
    config_register_path: Path,
    local_excel_directory: Path | None = None,
    local_config_directory: Path | None = None,
) -> tuple[dict[Path, SourceDocument], list[str], list[str]]:
    """构建 HotUpdate 与 Local 的生成计划，单表失败时跳过并继续。"""
    warnings: list[str] = []
    tables = read_valid_table_specs(excel_directory, "HotUpdate", warnings)
    managers, classes = scan_config_sources(config_directory)
    documents: dict[Path, SourceDocument] = {}
    actions: list[str] = []
    manager_names: list[str] = []

    for table in tables:
        action_count = len(actions)
        warning_count = len(warnings)
        manager_count = len(manager_names)
        original_documents = {
            path: SourceDocument(
                document.path,
                document.text,
                document.has_utf8_bom,
                document.newline,
            )
            for path, document in documents.items()
        }
        try:
            binding = managers.get(table.table_name)
            if binding is None:
                manager_name = f"{table.class_prefix}ConfigMgr"
                config_name = f"{table.class_prefix}Config"
                if manager_name in classes or config_name in classes:
                    raise GenerationError(
                        f"表 {table.table_name} 的预期类名已被其他映射占用："
                        f"{manager_name}/{config_name}"
                    )
                output_path = config_directory / f"{manager_name}.cs"
                if output_path.exists():
                    raise GenerationError(f"目标文件已存在但未识别到表映射：{output_path}")
                documents[output_path] = SourceDocument(
                    path=output_path,
                    text=build_new_config_source(table),
                    has_utf8_bom=False,
                    newline="\n",
                )
                manager_names.append(manager_name)
                actions.append(f"[HotUpdate] 新增 {output_path.name}，映射表 {table.table_name}")
                continue

            manager_names.append(binding.manager_name)
            added_fields = add_missing_properties(
                table, binding, classes, documents, warnings
            )
            if added_fields:
                actions.append(f"[HotUpdate] 更新 {binding.config_name}，新增字段：{', '.join(added_fields)}")
            else:
                actions.append(f"[HotUpdate] 跳过表 {table.table_name}：配置字段已覆盖")
        except (GenerationError, OSError) as error:
            documents = original_documents
            del actions[action_count:]
            del warnings[warning_count:]
            del manager_names[manager_count:]
            warnings.append(
                f"[HotUpdate] 跳过配置类 {table.table_name}：{error}"
            )

    registered_managers = ensure_manager_registrations(
        config_register_path, manager_names, documents
    )
    if registered_managers:
        actions.append(f"[HotUpdate] 补齐运行时注册：{', '.join(registered_managers)}")
    else:
        actions.append("[HotUpdate] 运行时注册已完整")

    if local_excel_directory is None or local_config_directory is None:
        return documents, actions, warnings

    local_tables = read_valid_table_specs(local_excel_directory, "Local", warnings)
    existing_local_classes: dict[str, Path] = {}
    if local_config_directory.exists():
        for source_path in sorted(local_config_directory.glob("*.cs")):
            for class_block in find_class_blocks(read_source(source_path).text):
                existing_local_classes[class_block.name] = source_path
    local_class_names: set[str] = set()
    successful_local_tables: list[TableSpec] = []
    for table in local_tables:
        action_count = len(actions)
        warning_count = len(warnings)
        original_documents = {
            path: SourceDocument(
                document.path,
                document.text,
                document.has_utf8_bom,
                document.newline,
            )
            for path, document in documents.items()
        }
        try:
            manager_name = f"{table.class_prefix}ConfigMgr"
            config_name = f"{table.class_prefix}Config"
            if manager_name in local_class_names or config_name in local_class_names:
                raise GenerationError(f"Local 表类名冲突：{manager_name}/{config_name}")
            output_path = local_config_directory / f"{manager_name}.cs"
            for class_name in (manager_name, config_name):
                occupied_path = existing_local_classes.get(class_name)
                if occupied_path is not None and occupied_path != output_path:
                    raise GenerationError(
                        f"Local 类名 {class_name} 已被文件 {occupied_path.name} 占用"
                    )
            expected_text = build_new_local_config_source(table)
            if output_path.exists():
                added_fields = add_missing_local_properties(
                    table, output_path, documents, warnings
                )
                if added_fields:
                    actions.append(
                        f"[Local] 更新 {config_name}，新增字段：{', '.join(added_fields)}"
                    )
                else:
                    actions.append(f"[Local] 跳过表 {table.table_name}：配置字段已覆盖")
            else:
                documents[output_path] = SourceDocument(output_path, expected_text, False, "\n")
                actions.append(f"[Local] 新增 {output_path.name}，映射表 {table.table_name}")
            local_class_names.update({manager_name, config_name})
            successful_local_tables.append(table)
        except (GenerationError, OSError) as error:
            documents = original_documents
            del actions[action_count:]
            del warnings[warning_count:]
            warnings.append(
                f"[Local] 跳过配置类 {table.table_name}：{error}"
            )

    registry_path = local_config_directory / "GeneratedLocalConfigRegistry.cs"
    registry_text = build_local_registry_source(successful_local_tables)
    registry_document = read_source(registry_path) if registry_path.exists() else SourceDocument(registry_path, "", False, "\n")
    if registry_document.text != registry_text:
        registry_document.text = registry_text
        documents[registry_path] = registry_document
        actions.append("[Local] 更新 GeneratedLocalConfigRegistry.cs")
    else:
        actions.append("[Local] 注册表已完整")
    expected_files = {
        f"{table.class_prefix}ConfigMgr.cs" for table in successful_local_tables
    }
    if local_config_directory.exists():
        for source_path in sorted(local_config_directory.glob("*ConfigMgr.cs")):
            if source_path.name not in expected_files:
                warnings.append(
                    f"发现未对应当前 Local 工作簿的旧生成文件 {source_path.name}；为保护手写成员未删除"
                )
    return documents, actions, warnings


def apply_generation_plan(
    documents: dict[Path, SourceDocument], dry_run: bool
) -> None:
    """原子应用完整生成计划，任一写入失败时恢复所有目标文件。"""
    if dry_run:
        return
    original_files = {
        path: path.read_bytes() if path.exists() else None for path in documents
    }
    try:
        for path in sorted(documents, key=lambda item: str(item)):
            document = documents[path]
            path.parent.mkdir(parents=True, exist_ok=True)
            write_source_atomically(document)
    except OSError:
        for path, original_data in original_files.items():
            if original_data is None:
                if path.exists():
                    path.unlink()
            else:
                path.write_bytes(original_data)
        raise


def parse_arguments(argv: list[str]) -> argparse.Namespace:
    """解析预览模式和可选路径覆盖参数。"""
    parser = argparse.ArgumentParser(
        description="根据 Excle 直属配置表增量生成 C# 配置类并补齐注册。"
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="只显示将执行的操作，不创建或修改文件。",
    )
    parser.add_argument(
        "--excel-dir",
        type=Path,
        help="覆盖配置工作簿目录，默认使用脚本所在目录。",
    )
    parser.add_argument(
        "--config-dir",
        type=Path,
        help="覆盖 C# 配置类目录。",
    )
    parser.add_argument(
        "--config-register",
        dest="config_register",
        type=Path,
        help="覆盖 ConfigInsResgister.cs 路径。",
    )
    parser.add_argument(
        "--local-excel-dir",
        type=Path,
        help="覆盖 Local 工作簿目录，默认使用主配置目录下的 Local。",
    )
    parser.add_argument(
        "--local-config-dir",
        type=Path,
        help="覆盖主工程 Local 配置类输出目录。",
    )
    return parser.parse_args(argv)


def main(argv: list[str] | None = None) -> int:
    """扫描配置表、增量生成配置类并补齐运行时注册。"""
    arguments = parse_arguments(sys.argv[1:] if argv is None else argv)
    script_directory = Path(__file__).resolve().parent
    excel_directory = (arguments.excel_dir or script_directory).resolve()
    config_directory = (
        arguments.config_dir
        or script_directory.parent
        / "UnityWork"
        / "Assets"
        / "HotUpdate"
        / "Xs"
        / "Config"
    ).resolve()
    config_register_path = (
        arguments.config_register or config_directory.parent / "ConfigInsResgister.cs"
    ).resolve()
    local_excel_directory = (
        arguments.local_excel_dir or excel_directory / "Local"
    ).resolve()
    local_config_directory = (
        arguments.local_config_dir
        or script_directory.parent / "UnityWork" / "Assets" / "Scripts" / "Config"
    ).resolve()

    try:
        documents, actions, warnings = build_generation_plan(
            excel_directory,
            config_directory,
            config_register_path,
            local_excel_directory,
            local_config_directory,
        )
        mode_name = "预览" if arguments.dry_run else "执行"
        print(f"[{mode_name}] 配置类增量生成")
        for action in actions:
            print(f"- {action}")
        for warning in warnings:
            print(f"- 警告：{warning}")
        apply_generation_plan(documents, arguments.dry_run)
        if not arguments.dry_run:
            print("生成完成：未删除任何已有类、字段或成员。")
        return 0
    except (GenerationError, OSError) as error:
        print(f"生成失败：{error}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
