using LumaPairs;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

string root=Path.GetFullPath(Path.Combine(AppContext.BaseDirectory,"../../../../../../"));
var frozen=JObject.Parse(File.ReadAllText(Path.Combine(root,"artifacts/levels/source/mixed-four-400/source.json")));
string native=File.ReadAllText(Path.Combine(root,"UnityWork/Assets/Tests/EditMode/Fixtures/LumaLevels.json"));
var levels=LumaLevel.Parse(native);
var course=JObject.Parse(File.ReadAllText(Path.Combine(root,"artifacts/levels/source/mixed-four-400/course.json")));
int assertions=0, hints=0; var failures=new List<string>();
void Check(bool ok,string message) { assertions++; if(!ok) throw new Exception(message); }
void Test(string name,Action run) { try {run(); Console.WriteLine("PASS "+name);} catch(Exception e) {failures.Add(name+": "+e.Message); Console.WriteLine("FAIL "+failures.Last());} }
Test("tutorial follows actual first occurrence after course reorder",()=>{
 // Move every relation puzzle after stage 8, preserving the levels themselves.
 var without=levels.Where(l=>l.Edges.Count==0 && l.Clues.Count==0 && l.Regions.All(v=>v<0) && l.Initial.All(v=>v>=0)).Take(8).ToList();
 var reordered=without.Concat(levels.Except(without)).ToArray();
 var s=new LumaSession(reordered,"{\"Level\":7}",null);
 Check(!s.NeedsRuleDemo,"stage 7 has no relation and must not show the old fixed demo");
 int first=Array.FindIndex(reordered,l=>l.Edges.Count>0)+1;
 s=new LumaSession(reordered,JsonConvert.SerializeObject(new LumaProgress{Level=first}),null);
 Check(s.NeedsRuleDemo,"first relation stage must teach");
});
Test("400 source models, unique answers and hint paths",()=>{
 Check(levels.Length==400,"count");
 for(int i=0;i<400;i++) {
  var level=levels[i]; var p=frozen["levels"][i]["puzzle"];
  var initial=new int[(int)p["size"]*(int)p["size"]];
  foreach(var h in p["holes"]) initial[(int)h["r"]*level.Size+(int)h["c"]]=-1;
  foreach(var g in p["givens"]) initial[(int)g["r"]*level.Size+(int)g["c"]]=(int)g["s"];
  Check(initial.SequenceEqual(level.Initial),"source givens/holes "+level.Id);
  Check(level.Difficulty==(int)p["difficultyTag"] && level.IsHard==(bool)course["levels"][i]["courseChallenge"],"course metadata "+level.Id);
  var regions=p["regions"].SelectMany(v=>v is JArray a?a.Values<int>():new[]{(int)v}).ToArray();
  Check(level.Regions.SequenceEqual(regions.Length==0?Enumerable.Repeat(-1,initial.Length):regions),"source regions "+level.Id);
  Check(level.Edges.Count==p["edges"].Count() && level.Clues.Count==p["edgeClues"].Count()+p["cornerClues"].Count(),"source constraints "+level.Id);
  int j=0;
  foreach(var e in p["edges"]) { var actual=level.Edges[j++]; Check(actual.A==(int)e["r1"]*level.Size+(int)e["c1"] && actual.B==(int)e["r2"]*level.Size+(int)e["c2"] && actual.Equal==((string)e["t"]=="eq"),"source relation "+level.Id); }
  j=0;
  foreach(var c in p["edgeClues"]) {var actual=level.Clues[j++]; Check(!actual.Corner && actual.Row==((string)c["line"]=="row"?(int)c["index"]:-1) && actual.Col==((string)c["line"]=="col"?(int)c["index"]:-1) && actual.Symbol==(int)c["symbol"] && actual.Value==(int)c["value"],"source entry "+level.Id);}
  foreach(var c in p["cornerClues"]) {var actual=level.Clues[j++]; Check(actual.Corner && actual.Row==(int)c["r"] && actual.Col==(int)c["c"] && actual.Symbol==(int)c["symbol"] && actual.Value==(int)c["value"],"source junction "+level.Id);}
  var answer=p["solution"].Values<int>().Select(v=>v==0?-1:v).ToArray();
  var solutions=LumaSolver.Solve(level,level.Initial,2);
  Check(solutions.Count==1 && solutions[0].SequenceEqual(answer),"answer "+level.Id);
  var board=(int[])level.Initial.Clone(); int moves=0;
  while(board.Contains(0)) {
   var h=LumaSolver.Hint(level,board);
   Check(h!=null && h.Symbol==answer[h.Cell] && board[h.Cell]==0,"hint "+level.Id);
   board[h.Cell]=h.Symbol; hints++; Check(++moves<=board.Length,"hint loop");
  }
 }
});
Test("actual compiled configuration and independent themes",()=>{
 var package=JObject.Parse(File.ReadAllText(Path.Combine(root,"UnityWork/Assets/StreamingAssets/HotUpdate/Config/gamedata.json")));
 using var bytes=new MemoryStream(Convert.FromBase64String((string)package["_zinfo"]));
 using var zip=new System.IO.Compression.DeflateStream(bytes,System.IO.Compression.CompressionMode.Decompress);
 using var reader=new StreamReader(zip); var tables=JObject.Parse(reader.ReadToEnd());
 T[] Rows<T>(string name) => tables[name]["data"].Select(row=>new JObject(((JObject)tables[name]["code"]).Properties().Select(p=>new JProperty(p.Name,row[(string)p.Value]))).ToObject<T>()).ToArray();
 PuzzleRouteConfigMgr.Instance.Rows.AddRange(Rows<PuzzleRouteConfig>("puzzleRoute"));
 PuzzleBoardConfigMgr.Instance.Rows.AddRange(Rows<PuzzleBoardConfig>("puzzleBoard"));
 PuzzleClauseConfigMgr.Instance.Rows.AddRange(Rows<PuzzleClauseConfig>("puzzleClause"));
 SymbolSkinConfigMgr.Instance.Rows.AddRange(Rows<SymbolSkinConfig>("symbolSkin"));
 var compiled=LumaLevel.FromConfig();Check(compiled.Length==400 && tables["lumaLevel"]==null,"compiled catalog");
 for(int i=0;i<400;i++) Check(JToken.DeepEquals(JObject.FromObject(compiled[i]),JObject.FromObject(levels[i])),"compiled model "+(i+1));
 SymbolThemeResolver.UseConfiguredStyle("classic"); Check(SymbolThemeResolver.Active.Get(2).Slot=="B","configured theme");
 var plain=new[]{new SymbolSkinConfig{Id="pA",StyleKey="plain",Slot="A",IconAddress="circle",LabelKey="circle",DisplayScale=1},new SymbolSkinConfig{Id="pB",StyleKey="plain",Slot="B",IconAddress="square",LabelKey="square",DisplayScale=1}};
 Check(new SymbolThemeResolver(plain,"plain").Get(2).IconAddress=="square","independent second theme");
 bool rejected=false;try{new SymbolThemeResolver(plain.Take(1),"plain");}catch(FormatException){rejected=true;}Check(rejected,"missing symbol");
});
Test("stable identity and presentation-only updates preserve progress",()=>{
 string saved=null;var s=new LumaSession(levels,"{\"Level\":3}",v=>saved=v);s.ApplyHint(s.GetHint());s.Tick(18);s.Checkpoint();
 var data=JObject.Parse(native);data["contentTag"]="presentation-only";
 data["routes"][2]["orderIndex"]=4;data["routes"][3]["orderIndex"]=3;
 var restored=new LumaSession(LumaLevel.Parse(data.ToString()),saved,null);
 Check(restored.LevelNumber==4 && restored.Snapshot().SequenceEqual(s.Snapshot()) && restored.ElapsedSeconds==18,"identity/hash restore");
});
Test("first guide input lock and resume",()=>{
 string saved=null; var s=new LumaSession(levels,null,v=>saved=v); s.BeginTutorial();
 for(int i=0;i<3;i++) {
  var expected=LumaSolver.Hint(s.Level,s.Snapshot());
  Check(s.GuideCell==expected.Cell && s.GuideSymbol==expected.Symbol && s.GuideRule==expected.Rule,"guide "+i);
  Check(!s.Place(expected.Cell,3-expected.Symbol),"wrong guide input");
  Check(s.Place(expected.Cell,expected.Symbol),"guide placement");
  s=new LumaSession(levels,saved,v=>saved=v);
 }
 Check(!s.NeedsGuidedTutorial && s.GuideStep==-1,"guide complete");
 var weak=s.GetWeakGuide(); Check(weak!=null && weak.Symbol==LumaSolver.Solve(s.Level,s.Snapshot(),1)[0][weak.Cell],"first weak guide");
 Check(s.Place(weak.Cell,weak.Symbol) && s.GetWeakGuide()==null,"weak dismiss");
 var second=new LumaSession(levels,"{\"Level\":2}",null);
 weak=second.GetWeakGuide(); Check(weak!=null,"second weak guide");
 Check(second.Place(weak.Cell,weak.Symbol) && second.GetWeakGuide()==null,"second weak dismiss");
});
Test("legacy archives preserve stage/inventory but reset current puzzle once",()=>{
 foreach(int stage in new[]{1,2,5,30,330,400}) {
  var old=new LumaProgress {Level=stage,HintCount=17,Hearts=0,Completed=true,GuideVersion=1,TutorialSeen=true,
   SeenRules=new[]{"balance"},SeenFeatures=new[]{"hint"},SeenRuleDemos=new[]{7,11},
   Board=LumaSolver.Solve(levels[stage-1],levels[stage-1].Initial,1)[0],
   Steps=88,ElapsedSeconds=900,Combo=7,BestCombo=8,GuideActive=true,RuleDemoStep=2};
  string saved=null; var s=new LumaSession(levels,JsonConvert.SerializeObject(old),v=>saved=v);
  Check(s.LevelNumber==stage && s.HintCount==17,"preserved progress");
  Check(s.Snapshot().SequenceEqual(s.Level.Initial) && s.Hearts==3 && !s.Completed,"reset board even if valid "+stage);
  Check(s.Steps==0 && s.ElapsedSeconds==0 && s.BestCombo==0,"reset statistics");
  Check(saved!=null,"migration persisted immediately");
  var p=JsonConvert.DeserializeObject<LumaProgress>(saved);
  Check(p.GuideVersion==1 && p.TutorialSeen && p.SeenFeatures.Contains("hint") && p.SeenRuleDemos.SequenceEqual(new[]{7,11}),"retained unlocks");
  while(s.NeedsRuleDemo) s.AdvanceRuleDemo();
  var h=s.GetHint(); Check(h!=null && s.ApplyHint(h),"play migrated board");
  var restored=new LumaSession(levels,saved,null);
  Check(restored.Snapshot().SequenceEqual(s.Snapshot()) && restored.HintCount==16 && restored.Steps==1,"idempotent migration");
 }
});
Test("reject invalid native records and unsupported legacy format",()=>{
 var edits=new Action<JObject>[] {
  d=>d["formatRevision"]=2,
  d=>d["routes"][0]["boardRef"]="missing",
  d=>d["routes"][0]["orderIndex"]=2,
  d=>d["boards"][0]["cells"]="wrong",
  d=>d["clauses"][0]["op"]="unknown",
  d=>d["clauses"][0]["slot"]="A",
  d=>d["routes"][0]["puzzleHash"]="tampered",
  d=>d["routes"][0]["unexpected"]=1,
  d=>d["clauses"][1]["order"]=1
 };
 foreach(var edit in edits) {
  var d=JObject.Parse(native); edit(d); bool rejected=false;
  try {LumaLevel.Parse(d.ToString());} catch(FormatException) {rejected=true;}
  Check(rejected,"invalid catalog accepted");
 }
 bool legacyRejected=false;
 try {LumaLevel.Parse("{\"1\":{\"ID\":1}}");} catch(FormatException) {legacyRejected=true;}
 Check(legacyRejected,"legacy fallback");
});
Test("unlock, loss, revive and final-stage flow",()=>{
 var s=new LumaSession(levels,"{\"GuideVersion\":1,\"HintCount\":20000}",null);
 for(int stage=1;stage<=400;stage++) {
  Check(s.LevelNumber==stage,"stage");
  Check(s.HasHints==(stage>=3) && s.HasHearts==(stage>=5),"feature gate");
  Check(s.NeedsRuleDemo==new[]{7,11,19,30,40}.Contains(stage),"demo gate");
  if(s.NeedsRuleDemo) {var before=s.Snapshot(); Check(!s.ApplyHint(s.GetHint()),"demo input lock"); s.AdvanceRuleDemo(); Check(s.Snapshot().SequenceEqual(before),"demo changed board");}
  if(s.PendingFeature!=null) s.FinishFeatureTutorial();
  var answer=LumaSolver.Solve(s.Level,s.Level.Initial,1)[0];
  if(stage>=5) {
   int target=Array.IndexOf(s.Snapshot(),0);
   for(int k=0;k<3;k++) {if(k>0) Check(s.ClearCell(target),"clear wrong"); Check(!s.Place(target,3-answer[target]),"wrong answer");}
   Check(s.Failed && !s.Place(target,answer[target]),"failure lock"); s.Revive(); Check(s.Hearts==3,"revive");
  }
  while(!s.Won) Check(s.ApplyHint(s.GetHint()),"apply hint "+stage);
  s.Advance(); Check(s.LevelNumber==(stage==400?400:stage+1),"advance");
 }
 Check(s.Completed,"400 complete");
});
Console.WriteLine($"Assertions={assertions}; hints={hints}; failures={failures.Count}");
if(failures.Count>0) Environment.ExitCode=1;
