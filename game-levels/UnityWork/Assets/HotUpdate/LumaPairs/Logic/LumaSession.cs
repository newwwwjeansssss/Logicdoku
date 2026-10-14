using System;
using System.Linq;
using System.Collections.Generic;
using System.Security.Cryptography;
using System.Text;
using Newtonsoft.Json;

namespace LumaPairs
{
    /// <summary>保存可迁移的单机进度；由框架 UserData 统一落盘。</summary>
    public sealed class LumaProgress
    {
        public int Version = 1;
        public string LevelSetVersion;
        public string PuzzleKey;
        public string PuzzleHash;
        public int Level = 1;
        public int Hearts = 3;
        public int HintCount = 3;
        public int[] Board;
        public bool Completed;
        public bool TutorialSeen;
        public bool FirstLifeLostGuideShown;
        public int GuideVersion;
        public bool GuideActive;
        public string[] SeenRules;
        public string[] SeenFeatures;
        public double ElapsedSeconds;
        public int Steps, Combo, BestCombo;
        public int RuleDemoStep;
        public int[] SeenRuleDemos;
        public string[] SeenDemoRules;
        public string TutorialCatalogHash;
        public int[] TutorialFirstStages;
    }

    /// <summary>独立于界面的游戏操作，包括判错、提示、复活和过关。</summary>
    public sealed class LumaSession
    {
        private readonly LumaLevel[] levels;
        private readonly Action<string> persist;
        private LumaProgress progress;
        private int[] solution;
        private LumaHint[] guidePlan = Array.Empty<LumaHint>();
        private LumaHint weakGuide;
        private static readonly string[] DemoRules = { "edge", "region", "holes", "edgecount", "corner" };
        private string tutorialCatalogHash;
        private int[] tutorialFirstStages;
        public event Action Changed;
        public LumaLevel Level => levels[progress.Level - 1];
        public int Hearts => progress.Hearts;
        public bool LastMoveWasFirstLifeLoss { get; private set; }
        public int HintCount => progress.HintCount;
        public int LevelNumber => progress.Level;
        public int LevelCount => levels.Length;
        public bool Completed => progress.Completed;
        public bool Won => progress.Board.SequenceEqual(solution);
        public bool HasHearts => LevelNumber >= 5;
        public bool HasHints => LevelNumber >= 3;
        public double ElapsedSeconds => progress.ElapsedSeconds;
        public int Steps => progress.Steps;
        public int BestCombo => progress.BestCombo;
        public string CurrentRuleDemoKey => DemoRules.FirstOrDefault(rule =>
            tutorialFirstStages[Array.IndexOf(DemoRules, rule)] > 0 &&
            LevelNumber >= tutorialFirstStages[Array.IndexOf(DemoRules, rule)] && HasMechanic(Level, rule) &&
            !(progress.SeenDemoRules ?? Array.Empty<string>()).Contains(rule));
        public int RuleDemoStepCount => CurrentRuleDemoKey == null ? 0 : 1;
        public bool NeedsRuleDemo => !Won && CurrentRuleDemoKey != null;
        public int RuleDemoStep => NeedsRuleDemo ? progress.RuleDemoStep : -1;

        /// <summary>只累加实际游戏时间；界面负责在主页、弹窗和后台停止送入时间。</summary>
        public void Tick(double seconds)
        {
            if (Won || Failed || NeedsRuleDemo || double.IsNaN(seconds) || double.IsInfinity(seconds) || seconds <= 0) return;
            progress.ElapsedSeconds += seconds;
        }
        /// <summary>保存时钟但不触发整页重绘，由框架统一标脏落盘。</summary>
        public void Checkpoint() { StampPuzzle(); persist?.Invoke(JsonConvert.SerializeObject(progress)); }

