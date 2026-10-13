# Twindoku 1.2.0 深入分析

## 关卡解码

三个文件使用相同的可逆变换。对长度为 `n` 的原始文件：

1. 将最后 `floor(n/5)` 个字节移至开头。
2. 与 ASCII 字节串 `iDailybread.org`（15 字节）循环 XOR。
3. 解析得到的 UTF-8 JSON。
4. 对 Test1/Test2 中每条记录的 `LevelJsonData` 再执行一次 JSON 解析。

该算法来自本样本字节分析；三个文件均经过完整重新编码对比，不依赖猜测的截断文本。校验摘要见 `levels/decode-summary.json`。

| 文件 | 字节数 | 记录数 | 用途 |
| --- | ---: | ---: | --- |
| MainLevel | 74,377 | 400 | 显示关卡到题目 ID 的平台 / 实验映射 |
| Test1 | 308,465 | 400 | ID 1–400 的题目 |
| Test2 | 24,184 | 40 | ID 20001–20040 的备选题目 |

不能将文件名 Test1/Test2 理解为必然不参与运行的测试资源。例如 MainLevel 第 5 条的 `AndroidTest1LevelID=5`、`AndroidTest2GuideLevel5="20036"`；当前实机显示的 12 个给定格匹配 Test1 的第 5 题。实际实验分支选择仍需另行追踪。

全部 440 题中，4×4 有 56 题，6×6 有 322 题，8×8 有 62 题。字段 `s=1` 对应太阳，`s=2` 对应月亮，由第 5 关截图对应关系确认。坐标从 0 开始。

规则键包含 `balance`、`nothree`、`edge`、`region`、`holes`、`edgecount`、`corner`。区域数据同时存在二维矩阵和长度为 size² 的一维数组；必须兼容两种形式。`edge` 数据中 `eq` / `x` 表示相同 / 不同关系。基础规则不包含“任意两行或两列不得重复”的附加约束。

关卡首次出现：edge=7、region=11、holes=19、edgecount=30、corner=40；这是 Test1 数据顺序中的首次出现，不是所有实验分支的统一解锁断言。edgeClues 当前 309 条均为 `first`，但原生枚举还定义 Total / First / MaxRun。其完整语义未在参考适配器中实现。

## 元数据与方法定位

本机同版本 Unity 的 `GlobalMetadataFileInternals.h`、`MetadataDeserialization.cpp` 与样本结构对应：这是使用 section(offset,size,count) 三元组和压缩索引的 metadata v39 布局，不应直接套用旧版 v31 固定宽度解析器。

样本头前 8 字节被改写。成功用于本次解析的恢复规则：前 4096 字节 XOR 0x66；从第二个 64 KiB 块起，每块偏移 [4096,20480) 区间 XOR 0x66。首块 [4096,20480) 仍有额外处理，本次未恢复；它影响一部分 string-literal 索引，因此没有宣称产出了可供通用 dumper 直接加载的完整标准 metadata。

相关类型、方法表、字段表及 metadata 字符串区已能解析。共映射 56,458 个方法表条目（不等于全部都有可执行函数地址）。`Pairzzle.Runtime.dll` CodeGenModule 位于 ELF 虚拟地址 `0x21daf40`，含 5,209 个方法指针，表地址 `0x2334978`。通过 ELF RELA 相对重定位和方法 token 的低 24 位减 1 定位方法指针。

下列地址是本版本 libil2cpp.so 的 ELF 虚拟地址；运行时需加模块加载基址，不适用于其他版本。

## 求解器（原生控制流确认）

| 方法 | 地址 | 行为 |
| --- | --- | --- |
| Solve | `0x1a61eec` | 构造规则集和棋盘，收集空格，用显式深度变量及候选数组回溯 |
| CountCompletions | `0x1a6d3d8` | 克隆状态，计数搜索，达到调用方指定上限即停止 |
| HasUniqueSolution | `0x1a6d730` | 调用 CountCompletions，限制 2 个结果，返回结果是否等于 1 |
| GetLocalHint | `0x1a64258` | 依序对可编辑空格试填 1、2，出现涉及该格的违规则返回相反符号 |
| GetHint | `0x1a6d7cc` | 先局部提示；失败则试填后调用 CountCompletions(limit=1)，无解返回相反符号 |
| CausesOwnViolation | `0x1a6dabc` | 遍历约束的 Violations 结果，检查是否包含本次试填格 |

Solve 搜索时先试 1 再试 2；每次试填调用 RuleSet.HasViolation，失败清零并回退，成功向下一空格推进。没有在所核对的函数中看到最小剩余候选（MRV）选点或随机候选排序。解数与提示逻辑均依赖规则的局部违规判定实现。

`reference_solver.py` 是上述流程的可读重写，不是 IL2CPP 反编译所得原始源代码。它额外增加了初始状态合法性检查，且仅提供基础规则适配器。空洞用 -1 表示，不能跨空洞拼接“三连”窗口。

## 实际游戏提示与通用 GetHint 不同

`PairzzleGameSession.Hint` 位于 `0x1a63b38`：

1. 检查会话状态、缓存解和可编辑空格。
2. BuildReasoningState 克隆当前棋盘，把 IsMistakeCell 判定为错误的格清成空值并锁定，避免错误输入参与推理。
3. 优先调用 GetLocalHint；若没有可用局部提示，则从空白候选中通过会话 `_random` 选格。
4. 最终填入的值来自会话缓存 `_solution`，不是直接盲用局部试填返回值。
5. 生成规则说明，调用 BoardState.Lock 填入并锁定格子，增加 hintsUsed，记录提示操作，再检查完成。
6. 没有空格时转入 HintForMistake 路径。

`PeekHint`（`0x1a647d8`）只给出可用局部提示，不走随机填格后备路径。`BuildReasoningState` 位于 `0x1a641e0`。注意实际 Hint 没有直接调用通用 Solver.GetHint，不能把通用搜索提示流程误当作按钮行为。

`PairzzleHintReasons` 按 Balance / NoThree / Edge / Region / EdgeCount / Corner 生成说明；返回数据包含 LocaleKey、Args、RefCells、RefClues，适合驱动本地化文案和参考格/线索高亮。完整文案与所有参数组合尚未恢复验证。

## 验证与边界

`reports/validation.json` 记录实际运行的验证结果。第 5 关唯一解为（S=太阳，M=月亮）：

```text
MSMMSS
SMSMMS
SMSSMM
MSMMSS
MSMSSM
SMSSMM
```

首个局部提示为 r=1,c=1 填 2（月亮）：该行已有三个太阳，试填太阳会超出配额。第 1 行与第 4 行在此解中相同，这也说明不应凭同类谜题经验加入“行列唯一”规则。

尚未完成：全 440 题的全部规则求解验证；区域/边缘数/角点数的完整可执行移植；所有提示文案；关卡实验与远端配置选择；原生函数运行时插桩比对。静态函数定位和本地参考验证不能替代这些检查。

本次未通过修改游戏数据推进手机关卡，也未在实机消耗提示。
