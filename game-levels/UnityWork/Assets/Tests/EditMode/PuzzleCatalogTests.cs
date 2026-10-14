using System;
using System.IO;
using System.Linq;
using LumaPairs;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using NUnit.Framework;

public sealed class PuzzleCatalogTests
{
    private string json;
    private LumaLevel[] levels;
    [OneTimeSetUp] public void Load() { json=File.ReadAllText("Assets/Tests/EditMode/Fixtures/LumaLevels.json"); levels=LumaLevel.Parse(json); }

    [Test] public void TutorialIndexFollowsReorderAndInvalidatesLocalCacheWithoutReleaseTagChange()
    {
        string saved=null;
        var original=new LumaSession(levels,null,v=>saved=v); original.Checkpoint();
        var old=JsonConvert.DeserializeObject<LumaProgress>(saved);
        Assert.That(old.TutorialFirstStages,Is.EqualTo(new[]{7,11,19,30,40}));
        var plain=levels.Where(l=>l.Edges.Count==0 && l.Clues.Count==0 && l.Regions.All(v=>v<0) && l.Initial.All(v=>v>=0)).Take(8).ToArray();
        var reordered=plain.Concat(levels.Except(plain)).ToArray();
        var restored=new LumaSession(reordered,saved,v=>saved=v);
        var next=JsonConvert.DeserializeObject<LumaProgress>(saved);
        Assert.That(next.TutorialCatalogHash,Is.Not.EqualTo(old.TutorialCatalogHash));
        Assert.That(next.TutorialFirstStages[0],Is.EqualTo(Array.FindIndex(reordered,l=>l.Edges.Count>0)+1));
        restored.JumpToLevel(7); Assert.That(restored.NeedsRuleDemo,Is.False);
        restored.JumpToLevel(next.TutorialFirstStages[0]); Assert.That(restored.CurrentRuleDemoKey,Is.EqualTo("edge"));
        restored.AdvanceRuleDemo();
        Assert.That(new LumaSession(reordered,saved,null).CurrentRuleDemoKey,Is.Not.EqualTo("edge"));
    }

    [Test] public void MultipleNewMechanicsQueueIndividuallyAndLegacyLearnedTypesSurviveReorder()
    {
        var mixed=levels.First(l=>l.Edges.Count>0 && l.Clues.Any(c=>!c.Corner));
        var reordered=new[]{mixed}.Concat(levels.Where(l=>l!=mixed)).ToArray();
        string saved=null;var s=new LumaSession(reordered,null,v=>saved=v);
        var shown=new System.Collections.Generic.List<string>();
        var before=s.Snapshot();
        while(s.NeedsRuleDemo) { Assert.That(shown,Does.Not.Contain(s.CurrentRuleDemoKey)); shown.Add(s.CurrentRuleDemoKey); s.AdvanceRuleDemo(); }
        Assert.That(shown,Does.Contain("edge")); Assert.That(shown,Does.Contain("edgecount"));
        Assert.That(s.Snapshot(),Is.EqualTo(before));
        Assert.That(new LumaSession(reordered,saved,null).NeedsRuleDemo,Is.False);
        var legacy=new LumaSession(reordered,"{\"SeenRuleDemos\":[7,30]}",null);
        Assert.That(legacy.CurrentRuleDemoKey,Is.Not.EqualTo("edge")); Assert.That(legacy.CurrentRuleDemoKey,Is.Not.EqualTo("edgecount"));
    }

    [Test] public void CacheInvalidatesWhenPuzzleChangesAtSamePosition()
    {
        string saved=null; new LumaSession(levels,null,v=>saved=v).Checkpoint();
        var before=JsonConvert.DeserializeObject<LumaProgress>(saved);
        var changed=(LumaLevel[])levels.Clone(); changed[6]=levels[0];
        new LumaSession(changed,saved,v=>saved=v);
        var after=JsonConvert.DeserializeObject<LumaProgress>(saved);
        Assert.That(after.TutorialCatalogHash,Is.Not.EqualTo(before.TutorialCatalogHash));
        Assert.That(after.TutorialFirstStages[0],Is.EqualTo(8));
    }

    [Test] public void UnchangedCacheIsReusedAndEarlierUnseenMechanicsAreTaughtAtNextEncounter()
    {
        string saved=null;new LumaSession(levels,null,v=>saved=v).Checkpoint();
        int writes=0;new LumaSession(levels,saved,v=>writes++);
        Assert.That(writes,Is.Zero,"matching catalog must reuse the persisted index");
        var late=new LumaSession(levels,"{\"Level\":8,\"GuideVersion\":1}",null);
        Assert.That(late.CurrentRuleDemoKey,Is.EqualTo("edge"),"unseen rules moved before current progress must not be lost");
        var learned=new LumaSession(levels,"{\"Level\":8,\"SeenRules\":[\"balance\",\"nothree\",\"edge\"]}",null);
        Assert.That(learned.NeedsRuleDemo,Is.False,"legacy type learning survives migration");
    }

