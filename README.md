# Logicdoku — Twindoku 关卡恢复与逻辑分析

基于 Android Twindoku **1.2.0（versionCode 5）** / `com.oakever.pairzzle` 的本地 APK 分析，日期 2026-10-13。引擎为 Unity 6000.3.16f1 / ARM64 IL2CPP。

已恢复 **400 条关卡映射、440 道题目**，并定位原生求解器与提示控制流。这里的 Python 是分析工具和可读参考实现，**不是原始 C# 源码，也不是完整游戏工程**。

## 文件

| 路径 | 内容 |
| --- | --- |
| `levels/MainLevel.json` | 400 条 iOS / Android 关卡及实验映射 |
| `levels/Test1.json`、`Test2.json` | 解码后的原始表，分别 400 / 40 条 |
| `levels/Test1.puzzles.json`、`Test2.puzzles.json` | 将 `LevelJsonData` 再解析一层后的题目对象 |
| `raw_levels/` | 提取后的三个原始关卡 TextAsset，用于复现解码和往返校验 |
| `scripts/decode_levels.py` | 解码、导出及逐字节重新编码校验 |
| `scripts/reference_solver.py` | 搜索与提示参考实现，基础规则适配器 |
| `scripts/validate_levels.py` | 全题库结构、映射引用与第 5 关验证 |
| `scripts/read_metadata.py`、`native_index.py` | 本样本元数据解析与 ARM64 函数定位 |
| `scripts/extract_assets.py` | Unity AssetBundle TextAsset 提取及对象索引 |
| `evidence/native/` | 核心方法的带地址反汇编证据 |
| `docs/analysis.md` | 格式、求解器、提示流程与分析边界 |

## 运行

题库解码和基础校验只需要 Python 3.10+，不需要连接手机：

```sh
python3 scripts/decode_levels.py
python3 scripts/validate_levels.py
python3 scripts/reference_solver.py --level 5
```

APK / 原生分析另需 `pip install -r requirements-analysis.txt`。这些脚本默认从仓库根下的 `extracted/assets/` 和 `extracted/lib/arm64-v8a/libil2cpp.so` 读取本地提取文件；先运行 `read_metadata.py`，再运行 `native_index.py`。APK、原生二进制、设备信息、广告配置和完整美术资源不包含在本仓库中。

## 验证范围

- 三个关卡文件均通过 JSON 解析、重新编码与原始字节一致的校验。
- 440 题均通过坐标、给定格、区域数组形状等结构校验；400 条映射引用均存在。
- 第 5 关给定格与实机一致，基础规则下唯一解；首个局部提示为第 2 行第 2 列填月亮。
- 其余 439 题没有宣称已完成全规则求解或唯一性验证。
- 参考适配器仅实现 `balance`、`nothree`、`edge`、`holes`；遇到 `region`、`edgecount`、`corner` 会明确报未实现，避免错误解题。
- 文本中的 `?` 保留原始解码值，例如 `LevelSize` 为 `6?6`；程序应使用题目数值字段 `size`。
