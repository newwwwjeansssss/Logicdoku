from pathlib import Path
from elftools.elf.elffile import ELFFile
from elftools.elf.relocation import RelocationSection
from capstone import Cs,CS_ARCH_ARM64,CS_MODE_ARM
import struct,json
ROOT=Path(__file__).resolve().parents[1]
path=ROOT/'extracted/lib/arm64-v8a/libil2cpp.so'
f=path.open('rb');elf=ELFFile(f);raw=path.read_bytes()
segments=[s for s in elf.iter_segments() if s['p_type']=='PT_LOAD']
def fileoff(va):
 for s in segments:
  if s['p_vaddr']<=va<s['p_vaddr']+s['p_filesz']:return s['p_offset']+va-s['p_vaddr']
 raise ValueError(hex(va))
def vaof(off):
 for s in segments:
  if s['p_offset']<=off<s['p_offset']+s['p_filesz']:return s['p_vaddr']+off-s['p_offset']
 raise ValueError(off)
rel={}
for sec in elf.iter_sections():
 if isinstance(sec,RelocationSection):
  for r in sec.iter_relocations():
   if r['r_info_type']==1027:rel[r['r_offset']]=r['r_addend']
def u64(va):return rel.get(va,struct.unpack_from('<Q',raw,fileoff(va))[0])
def cstring(va):
 o=fileoff(va);return raw[o:raw.index(0,o)].decode(errors='replace')
meta=json.loads((ROOT/'reports/metadata-parsed.json').read_text());name_map={};mapped=[]
for im in meta['images']:
 name=im['name'];pos=raw.find(name.encode()+b'\0')
 if pos<0:continue
 addr=vaof(pos);refs=[a for a,v in rel.items() if v==addr]
 for module in refs:
  count=u64(module+8);ptr=u64(module+16)
  if not 0<count<100000:continue
  try:
   methods=[m for t in meta['types'] if t['image']==name for m in t['methods']]
   if max((m['token']&0xffffff for m in methods),default=0)>count:continue
   for t in meta['types']:
    if t['image']!=name:continue
    for m in t['methods']:
     idx=(m['token']&0xffffff)-1;address=u64(ptr+idx*8)
     row={**m,'type':t['name'],'namespace':t['namespace'],'image':name,'address':address,'hex':hex(address)}
     mapped.append(row)
     if address:name_map[address]=t['name']+'.'+m['name']
   if name=='Pairzzle.Runtime.dll':print('module',hex(module),'methods',count,'table',hex(ptr))
   break
  except (ValueError,struct.error):continue
(ROOT/'reports/native-methods.json').write_text(json.dumps(mapped,indent=2))
if __name__=='__main__':
 md=Cs(CS_ARCH_ARM64,CS_MODE_ARM);out=ROOT/'native';out.mkdir(exist_ok=True)
 alladdrs=sorted(name_map)
 for m in mapped:
  if m['image']!='Pairzzle.Runtime.dll' or not m['address']:continue
  if not(any(k in m['type'] for k in ('Solver','Rule','GameSession','Hint','Puzzle','BoardState','Settings','Constraint'))):continue
  a=m['address'];end=next((x for x in alladdrs if x>a),a+4096);size=min(end-a,20000)
  try:code=raw[fileoff(a):fileoff(a)+size]
  except ValueError:continue
  lines=[f"// {m['namespace']}.{m['type']}.{m['name']} token={m['token']:#x} VA={a:#x}"]
  for ins in md.disasm(code,a):
   note=''
   if ins.mnemonic in ('b','bl'):
    try:target=int(ins.op_str.removeprefix('#'),16);note=' ; '+name_map.get(target,'')
    except:pass
   lines.append(f'{ins.address:08x}: {ins.mnemonic:8} {ins.op_str}{note}')
  (out/f"{m['type']}_{m['name'].replace('/','_')}_{a:x}.asm").write_text('\n'.join(lines))
 print('mapped',len(mapped),'methods')