        /// <summary>演示不写棋盘，不增加步数；每次点击推进一个规则示例。</summary>
        public void AdvanceRuleDemo()
        {
            if (!NeedsRuleDemo) return;
            string rule = CurrentRuleDemoKey;
            progress.SeenDemoRules = (progress.SeenDemoRules ?? Array.Empty<string>()).Union(new[] { rule }).ToArray();
            progress.RuleDemoStep = 0;
            progress.TutorialSeen = true;
            progress.SeenRules = (progress.SeenRules ?? Array.Empty<string>()).Union(new[] { "balance", "nothree", rule }).ToArray();
            Save();
        }
        public string PendingFeature => LevelNumber == 3 && !(progress.SeenFeatures ?? Array.Empty<string>()).Contains("hint") ? "hint" : null;
        public void FinishFeatureTutorial()
        {
            string feature = PendingFeature;
            if (feature == null) return;
            progress.SeenFeatures = (progress.SeenFeatures ?? Array.Empty<string>()).Union(new[] { feature }).ToArray(); Save();
        }
        public bool Failed => Hearts == 0;
        public bool NeedsGuidedTutorial => LevelNumber == 1 && !Won && progress.GuideVersion < 1;
        public int GuideStep => !progress.GuideActive || !NeedsGuidedTutorial ? -1 : Array.FindIndex(guidePlan, hint => progress.Board[hint.Cell] != solution[hint.Cell]);
        public int GuideCell => GuideStep < 0 ? -1 : guidePlan[GuideStep].Cell;
        public int GuideSymbol => GuideStep < 0 ? 0 : guidePlan[GuideStep].Symbol;
        public string GuideRule => GuideStep < 0 ? null : guidePlan[GuideStep].Rule;
        public bool IsGuideEvidence(int cell) => GuideStep >= 0 && guidePlan[GuideStep].Evidence.Contains(cell);

        /// <summary>进入首关实操引导；从已保存的棋盘恢复尚未完成的一步。</summary>
        public void BeginTutorial()
        {
            if (!NeedsGuidedTutorial) return;
            progress.GuideActive = true;
            CompleteGuideIfReady();
            Save();
        }

        private void CompleteGuideIfReady()
        {
            if (!progress.GuideActive || guidePlan.Any(hint => progress.Board[hint.Cell] != solution[hint.Cell])) return;
            progress.GuideActive = false; progress.GuideVersion = 1;
            progress.TutorialSeen = true;
            progress.SeenRules = (progress.SeenRules ?? Array.Empty<string>()).Union(Level.Rules).ToArray();
        }
        public bool TutorialSeen => progress.TutorialSeen;
        public bool NeedsTutorial => !TutorialSeen || Level.Rules.Except(progress.SeenRules ?? Array.Empty<string>()).Any();

