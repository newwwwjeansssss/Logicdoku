// Import the approved course without retaining its schema in the runtime configuration.
import fs from 'node:fs/promises';
import path from 'node:path';
import {createHash} from 'node:crypto';
import {fileURLToPath} from 'node:url';
const root=path.resolve(path.dirname(fileURLToPath(import.meta.url)),'../..');
const sourceDir=process.argv[2];
if(!sourceDir) throw Error('Pass the approved source directory');
const hash=s=>createHash('sha256').update(s).digest('hex');
const raw=await fs.readFile(path.join(sourceDir,'400关完整配置.json'));
const source=JSON.parse(raw), course=JSON.parse(await fs.readFile(path.join(sourceDir,'课程顺序.json'),'utf8'));
const archive=path.join(root,'artifacts/levels/source/mixed-four-400');
await fs.mkdir(archive,{recursive:true});
await fs.writeFile(path.join(archive,'source.json'),raw);
await fs.copyFile(path.join(sourceDir,'课程顺序.json'),path.join(archive,'course.json'));
const native={formatKey:'cuddledoku.puzzle-set',formatRevision:1,catalogKey:'main',contentTag:'mixed400-20261012',routes:[],boards:[],clauses:[]};
const mapping={balance:'trackBalance',nothree:'runCeiling',region:'districtBalance',edge:'pairRelation',edgecount:'entryPosition',corner:'junctionCount',holes:'cutout'};
const rows=[...source.levels].sort((a,b)=>a.courseStage-b.courseStage);
if(rows.length!==400 || rows.some((v,i)=>v.courseStage!==i+1)) throw Error('Expected consecutive 400 course stages');
for(const [i,row] of rows.entries()) {
 const p=row.puzzle, n=String(i+1).padStart(4,'0'), setRef=`clauses-main-${n}`;
 const metadata=course.levels.find(v=>v.courseStage===i+1);
 if(!metadata || metadata.bank!==row.bank || metadata.sourceStage!==row.sourceStage) throw Error('Course mismatch '+n);
 const cells=Array(p.size*p.size).fill('.');
 for(const h of p.holes) cells[h.r*p.size+h.c]='#';
 for(const g of p.givens) {const k=g.r*p.size+g.c;if(cells[k]!=='.'|| ![1,2].includes(g.s))throw Error('Invalid given');cells[k]=g.s===1?'A':'B';}
 const board={key:`board-main-${n}`,columns:p.size,rows:p.size,cells:cells.join('')}; native.boards.push(board);
 const clauses=[];
 const add=(op,values={})=>clauses.push({key:`clause-main-${n}-${String(clauses.length+1).padStart(4,'0')}`,setRef,order:clauses.length+1,op,axis:'',cellRefs:'',zoneLabel:-1,relation:'',edge:'',lane:-1,slot:'',amount:-1,...values});
 add('trackBalance',{axis:'both'});add('runCeiling',{axis:'both',amount:2});
 const regions=p.regions.flat();
 for(const label of [...new Set(regions)].filter(x=>x>=0).sort((a,b)=>a-b)) add('districtBalance',{zoneLabel:label,cellRefs:regions.flatMap((v,j)=>v===label?[j]:[]).join(',')});
 for(const e of p.edges) {if(!['eq','x'].includes(e.t))throw Error('Unknown relation');add('pairRelation',{cellRefs:[e.r1*p.size+e.c1,e.r2*p.size+e.c2].join(','),relation:e.t==='eq'?'same':'opposite'});}
 for(const c of p.edgeClues) {if(c.type!=='first'||!['row','col'].includes(c.line))throw Error('Unknown edge clue');add('entryPosition',{edge:c.line==='row'?'west':'north',lane:c.index,slot:c.symbol===1?'A':'B',amount:c.value+1});}
 for(const c of p.cornerClues) add('junctionCount',{cellRefs:String(c.r*p.size+c.c),slot:c.symbol===1?'A':'B',amount:c.value});
 const puzzleHash=hash(`${p.size}x${p.size}\n${board.cells}\n`+clauses.map(c=>['op','axis','cellRefs','zoneLabel','relation','edge','lane','slot','amount'].map(k=>c[k]).join('|')).join('\n'));
 native.routes.push({key:`hd-main-${n}`,orderIndex:i+1,boardRef:board.key,clauseSetRef:setRef,grade:p.difficultyTag,featured:metadata.courseChallenge?1:0,ruleDeck:p.rules.map(v=>{if(!mapping[v])throw Error('Unknown rule '+v);return mapping[v];}).join(','),cutoutMode:p.holeStyle==='frame'?'open':'ornament',puzzleHash});
 native.clauses.push(...clauses);
}
const target=path.join(root,'artifacts/levels/cuddledoku');
const tables=JSON.parse(await fs.readFile(path.join(target,'tables.json'),'utf8'));
tables.puzzleRoute.rows=native.routes.map(r=>[r.key,r.orderIndex,'main',1,native.contentTag,r.boardRef,r.clauseSetRef,r.grade,r.featured?1:0,r.ruleDeck,r.cutoutMode,r.puzzleHash]);
tables.puzzleBoard.rows=native.boards.map(b=>[b.key,b.columns,b.rows,b.cells]);
tables.puzzleClause.rows=native.clauses.map(c=>[c.key,c.setRef,c.order,c.op,c.axis,c.cellRefs,c.zoneLabel,c.relation,c.edge,c.lane,c.slot,c.amount]);
const json=JSON.stringify(native,null,2)+'\n';
await fs.writeFile(path.join(target,'main.json'),json);
await fs.writeFile(path.join(root,'UnityWork/Assets/Tests/EditMode/Fixtures/LumaLevels.json'),json);
await fs.writeFile(path.join(target,'tables.json'),JSON.stringify(tables,null,2)+'\n');
const provenance={sourceDirectory:sourceDir,sha256:hash(raw),contentTag:native.contentTag,count:rows.length,banks:Object.fromEntries([...new Set(rows.map(r=>r.bank))].map(b=>[b,rows.filter(r=>r.bank===b).length])),challengeCount:native.routes.filter(r=>r.featured).length,clauses:native.clauses.length,firstRules:Object.fromEntries(Object.keys(mapping).map(k=>[k,rows.find(r=>r.puzzle.rules.includes(k))?.courseStage]))};
await fs.writeFile(path.join(archive,'provenance.json'),JSON.stringify(provenance,null,2)+'\n');
console.log(provenance);


