"""Decode bundled level files: undo left rotation floor(n/5), then repeating XOR."""
from pathlib import Path
import json,hashlib
ROOT=Path(__file__).resolve().parents[1]
KEY=b'iDailybread.org'
def decode(raw):
 shift=len(raw)//5
 ordered=raw[-shift:]+raw[:-shift] if shift else raw
 return bytes(v^KEY[i%len(KEY)] for i,v in enumerate(ordered))
def encode(clear):
 raw=bytes(v^KEY[i%len(KEY)] for i,v in enumerate(clear));shift=len(raw)//5
 return raw[shift:]+raw[:shift]
def main():
 out=ROOT/'levels';out.mkdir(exist_ok=True);summary={}
 for name in ('MainLevel','Test1','Test2'):
  source=ROOT/'raw_levels'/f'{name}.bytes'
  if not source.exists():source=next((ROOT/'decoded').glob(f'local_config*/*_{name}'))
  raw=source.read_bytes();clear=decode(raw)
  assert encode(clear)==raw
  data=json.loads(clear)
  (out/f'{name}.json').write_text(json.dumps(data,ensure_ascii=False,indent=2))
  if name != 'MainLevel':
   puzzles={k:json.loads(v['LevelJsonData']) for k,v in data.items()}
   (out/f'{name}.puzzles.json').write_text(json.dumps(puzzles,ensure_ascii=False,indent=2))
  summary[name]={'records':len(data),'bytes':len(raw),'sha256':hashlib.sha256(raw).hexdigest(),'roundtrip':True}
  print(name,len(data),'first',str(next(iter(data.values())))[:1300])
 (out/'decode-summary.json').write_text(json.dumps(summary,indent=2))
if __name__=='__main__':main()