        /// <summary>恢复合法存档，保留玩家待修正的错误符号，但不接受改变预填格或空洞。</summary>
        public LumaSession(LumaLevel[] levels, string archive, Action<string> persist)
        {
            if (levels == null || levels.Length == 0) throw new ArgumentException("Level configuration is empty.", nameof(levels));
            this.levels = levels;
            this.persist = persist;
            try { progress = JsonConvert.DeserializeObject<LumaProgress>(archive ?? "") ?? new LumaProgress(); }
            catch (JsonException) { progress = new LumaProgress(); }
            if (progress.Version != 1 || progress.Level < 1 || progress.Level > levels.Length) progress = new LumaProgress();
            if (!string.IsNullOrEmpty(progress.PuzzleKey))
            {
                int restoredIndex = Array.FindIndex(levels, level => level.PuzzleKey == progress.PuzzleKey);
                if (restoredIndex >= 0) progress.Level = restoredIndex + 1;
            }
            progress.Hearts = Math.Max(0, Math.Min(3, progress.Hearts));
            progress.HintCount = Math.Max(0, progress.HintCount);
            bool curriculumChanged = InitializeTutorialCatalog();
            LoadSolution();
            // Legacy saves can accidentally satisfy new givens: always migrate by identity/hash.
            // A theme, localization or serialization-only change never changes PuzzleHash.
            bool migrate = !string.IsNullOrEmpty(archive) &&
                (string.IsNullOrEmpty(progress.LevelSetVersion) || progress.PuzzleHash != Level.PuzzleHash);
            bool metadataChanged = progress.LevelSetVersion != Level.ContentTag || progress.PuzzleKey != Level.PuzzleKey;
            if (migrate)
            {
                progress.Board = (int[])Level.Initial.Clone(); progress.Hearts = 3;
                progress.Completed = false; progress.GuideActive = false; ResetStatistics();
            }
            if (progress.Board == null || progress.Board.Length != Level.Initial.Length || progress.Board.Where((v, i) => (Level.Initial[i] != 0 && v != Level.Initial[i]) || (v < 0 && Level.Initial[i] >= 0) || v > 2).Any())
            { progress.Board = (int[])Level.Initial.Clone(); progress.Hearts = 3; progress.Completed = false; ResetStatistics(); }
            if (progress.Level != levels.Length || !Won) progress.Completed = false;
            if (double.IsNaN(progress.ElapsedSeconds) || double.IsInfinity(progress.ElapsedSeconds) || progress.ElapsedSeconds < 0) progress.ElapsedSeconds = 0;
            progress.Steps = Math.Max(0, progress.Steps);
            progress.Combo = Math.Max(0, Math.Min(progress.Steps, progress.Combo));
            progress.BestCombo = Math.Max(progress.Combo, Math.Min(progress.Steps, progress.BestCombo));
            progress.RuleDemoStep = Math.Max(0, Math.Min(Math.Max(0, RuleDemoStepCount - 1), progress.RuleDemoStep));
            StampPuzzle();
            if (migrate || metadataChanged || curriculumChanged) Checkpoint();
        }

        /// <summary>只读访问一个格子的当前符号。</summary>
        public int Cell(int index) => progress.Board[index];
        /// <summary>错误标记来自当前棋盘，重进关卡和读档后仍保持，清空或修正后消失。</summary>
        public bool IsWrongCell(int index) => Level.Initial[index] == 0 && progress.Board[index] > 0 && progress.Board[index] != solution[index];
        public bool CanSelectCell(int index) => index >= 0 && index < progress.Board.Length && !Won && !Failed && !NeedsRuleDemo && Level.Initial[index] == 0
            && (progress.Board[index] == 0 || IsWrongCell(index)) && (GuideStep < 0 || index == GuideCell);
        public bool CanSelectSymbol(int index, int symbol) => CanSelectCell(index) && symbol >= 1 && symbol <= 2
            && progress.Board[index] != symbol && (GuideStep < 0 || symbol == GuideSymbol);
        /// <summary>返回副本供规则验证，避免页面修改状态。</summary>
        public int[] Snapshot() => (int[])progress.Board.Clone();

        /// <summary>提交一次选择；错误符号保留供玩家清除，生命关扣心，结束后拒绝落子。</summary>
        public bool Place(int index, int symbol)
        {
            LastMoveWasFirstLifeLoss = false;
            if (Failed || Won || NeedsRuleDemo || index < 0 || index >= progress.Board.Length || Level.Initial[index] != 0 || symbol < 1 || symbol > 2 || progress.Board[index] == symbol) return false;
            if (GuideStep >= 0 && (index != GuideCell || symbol != GuideSymbol)) return false;
            bool correct = solution[index] == symbol;
            progress.Steps++;
            progress.Combo = correct ? progress.Combo + 1 : 0;
            progress.BestCombo = Math.Max(progress.BestCombo, progress.Combo);
            progress.Board[index] = symbol;
            if (!correct && HasHearts)
            {
                progress.Hearts--;
                LastMoveWasFirstLifeLoss = !progress.FirstLifeLostGuideShown;
                progress.FirstLifeLostGuideShown = true;
            }
            CompleteGuideIfReady();
            Save();
            return correct;
        }

