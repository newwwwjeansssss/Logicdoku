using System;
using System.Collections.Generic;
using System.Linq;

namespace LumaPairs
{
    /// <summary>美术映射只在表现层使用，永远不改变 A/B 的规则身份。</summary>
    public sealed class SymbolThemeResolver
    {
        private readonly Dictionary<int, SymbolSkinConfig> slots;
        private static SymbolThemeResolver active;
        public string StyleKey { get; }
        public static SymbolThemeResolver Active => active ?? (active = new SymbolThemeResolver(SymbolSkinConfigMgr.Instance.GetAllDatas(), "classic"));

        public static void UseConfiguredStyle(string styleKey)
        { active = new SymbolThemeResolver(SymbolSkinConfigMgr.Instance.GetAllDatas(), styleKey); }

        public SymbolThemeResolver(IEnumerable<SymbolSkinConfig> rows, string selected)
        {
            var all=rows.ToArray();
            PuzzleCatalogReader.Require(all.Length>0 && all.Select(r=>r.Id).Distinct().Count()==all.Length,"theme identities");
            foreach(var group in all.GroupBy(r=>r.StyleKey)) {
                var pair=group.ToArray();
                PuzzleCatalogReader.Require(!string.IsNullOrWhiteSpace(group.Key) && pair.Length==2 && pair.Select(r=>r.Slot).OrderBy(x=>x).SequenceEqual(new[]{"A","B"}),"theme slots "+group.Key);
                PuzzleCatalogReader.Require(pair.Select(r=>r.IconAddress).Distinct().Count()==2,"indistinguishable theme icons");
                foreach(var r in pair) PuzzleCatalogReader.Require(!string.IsNullOrWhiteSpace(r.Id) && !string.IsNullOrWhiteSpace(r.IconAddress) && !r.IconAddress.StartsWith("symbol:") && !string.IsNullOrWhiteSpace(r.LabelKey) && r.DisplayScale>0 && !float.IsInfinity(r.DisplayScale),"theme "+r.Id);
            }
            StyleKey=all.Any(r=>r.StyleKey==selected)?selected:"classic";
            PuzzleCatalogReader.Require(all.Any(r=>r.StyleKey==StyleKey),"missing default theme");
            slots=all.Where(r=>r.StyleKey==StyleKey).ToDictionary(r=>r.Slot=="A"?1:2);
        }
        public SymbolSkinConfig Get(int symbol)
        {
            if(!slots.TryGetValue(symbol,out var value)) throw new ArgumentOutOfRangeException(nameof(symbol));
            return value;
        }
        public static string IconKey(int symbol) => "symbol:" + ((SymbolSlot)symbol).ToString();
    }
}
