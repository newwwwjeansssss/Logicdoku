using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using Newtonsoft.Json.Linq;

namespace LumaPairs
{
    public enum SymbolSlot { A = 1, B = 2 }

    /// <summary>连接自主配置实体并验证整个目录；不接受历史关卡 JSON。</summary>
    public static class PuzzleCatalogReader
    {
        public static readonly string[] Operations = { "trackBalance", "runCeiling", "districtBalance", "pairRelation", "entryPosition", "junctionCount" };
        private static readonly string[] ParameterNames = { "Axis", "CellRefs", "ZoneLabel", "Relation", "Edge", "Lane", "Slot", "Amount" };
        private static readonly string[][] Used = {
            new[]{"Axis"}, new[]{"Axis","Amount"}, new[]{"ZoneLabel","CellRefs"},
            new[]{"CellRefs","Relation"}, new[]{"Edge","Lane","Slot","Amount"}, new[]{"CellRefs","Slot","Amount"}
        };
        public static void Require(bool condition, string location)
        { if (!condition) throw new FormatException("Invalid puzzle catalog: " + location); }

        public static string RuleKey(string op)
        {
            switch(op) {
                case "trackBalance": return "balance"; case "runCeiling": return "nothree";
                case "districtBalance": return "region"; case "pairRelation": return "edge";
                case "entryPosition": return "edgecount"; case "junctionCount": return "corner";
                case "cutout": return "holes"; default: throw new FormatException("Unknown rule " + op);
            }
        }
        public static string DisplayRule(string rule) => rule == "first" ? "edgecount" : rule == "row" || rule == "col" ? "balance" : rule;

        public static LumaLevel[] Parse(string json)
        {
            var root = JObject.Parse(json);
            Require(root.Properties().Select(p=>p.Name).OrderBy(x=>x).SequenceEqual(new[]{"formatKey","formatRevision","catalogKey","contentTag","routes","boards","clauses"}.OrderBy(x=>x)), "root fields");
            Require(root["formatRevision"]?.Type == JTokenType.Integer && (int)root["formatRevision"] == 1 && (string)root["formatKey"] == "cuddledoku.puzzle-set", "protocol");
            Require(root["catalogKey"]?.Type == JTokenType.String && root["contentTag"]?.Type == JTokenType.String,"release types");
            var routes = ReadRows<PuzzleRouteConfig>(root["routes"], new[]{"CatalogKey","FormatRevision","ContentTag"});
            foreach(var r in routes) { r.CatalogKey=(string)root["catalogKey"]; r.FormatRevision=1; r.ContentTag=(string)root["contentTag"]; }
            return Build(routes, ReadRows<PuzzleBoardConfig>(root["boards"]), ReadRows<PuzzleClauseConfig>(root["clauses"]));
        }

        private static T[] ReadRows<T>(JToken token, string[] omitted = null)
        {
            Require(token is JArray, typeof(T).Name+" array");
            var props=typeof(T).GetProperties().Where(p=>!(omitted ?? Array.Empty<string>()).Contains(p.Name)).ToArray();
            var result = new List<T>();
            foreach(var item in (JArray)token) {
                Require(item is JObject,typeof(T).Name+" record"); var row=(JObject)item; var mapped=new JObject();
                Require(row.Count==props.Length, typeof(T).Name+" field count");
                foreach(var p in props) {
                    string key=p.Name=="Id"?"key":char.ToLowerInvariant(p.Name[0])+p.Name.Substring(1);
                    var v=row[key];
                    Require(v!=null && (p.PropertyType==typeof(string) ? v.Type==JTokenType.String : v.Type==JTokenType.Integer),typeof(T).Name+"."+key);
                    mapped[p.Name]=v.DeepClone();
                }
                result.Add(mapped.ToObject<T>());
            }
            return result.ToArray();
        }