        /// <summary>点击已填的玩家格清空，计一步但不扣心，并结束当前连续正确段。</summary>
        public bool ClearCell(int index)
        {
            if (Won || Failed || NeedsRuleDemo || GuideStep >= 0 || index < 0 || index >= progress.Board.Length || Level.Initial[index] != 0 || progress.Board[index] == 0) return false;
            progress.Board[index] = 0; progress.Steps++; progress.Combo = 0; Save(); return true;
        }

        /// <summary>预览有依据的下一步；确认应用时才扣除库存。</summary>
        public LumaHint GetHint()
        {
            if (Failed || Won || progress.HintCount <= 0) return null;
            int wrong = -1;
            for (int i = 0; i < solution.Length; i++) if (progress.Board[i] > 0 && progress.Board[i] != solution[i]) { wrong = i; break; }
            return wrong >= 0 ? new LumaHint(Level.Id, wrong, solution[wrong], "combined", new[] { wrong }) : LumaSolver.Hint(Level, progress.Board);
        }

        /// <summary>前两关从实际题面生成一次弱提示；目标完成后退出，不锁定输入。</summary>
        public LumaHint GetWeakGuide()
        {
            if (weakGuide == null || Won || Failed || NeedsRuleDemo || NeedsGuidedTutorial || Cell(weakGuide.Cell) != 0) return null;
            // A manually played conflicting board must not display an outdated explanation.
            if (progress.Board.Where((value, cell) => value > 0 && value != solution[cell]).Any()) return null;
            if (LevelNumber == 1 && guidePlan.Any(h => Cell(h.Cell) != h.Symbol)) return null;
            return weakGuide;
        }

        /// <summary>清除关卡和引导存档，保留语言、音频等框架设置。</summary>
        public void ResetProgress()
        {
            progress = new LumaProgress(); LoadSolution(); progress.Board = (int[])Level.Initial.Clone(); Save();
        }

        /// <summary>GM 跳到指定关卡的首次进入状态，便于重复检查解锁引导。</summary>
        public bool JumpToLevel(int level)
        {
            if (level < 1 || level > levels.Length) return false;
            progress = new LumaProgress { Level = level, HintCount = progress.HintCount, FirstLifeLostGuideShown = progress.FirstLifeLostGuideShown };
            LoadSolution(); progress.Board = (int[])Level.Initial.Clone(); Save();
            return true;
        }

        /// <summary>应用当前棋盘仍有效的提示，防止过期提示写入其他关卡。</summary>
        public bool ApplyHint(LumaHint hint)
        {
            if (progress.HintCount <= 0 || Failed || Won || NeedsRuleDemo || hint == null || hint.LevelId != Level.Id || hint.Cell < 0 || hint.Cell >= solution.Length || Level.Initial[hint.Cell] != 0 || progress.Board[hint.Cell] == solution[hint.Cell] || solution[hint.Cell] != hint.Symbol) return false;
            if (GuideStep >= 0 && (hint.Cell != GuideCell || hint.Symbol != GuideSymbol)) return false;
            progress.HintCount--;
            return Place(hint.Cell, hint.Symbol);
        }

        /// <summary>保留已完成格子，恢复三颗心继续当前关。</summary>
        public void Revive() { if (!Failed) return; progress.Hearts = 3; Save(); }
        /// <summary>清空当前关的玩家填写，恢复初始棋盘和心数。</summary>
        public void Restart() { progress.Board = (int[])Level.Initial.Clone(); progress.Hearts = 3; progress.Completed = false; ResetStatistics(); Save(); }

        private void ResetStatistics() { progress.ElapsedSeconds = 0; progress.Steps = progress.Combo = progress.BestCombo = 0; progress.RuleDemoStep = 0; }