    [TestCase(1)] [TestCase(2)] [TestCase(5)] [TestCase(30)] [TestCase(330)] [TestCase(400)]
    public void LegacySaveResetsEvenAValidBoardAndMigratesExactlyOnce(int stage)
    {
        string saved=null;
        var old=new LumaProgress { Level=stage, HintCount=19, Hearts=0, Completed=true, GuideVersion=1,
            TutorialSeen=true, SeenFeatures=new[]{"hint"}, SeenRuleDemos=new[]{7,11}, Steps=81, BestCombo=20, ElapsedSeconds=800,
            Board=LumaSolver.Solve(levels[stage-1],levels[stage-1].Initial,1)[0] };
        var s=new LumaSession(levels,JsonConvert.SerializeObject(old),v=>saved=v);
        Assert.That(s.LevelNumber,Is.EqualTo(stage)); Assert.That(s.HintCount,Is.EqualTo(19));
        Assert.That(s.Snapshot(),Is.EqualTo(s.Level.Initial)); Assert.That(s.Hearts,Is.EqualTo(3));
        Assert.That(s.Completed,Is.False); Assert.That(s.Steps,Is.Zero); Assert.That(s.ElapsedSeconds,Is.Zero);
        Assert.That(saved,Is.Not.Null);
        var migrated=JsonConvert.DeserializeObject<LumaProgress>(saved);
        Assert.That(migrated.SeenFeatures,Is.EqualTo(old.SeenFeatures)); Assert.That(migrated.GuideVersion,Is.EqualTo(1));
        while(s.NeedsRuleDemo) s.AdvanceRuleDemo();
        Assert.That(s.ApplyHint(s.GetHint()),Is.True);
        var restored=new LumaSession(levels,saved,null);
        Assert.That(restored.Snapshot(),Is.EqualTo(s.Snapshot())); Assert.That(restored.HintCount,Is.EqualTo(18));
        Assert.That(restored.Steps,Is.EqualTo(1));
    }

    [Test] public void ReleaseMetadataChangesDoNotResetAnUnchangedPuzzle()
    {
        string saved=null;var s=new LumaSession(levels,"{\"Level\":3}",v=>saved=v); s.ApplyHint(s.GetHint()); s.Tick(18); s.Checkpoint();
        var next=JObject.Parse(json); next["contentTag"]="presentation-only";
        var restored=new LumaSession(LumaLevel.Parse(next.ToString()),saved,null);
        Assert.That(restored.Snapshot(),Is.EqualTo(s.Snapshot())); Assert.That(restored.ElapsedSeconds,Is.EqualTo(18));
    }

    [Test] public void StableIdentityRestoresAfterCatalogReordering()
    {
        string saved=null;var s=new LumaSession(levels,"{\"Level\":3}",v=>saved=v);s.ApplyHint(s.GetHint());
        var next=JObject.Parse(json);next["routes"][2]["orderIndex"]=4;next["routes"][3]["orderIndex"]=3;
        var restored=new LumaSession(LumaLevel.Parse(next.ToString()),saved,null);
        Assert.That(restored.LevelNumber,Is.EqualTo(4)); Assert.That(restored.Snapshot(),Is.EqualTo(s.Snapshot()));
    }

    [Test] public void NativeParserRejectsDanglingReferencesBadHashesAndUnknownParameters()
    {
        foreach(Action<JObject> mutate in new Action<JObject>[] { d=>d["routes"][0]["boardRef"]="missing", d=>d["routes"][0]["puzzleHash"]="bad",d=>d["clauses"][0]["slot"]="A",d=>d["formatRevision"]=2 }) {
            var d=JObject.Parse(json);mutate(d);Assert.Throws<FormatException>(()=>LumaLevel.Parse(d.ToString()));
        }
        Assert.Throws<FormatException>(()=>LumaLevel.Parse("{\"1\":{\"ID\":1}}"));
    }

    [Test] public void SymbolThemesAreIndependentAndRequireBothSlots()
    {
        var rows=new[]{new SymbolSkinConfig{Id="plain-A",StyleKey="plain",Slot="A",IconAddress="circle",LabelKey="circle_name",DisplayScale=1},new SymbolSkinConfig{Id="plain-B",StyleKey="plain",Slot="B",IconAddress="square",LabelKey="square_name",DisplayScale=1}};
        var theme=new SymbolThemeResolver(rows,"plain");
        Assert.That(theme.Get((int)SymbolSlot.A).IconAddress,Is.EqualTo("circle"));
        Assert.That(theme.Get((int)SymbolSlot.B).LabelKey,Is.EqualTo("square_name"));
        Assert.Throws<FormatException>(()=>new SymbolThemeResolver(rows.Take(1),"plain"));
        Assert.That(LumaLevel.Parse(json).Select(l=>l.PuzzleHash),Is.EqualTo(levels.Select(l=>l.PuzzleHash)));
    }
}