        public static LumaLevel[] Build(IEnumerable<PuzzleRouteConfig> routeRows, IEnumerable<PuzzleBoardConfig> boardRows, IEnumerable<PuzzleClauseConfig> clauseRows)
        {
            var routes=routeRows.OrderBy(r=>r.OrderIndex).ToArray(); var boards=boardRows.ToArray(); var clauses=clauseRows.ToArray();
            Require(routes.Length==400 && routes.Select(r=>r.OrderIndex).SequenceEqual(Enumerable.Range(1,400)),"main requires 400 ordered routes");
            Unique(routes.Select(r=>r.Id),"route Id"); Unique(boards.Select(b=>b.Id),"board Id"); Unique(clauses.Select(c=>c.Id),"clause Id");
            var boardMap=boards.ToDictionary(b=>b.Id); var sets=clauses.GroupBy(c=>c.SetRef).ToDictionary(g=>g.Key,g=>g.OrderBy(c=>c.Order).ToArray());
            Require(boards.Length==400 && sets.Count==400 && routes.Select(r=>r.BoardRef).Distinct().Count()==400 && routes.Select(r=>r.ClauseSetRef).Distinct().Count()==400,"orphan/shared entities");
            string release=routes[0].ContentTag; Require(!string.IsNullOrWhiteSpace(release),"ContentTag");
            var levels=new List<LumaLevel>();
            foreach(var route in routes) {
                string at=route.Id;
                Require(route.FormatRevision==1 && route.CatalogKey=="main" && route.ContentTag==release,at+" version");
                Require(route.BoardRef!=null && route.ClauseSetRef!=null && boardMap.ContainsKey(route.BoardRef) && sets.ContainsKey(route.ClauseSetRef),at+" references");
                Require(route.Grade>=1 && route.Grade<=5 && (route.Featured==0 || route.Featured==1) && (route.CutoutMode=="ornament" || route.CutoutMode=="open"),at+" display");
                var deck=(route.RuleDeck ?? "").Split(','); Require(deck.Length>=2 && deck[0]==Operations[0] && deck[1]==Operations[1] && deck.Distinct().Count()==deck.Length,at+" rule deck");
                foreach(var op in deck) RuleKey(op);
                var board=boardMap[route.BoardRef]; var cs=sets[route.ClauseSetRef];
                int[] initial=BoardLayoutDecoder.Decode(board); int n=board.Columns;
                Require(cs.Length>=2 && cs[0].Op==Operations[0] && cs[1].Op==Operations[1] && cs.Select(c=>c.Order).SequenceEqual(Enumerable.Range(1,cs.Length)),at+" clause order");
                int last=-1; var occupied=new HashSet<int>(); var labels=new HashSet<int>();
                foreach(var c in cs) {
                    string where=at+" / "+c.Id; int rank=Array.IndexOf(Operations,c.Op);
                    Require(rank>=0 && rank>=last && (rank>1 || rank>last),where+" Op/order"); last=rank;
                    foreach(string field in ParameterNames) if(!Used[rank].Contains(field)) {
                        var p=typeof(PuzzleClauseConfig).GetProperty(field); var v=p.GetValue(c);
                        Require(p.PropertyType==typeof(string)? Equals(v,""):Equals(v,-1),where+" unused "+field);
                    }
                    int[] ix=CellRefs(c.CellRefs); Require(ix.Distinct().Count()==ix.Length && ix.All(i=>i>=0 && i<initial.Length),where+" CellRefs");
                    if(rank<2) Require(c.Axis=="both" && (rank==0 || c.Amount==2),where+" foundation");
                    if(rank==2) {
                        Require(ix.Length>0 && c.ZoneLabel>=0 && labels.Add(c.ZoneLabel) && ix.All(i=>occupied.Add(i)),where+" district");
                        Require(ix.Count(i=>initial[i]>=0)%2==0,where+" odd district");
                    }
                    if(rank==3) {
                        Require(ix.Length==2 && ix.All(i=>initial[i]>=0) && (c.Relation=="same" || c.Relation=="opposite"),where+" relation");
                        Require(Math.Abs(ix[0]/n-ix[1]/n)+Math.Abs(ix[0]%n-ix[1]%n)==1,where+" adjacency");
                    }
                    if(rank>=4) Require(c.Slot=="A" || c.Slot=="B",where+" Slot");
                    if(rank==4) {
                        Require((c.Edge=="west" || c.Edge=="north") && c.Lane>=0 && c.Lane<n,where+" edge/lane");
                        int active=Enumerable.Range(0,n).Count(j=>initial[c.Edge=="west"?c.Lane*n+j:j*n+c.Lane]>=0);
                        Require(c.Amount>=1 && c.Amount<=active,where+" position");
                    }
                    if(rank==5) {
                        Require(ix.Length==1 && ix[0]/n<n-1 && ix[0]%n<n-1,where+" anchor");
                        int a=ix[0]; int active=new[]{a,a+1,a+n,a+n+1}.Count(i=>initial[i]>=0);
                        Require(c.Amount>=0 && c.Amount<=active,where+" count");
                    }
                }
                Require(Hash(board,cs)==route.PuzzleHash,at+" PuzzleHash");
                levels.Add(new LumaLevel(route,board,cs,initial));
            }
            return levels.ToArray();
        }

        private static void Unique(IEnumerable<string> values,string name) {
            var a=values.ToArray(); Require(a.All(x=>!string.IsNullOrWhiteSpace(x)) && a.Distinct().Count()==a.Length,name);
        }
        public static int[] CellRefs(string text) {
            Require(text!=null && (text=="" || Regex.IsMatch(text,@"\A(0|[1-9][0-9]*)(,(0|[1-9][0-9]*))*\z")),"CellRefs syntax");
            return text==""?Array.Empty<int>():text.Split(',').Select(x=>int.Parse(x,CultureInfo.InvariantCulture)).ToArray();
        }
        public static string Hash(PuzzleBoardConfig b, IEnumerable<PuzzleClauseConfig> clauses) {
            var lines=new List<string>{b.Columns.ToString(CultureInfo.InvariantCulture)+"x"+b.Rows.ToString(CultureInfo.InvariantCulture),b.Cells};
            foreach(var c in clauses.OrderBy(c=>c.Order)) lines.Add(string.Join("|",new[]{c.Op,c.Axis,c.CellRefs,c.ZoneLabel.ToString(CultureInfo.InvariantCulture),c.Relation,c.Edge,c.Lane.ToString(CultureInfo.InvariantCulture),c.Slot,c.Amount.ToString(CultureInfo.InvariantCulture)}));
            using(var sha=SHA256.Create()) return BitConverter.ToString(sha.ComputeHash(Encoding.UTF8.GetBytes(string.Join("\n",lines)))).Replace("-","").ToLowerInvariant();
        }
    }

    public static class BoardLayoutDecoder
    {
        public static int[] Decode(PuzzleBoardConfig board) {
            PuzzleCatalogReader.Require(new[]{4,6,8}.Contains(board.Columns) && board.Rows==board.Columns && board.Cells!=null && board.Cells.Length==board.Columns*board.Rows,board.Id+" dimensions");
            PuzzleCatalogReader.Require(board.Cells.All(c=>".#AB".Contains(c)),board.Id+" Cells");
            return board.Cells.Select(c=>c=='#'?-1:c=='.'?0:c=='A'?1:2).ToArray();
        }
    }
}
