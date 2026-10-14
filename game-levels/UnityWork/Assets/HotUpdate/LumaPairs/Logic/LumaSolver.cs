using System;
using System.Collections.Generic;
using System.Linq;

namespace LumaPairs
{
    /// <summary>通过约束传播和有界搜索求解；不依赖 Unity、页面或存档。</summary>
    public static class LumaSolver
    {
        /// <summary>返回至多指定数量的解，供初始化和唯一性测试使用。</summary>
        public static List<int[]> Solve(LumaLevel level, int[] board, int limit = 2)
        {
            var result = new List<int[]>();
            int[] domains = board.Select(v => v < 0 ? 0 : v == 0 ? 3 : v == 1 ? 1 : 2).ToArray();
            Search(level, domains, result, limit);
            return result;
        }

        /// <summary>查找能由单条规则直接推出的下一格，并保留规则证据。</summary>
        public static LumaHint Hint(LumaLevel level, int[] board)
        {
            int[] domains = board.Select(v => v < 0 ? 0 : v == 0 ? 3 : v == 1 ? 1 : 2).ToArray();
            foreach (LumaConstraint constraint in level.Constraints)
            {
                foreach (int cell in constraint.Cells.Where(i => board[i] == 0))
                {
                    bool sun = Supports(constraint, domains, cell, 1), moon = Supports(constraint, domains, cell, 2);
                    if (sun != moon) return new LumaHint(level.Id, cell, sun ? 1 : 2, constraint.Rule, constraint.Cells);
                }
            }
            // 复杂组合保留推导事实，不把搜索结果伪称为某条局部规则。
            List<int[]> solutions = Solve(level, board, 1);
            if (solutions.Count == 0) return null;
            int next = Array.FindIndex(board, v => v == 0);
            return next < 0 ? null : new LumaHint(level.Id, next, solutions[0][next], "combined", new[] { next });
        }

        /// <summary>返回当前棋盘直接违反的规则及证据，用于错误格和规则卡反馈。</summary>
        public static LumaConstraint[] Conflicts(LumaLevel level, int[] board)
        {
            int[] domains = board.Select(v => v < 0 ? 0 : v == 0 ? 3 : v == 1 ? 1 : 2).ToArray();
            return level.Constraints.Where(c => !Feasible(c, domains)).ToArray();
        }

        // 独立于约束的存储顺序：只解释本次落子，旧错误仍由棋盘描边展示。
        private static readonly string[] MistakeRulePriority = { "balance", "nothree", "edge", "region", "corner", "edgecount" };
        /// <summary>按固定优先级返回包含本次错误格的一条规则卡；没有直接证据时不提示规则。</summary>
        public static string MistakeRule(LumaLevel level, int[] board, int cell)
        {
            var related = Conflicts(level, board).Where(c => ConflictEvidence(c, board).Contains(cell))
                .Select(c => PuzzleCatalogReader.DisplayRule(c.Rule)).ToArray();
            return MistakeRulePriority.FirstOrDefault(related.Contains);
        }

        /// <summary>行列平衡只标记数量超限的符号；其他冲突保留完整规则证据。</summary>
        public static int[] ConflictEvidence(LumaConstraint conflict, int[] board)
        {
            if (conflict.Rule != "row" && conflict.Rule != "col") return conflict.Cells;
            int limit = conflict.Cells.Length / 2;
            int symbol = conflict.Cells.Count(i => board[i] == 1) > limit ? 1
                : conflict.Cells.Count(i => board[i] == 2) > limit ? 2 : 0;
            return symbol == 0 ? Array.Empty<int>() : conflict.Cells.Where(i => board[i] == symbol).ToArray();
        }

        /// <summary>检查某个候选值是否满足一个约束的可行范围。</summary>
        private static bool Supports(LumaConstraint constraint, int[] domains, int cell, int candidate)
        {
            int old = domains[cell];
            domains[cell] = candidate;
            bool valid = Feasible(constraint, domains);
            domains[cell] = old;
            return valid;
        }

        /// <summary>判断约束在当前候选域下是否仍存在满足方式。</summary>
        private static bool Feasible(LumaConstraint c, int[] d)
        {
            if (c.Symbol == 0) return (d[c.Cells[0]] & d[c.Cells[1]]) != 0;
            if (c.Symbol == -1) return ((d[c.Cells[0]] & 1) != 0 && (d[c.Cells[1]] & 2) != 0) || ((d[c.Cells[0]] & 2) != 0 && (d[c.Cells[1]] & 1) != 0);
            if (c.Symbol == -2) return !(d[c.Cells[0]] == d[c.Cells[1]] && d[c.Cells[1]] == d[c.Cells[2]] && d[c.Cells[0]] != 3);
            int min = 0, max = 0;
            foreach (int i in c.Cells) { if (d[i] == c.Symbol) min++; if ((d[i] & c.Symbol) != 0) max++; }
            return min <= c.Count && max >= c.Count;
        }

        /// <summary>传播所有约束到稳定状态，再选未定格分支。</summary>
        private static void Search(LumaLevel level, int[] domains, List<int[]> result, int limit)
        {
            bool changed;
            do
            {
                changed = false;
                foreach (LumaConstraint constraint in level.Constraints)
                {
                    if (!Feasible(constraint, domains)) return;
                    foreach (int i in constraint.Cells)
                    {
                        if (domains[i] != 3) continue;
                        int allowed = (Supports(constraint, domains, i, 1) ? 1 : 0) | (Supports(constraint, domains, i, 2) ? 2 : 0);
                        if (allowed == 0) return;
                        if (allowed != 3) { domains[i] = allowed; changed = true; }
                    }
                }
            } while (changed);
            int next = Array.FindIndex(domains, d => d == 3);
            if (next < 0) { result.Add(domains.Select(d => d == 0 ? -1 : d).ToArray()); return; }
            for (int value = 1; value <= 2 && result.Count < limit; value++)
            {
                int[] branch = (int[])domains.Clone(); branch[next] = value; Search(level, branch, result, limit);
            }
        }
    }

    /// <summary>提供提示目标、正确符号和应高亮的证据格。</summary>
    public sealed class LumaHint
    {
        public int LevelId { get; }
        public int Cell { get; }
        public int Symbol { get; }
        public string Rule { get; }
        public int[] Evidence { get; }
        /// <summary>保存本次提示的推导依据。</summary>
        public LumaHint(int levelId, int cell, int symbol, string rule, int[] evidence) { LevelId = levelId; Cell = cell; Symbol = symbol; Rule = rule; Evidence = evidence; }
    }
}
