# 我们游戏的关卡结构与维护工具源码

本目录保存我们游戏项目中提取的实际 C# 关卡代码、400 关配置和维护脚本。当前内容版本为 `mixed400-20261012`，提取日期为 2026-10-14。

仓库根目录的 `levels/`、`raw_levels/`、`scripts/` 和 `evidence/` 属于竞品 APK 分析；本目录 `game-levels/` 属于我们游戏的实现，两者分别维护。

## 目录命名

| 路径 | 含义 |
| --- | --- |
| `UnityWork/Assets/HotUpdate/LumaPairs/Logic/` | 关卡模型、解析、规则求解、提示与游戏会话源码 |
| `UnityWork/Assets/HotUpdate/Xs/Config/` | 四张业务表的 C# 类型和管理器 |
| `Excle/` | 可编辑 XLSM 配置表及 Python 配置编译工具；保留原项目拼写以兼容脚本路径 |
| `tools/levels/` | 关卡导入、工作簿导出与 XLSM 转换脚本，即现有关卡维护工具 |
| `artifacts/levels/cuddledoku/` | 正式自主关卡与主题 JSON；保留现有协议和路径命名 |
| `artifacts/levels/source/mixed-four-400/` | 当前批次的冻结来源、课程顺序及来源记录 |
| `schemas/` | 关卡及主题 JSON Schema |
| `tools/tests/LevelCatalog/` | C# 关卡回归测试工程 |
| `AI/Config/` | 原项目配置规范和接入记录 |
| `examples/level-0001.json` | 第一关结构阅读示例，不能独立作为400关目录加载 |
| `SOURCE-MANIFEST.json` | 原仓库提交及原样复制文件的 SHA256 |

`LumaPairs` 是源码命名空间，`cuddledoku` 是已有数据协议名称，`hd-main-*` 是稳定关卡身份；这些名字保留以避免破坏代码引用、协议识别和存档。对外目录统一命名为 `game-levels`。

## 关于“关卡编辑器”

本次提取没有找到独立的可视化关卡编辑器。现有流程为 Excel 配置表配合导入、导出和编译脚本，因此命名为“关卡维护工具”，不宣称提供可运行的编辑器应用。

## 结构与使用边界

```text
关卡结构与维护工具源码提取包

范围与结论
本包从当前本地仓库原样复制，保持仓库相对路径；不修改游戏源码。
未找到独立可视化关卡编辑器。现有维护方式是四张 XLSM 配置表及导入、导出、编译脚本。
AI/Config/自主关卡配置规范.md 明确写明“范围不包含关卡编辑器”。
web/ 是旧版关卡游玩页面，不是编辑器，未作为正式关卡工具收录。
output/cuddledoku-editor.log 是 Unity Editor 日志，不是关卡编辑器代码。

当前实际数据（以 JSON 和源码为准）
版本：mixed400-20261012；400 关、400 个棋盘、2320 条约束。
棋盘：4×4 共57关，6×6 共299关，8×8 共44关。
结构：puzzleRoute.BoardRef -> puzzleBoard.Id；puzzleRoute.ClauseSetRef -> puzzleClause.SetRef。
symbolSkin 独立定义 A/B 对应的图标、名称、落子音效。
Cells 按行优先排列；. 为可填格，# 为空洞，A/B 为固定符号；索引=row*Columns+column。
六种约束：trackBalance 行列等量；runCeiling 禁止连三；districtBalance 区域等量；
pairRelation 相邻同/异；entryPosition 左/上首个指定符号位置；junctionCount 2×2 指定符号数量。
entryPosition.Amount 从1开始，跳过空洞；空洞打断连续。
实际第1关 Cells 为 ..AAAABB...BBAB.，对应：
..AA
AABB
...B
BAB.
注意：原规范中的第1关示例已与当前数据不一致，不要照旧示例覆盖正式数据。
examples/level-0001.json 仅作结构阅读；当前解析器要求整库400关，不能直接加载单关示例。

源码入口
UnityWork/Assets/HotUpdate/LumaPairs/Logic/PuzzleCatalogReader.cs：跨表连接、参数验证、SHA256、BoardLayoutDecoder。
UnityWork/Assets/HotUpdate/LumaPairs/Logic/LumaLevel.cs：运行时关卡模型、约束编译、FromConfig入口。
UnityWork/Assets/HotUpdate/LumaPairs/Logic/LumaSolver.cs：求解、规则检查与提示。
UnityWork/Assets/HotUpdate/LumaPairs/Logic/LumaSession.cs：落子、通关、进度与存档。
UnityWork/Assets/HotUpdate/LumaPairs/Logic/SymbolThemeResolver.cs：符号主题解析。
UnityWork/Assets/HotUpdate/Xs/Config/*ConfigMgr.cs：四表类型与管理器。
UnityWork/Assets/HotUpdate/Xs/ConfigInsResgister.cs：配置注册。
UnityWork/Assets/HotUpdate/LumaPairs/UI/Page/PageLumaPairs.cs：游戏页面加载入口（仅供接入参考，非完整UI依赖）。

维护工具与数据
artifacts/levels/cuddledoku/main.json：正式自主关卡源。
artifacts/levels/cuddledoku/themes.json：主题源；tables.json：工作簿导出中间结构。
schemas/：JSON结构约束。
Excle/puzzleRoute.xlsm、puzzleBoard.xlsm、puzzleClause.xlsm、symbolSkin.xlsm：可编辑配置表。
tools/levels/import-mixed-catalog.mjs：读取指定源目录的400关完整配置.json、课程顺序.json，生成自主结构。
tools/levels/export-workbooks.mjs：通过 @oai/artifact-tool 从 tables.json 生成工作簿。
tools/levels/Export-Xlsm.ps1：将中间 XLSX 转为最终 XLSM 容器，需要 PowerShell。
Excle/一键生成配置类.py：生成配置C#类型及注册。
Excle/一键编译.py：编译配置，写入 Remote/Config 与 Unity StreamingAssets/HotUpdate/Config。
artifacts/levels/source/mixed-four-400/：冻结来源、答案、课程顺序及溯源信息。

数据链路
自主源 -> tables.json -> XLSM -> Python编译 -> gamedata.json -> ConfigMgr ->
PuzzleCatalogReader.Build -> LumaLevel -> LumaSolver/LumaSession。
直接改棋盘或约束时必须同步重算 PuzzleHash；仅改Excel不会自动回写自主JSON。
导入脚本用于当前固定批次，不能当作通用可视化编辑器。

提取包边界与验证
这是源码及数据提取包，不是可直接运行的独立编辑器或完整Unity工程。
保留原脚本和工程路径；不要在这个精简包中直接运行发布编译替换正式配置（只包含四张业务表）。
C#回归工程 tools/tests/LevelCatalog 依赖 .NET 8 及原工程 Library/PackageCache 下的 Newtonsoft.Json.dll；包中不含该缓存。
本次验证了所有复制文件SHA256一致、400关题面指纹一致、ZIP完整性；未执行Unity或C#求解回归。
SOURCE-MANIFEST.json 记录原仓库提交与逐文件校验值。
```
