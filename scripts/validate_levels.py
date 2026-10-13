from pathlib import Path
import json,collections
from reference_solver import basic_puzzle,solutions,local_hint,get_hint
ROOT=Path(__file__).resolve().parents[1]

def main():
 mapping=json.loads((ROOT/'levels/MainLevel.json').read_text())
 banks={name:json.loads((ROOT/f'levels/{name}.puzzles.json').read_text()) for name in ('Test1','Test2')}
 assert len(mapping)==400 and len(banks['Test1'])==400 and len(banks['Test2'])==40
 counts=collections.Counter();rule_counts=collections.Counter()
 for name,bank in banks.items():
  for key,p in bank.items():
   assert str(p['id'])==key
   n=p['size'];assert n in (4,6,8)
   counts[str(n)]+=1;rule_counts.update(p['rules'])
   def point(r,c):assert 0<=r<n and 0<=c<n
   seen=set();holes={(h['r'],h['c']) for h in p.get('holes',[])}
   for r,c in holes:point(r,c)
   for g in p['givens']:
    rc=(g['r'],g['c']);point(*rc)
    assert rc not in seen and rc not in holes and g['s'] in (1,2)
    seen.add(rc)
   for e in p.get('edges',[]):
    point(e['r1'],e['c1']);point(e['r2'],e['c2']);assert e['t'] in ('eq','x')
   if p.get('regions'):
    assert (len(p['regions'])==n*n and all(isinstance(x,int) for x in p['regions'])) or (len(p['regions'])==n and all(isinstance(row,list) and len(row)==n for row in p['regions']))
   for c in p.get('cornerClues',[]):
    assert 0<=c['r']<n-1 and 0<=c['c']<n-1 and 0<=c['value']<=4
   for c in p.get('edgeClues',[]):
    assert c['line'] in ('row','col') and 0<=c['index']<n
 for row in mapping.values():
  for field in ('IosTest1LevelID','AndroidTest1LevelID'):assert str(row[field]) in banks['Test1']
  if row['AndroidTest2GuideLevel5'] is not None:assert str(row['AndroidTest2GuideLevel5']) in banks['Test2']
 p=banks['Test1']['5'];cells,validate=basic_puzzle(p)
 expected=['.....S','S.S..S','.M..M.','.S..S.','M.M..M','.....M']
 assert [''.join('.SM'[v] for v in cells[i:i+6]) for i in range(0,36,6)]==expected
 found=solutions(cells,validate,2);assert len(found)==1
 assert found[0]==[2,1,2,2,1,1,1,2,1,2,2,1,1,2,1,1,2,2,2,1,2,2,1,1,2,1,2,1,1,2,1,2,1,1,2,2]
 hint=local_hint(cells,validate);assert (hint.index,hint.symbol)==(7,2)
 assert get_hint(cells,validate)==hint
 # Generic search tests: multiplicity, unsatisfiable input, global-only hint.
 assert len(solutions([0,0],lambda b:[],2))==2
 assert solutions([1],lambda b:[{0}],2)==[]
 def nonlocal_validator(b):return [{99}] if b[0]==1 else []
 assert local_hint([0],nonlocal_validator) is None
 assert get_hint([0],nonlocal_validator).symbol==2
 try:basic_puzzle(banks['Test1']['30'])
 except NotImplementedError:pass
 else:raise AssertionError('Unsupported rules must not silently pass')
 summary={'puzzles':440,'mapping_rows':400,'sizes':dict(counts),'rule_occurrences':dict(rule_counts),'all_mapping_references_valid':True,'level5_matches_screenshot':True,'level5_unique_under_basic_rules':True,'level5_solution':found[0],'level5_first_local_hint':vars(hint),'note':'Other 439 puzzles received structural checks, not full solver/uniqueness validation.'}
 (ROOT/'reports/validation.json').write_text(json.dumps(summary,indent=2))
 print(json.dumps(summary,indent=2))
if __name__=='__main__':main()