        /// <summary>仅在当前关通过后推进；最后一关保持完成状态。</summary>
        public void Advance()
        {
            if (!Won) return;
            if (progress.Level == levels.Length) { progress.Completed = true; Save(); return; }
            progress.Level++; LoadSolution(); progress.Board = (int[])Level.Initial.Clone(); progress.Hearts = 3; ResetStatistics(); Save();
        }

        /// <summary>记录教学完成，避免重新启动反复显示。</summary>
        public void FinishTutorial() { progress.TutorialSeen = true; progress.SeenRules = (progress.SeenRules ?? Array.Empty<string>()).Union(Level.Rules).ToArray(); Save(); }

        /// <summary>验证关卡可解，缓存答案供即时判错。</summary>
        private void LoadSolution()
        {
            var solutions = LumaSolver.Solve(Level, Level.Initial, 1);
            if (solutions.Count == 0) throw new InvalidOperationException("Unsolvable level " + Level.Id);
            solution = solutions[0];
            guidePlan = Array.Empty<LumaHint>(); weakGuide = null;
            if (LevelNumber > 2) return;
            int[] board = (int[])Level.Initial.Clone();
            var plan = new List<LumaHint>();
            if (LevelNumber == 1)
                for (int i = 0; i < 3; i++)
                {
                    var hint = LumaSolver.Hint(Level, board);
                    if (hint == null) break;
                    plan.Add(hint); board[hint.Cell] = hint.Symbol;
                }
            guidePlan = plan.ToArray(); weakGuide = LumaSolver.Hint(Level, board);
        }

        private static bool HasMechanic(LumaLevel level, string rule)
        {
            switch (rule)
            {
                case "edge": return level.Edges.Count > 0;
                case "region": return level.Regions.Any(v => v >= 0);
                case "holes": return level.Initial.Any(v => v < 0);
                case "edgecount": return level.Clues.Any(c => !c.Corner);
                case "corner": return level.Clues.Any(c => c.Corner);
                default: return false;
            }
        }

        /// <summary>索引随题库内容/顺序失效；已学习状态只按玩法保存，与关号无关。</summary>
        private bool InitializeTutorialCatalog()
        {
            using (var sha = SHA256.Create())
                tutorialCatalogHash = BitConverter.ToString(sha.ComputeHash(Encoding.UTF8.GetBytes(
                    "tutorial-index-v1\n" + string.Join("\n", levels.Select(l => l.PuzzleKey + "|" + l.PuzzleHash))))).Replace("-", "").ToLowerInvariant();
            bool changed = progress.TutorialCatalogHash != tutorialCatalogHash || progress.TutorialFirstStages == null ||
                progress.TutorialFirstStages.Length != DemoRules.Length || progress.TutorialFirstStages.Any(v => v < 0 || v > levels.Length);
            tutorialFirstStages = changed ? DemoRules.Select(rule => Array.FindIndex(levels, l => HasMechanic(l, rule)) + 1).ToArray()
                : (int[])progress.TutorialFirstStages.Clone();
            if (progress.SeenDemoRules == null)
            {
                // These numbers describe the historical save format, never the current unlock schedule.
                int[] legacyStages = { 7, 11, 19, 30, 40 };
                progress.SeenDemoRules = DemoRules.Where((rule, i) =>
                    (progress.SeenRuleDemos ?? Array.Empty<int>()).Contains(legacyStages[i]) ||
                    (progress.SeenRules ?? Array.Empty<string>()).Contains(rule)).ToArray();
                changed = true;
            }
            return changed;
        }

        /// <summary>提交整体操作的存档快照，再通知界面刷新。</summary>
        private void StampPuzzle() { progress.PuzzleKey = Level.PuzzleKey; progress.PuzzleHash = Level.PuzzleHash; progress.LevelSetVersion = Level.ContentTag;
            progress.TutorialCatalogHash = tutorialCatalogHash; progress.TutorialFirstStages = tutorialFirstStages;
        }
        private void Save() { Checkpoint(); Changed?.Invoke(); }
    }
}
