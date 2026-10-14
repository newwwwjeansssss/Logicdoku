using System;
using System.Collections.Generic;
using System.Linq;

namespace LumaPairs
{
    /// <summary>保存关卡的不可变规则，索引按从上到下、从左到右排列。</summary>
    public sealed class LumaLevel
    {
        public int Id { get; }
        public int Size { get; }
        public int Difficulty { get; }
        public bool IsHard { get; }
        public string HoleStyle { get; }
        public int[] Initial { get; }
        public int[] Regions { get; }
        public string[] Rules { get; }
        public List<LumaConstraint> Constraints { get; } = new List<LumaConstraint>();
        public List<LumaEdge> Edges { get; } = new List<LumaEdge>();
        public List<LumaClue> Clues { get; } = new List<LumaClue>();

        public string PuzzleKey { get; }
        public string ContentTag { get; }
        public string PuzzleHash { get; }

        /// <summary>自主表已整体校验后，直接编译内部规则；不重建旧 JSON。</summary>
        internal LumaLevel(PuzzleRouteConfig route, PuzzleBoardConfig board, PuzzleClauseConfig[] clauses, int[] initial)
        {
            Id=route.OrderIndex; PuzzleKey=route.Id; ContentTag=route.ContentTag; PuzzleHash=route.PuzzleHash;
            Difficulty=route.Grade; IsHard=route.Featured==1; Size=board.Columns;
            HoleStyle=route.CutoutMode=="open"?"frame":"cloud";
            Initial=initial; Regions=Enumerable.Repeat(-1,initial.Length).ToArray();
            Rules=route.RuleDeck.Split(',').Select(PuzzleCatalogReader.RuleKey).ToArray();
            for(int i=0;i<Size;i++) {
                AddLine(Enumerable.Range(0,Size).Select(j=>i*Size+j).ToArray(),"row");
                AddLine(Enumerable.Range(0,Size).Select(j=>j*Size+i).ToArray(),"col");
            }
            foreach(var clause in clauses.Skip(2)) {
                int[] cells=PuzzleCatalogReader.CellRefs(clause.CellRefs);
                int symbol=clause.Slot=="A"?(int)SymbolSlot.A:(int)SymbolSlot.B;
                switch(clause.Op) {
                    case "districtBalance":
                        foreach(int cell in cells) Regions[cell]=clause.ZoneLabel;
                        int[] active=cells.Where(i=>Initial[i]>=0).ToArray();
                        Constraints.Add(new LumaConstraint(active,1,active.Length/2,"region"));
                        break;
                    case "pairRelation":
                        var edge=new LumaEdge { A=cells[0], B=cells[1], Equal=clause.Relation=="same" };
                        Edges.Add(edge); Constraints.Add(new LumaConstraint(cells,edge.Equal?0:-1,0,"edge"));
                        break;
                    case "entryPosition":
                        bool rowLine=clause.Edge=="west"; int lane=clause.Lane, first=clause.Amount-1;
                        int[] line=Enumerable.Range(0,Size).Select(j=>rowLine?lane*Size+j:j*Size+lane).Where(i=>Initial[i]>=0).ToArray();
                        for(int j=0;j<=first;j++) Constraints.Add(new LumaConstraint(new[]{line[j]},j==first?symbol:3-symbol,1,"first"));
                        Clues.Add(new LumaClue { Row=rowLine?lane:-1, Col=rowLine?-1:lane, Value=first, Symbol=symbol });
                        break;
                    case "junctionCount":
                        int a=cells[0]; int[] group=new[]{a,a+1,a+Size,a+Size+1}.Where(i=>Initial[i]>=0).ToArray();
                        Constraints.Add(new LumaConstraint(group,symbol,clause.Amount,"corner"));
                        Clues.Add(new LumaClue { Row=a/Size, Col=a%Size, Value=clause.Amount, Symbol=symbol, Corner=true });
                        break;
                }
            }
        }

        /// <summary>构造行列平衡与连续三格约束，空洞打断连续性。</summary>
        private void AddLine(int[] line, string rule)
        {
            int[] active = line.Where(i => Initial[i] >= 0).ToArray();
            if (active.Length % 2 != 0) throw new FormatException("Unbalanced line: " + Id);
            Constraints.Add(new LumaConstraint(active, 1, active.Length / 2, rule));
            for (int j = 0; j < line.Length - 2; j++)
            {
                int[] three = line.Skip(j).Take(3).ToArray();
                if (three.All(i => Initial[i] >= 0)) Constraints.Add(new LumaConstraint(three, -2, 0, "nothree"));
            }
        }

        /// <summary>读取自主目录实体，拒绝历史格式。</summary>
        public static LumaLevel[] Parse(string json) => PuzzleCatalogReader.Parse(json);

        /// <summary>全部配置表加载后连接实体、验证并生成不可变题库。</summary>
        public static LumaLevel[] FromConfig() => PuzzleCatalogReader.Build(
            PuzzleRouteConfigMgr.Instance.GetAllDatas(), PuzzleBoardConfigMgr.Instance.GetAllDatas(), PuzzleClauseConfigMgr.Instance.GetAllDatas());

    }

    /// <summary>保存等量、相邻或不连三约束；规则名称供提示解释使用。</summary>
    public sealed class LumaConstraint
    {
        public readonly int[] Cells;
        public readonly int Symbol;
        public readonly int Count;
        public readonly string Rule;
        /// <summary>初始化可独立验证的棋盘约束。</summary>
        public LumaConstraint(int[] cells, int symbol, int count, string rule) { Cells = cells; Symbol = symbol; Count = count; Rule = rule; }
    }
    /// <summary>保存两个相邻格的相等或相异关系。</summary>
    public sealed class LumaEdge { public int A, B; public bool Equal; }
    /// <summary>保存供界面展示的边缘或交点数字。</summary>
    public sealed class LumaClue
    {
        public int Row, Col, Value, Symbol;
        public bool Corner;
        /// <summary>边缘配置为目标前的格数，界面使用从 1 开始的位置；交点显示数量。</summary>
        public int DisplayValue => Corner ? Value : Value + 1;
    }
}
