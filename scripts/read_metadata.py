from pathlib import Path
import struct,json
ROOT=Path(__file__).resolve().parents[1]
raw=(ROOT/'extracted/assets/bin/Data/Managed/Metadata/global-metadata.dat').read_bytes()
b=bytearray(raw)
for i in range(len(b)):
 if i<4096 or (i>=65536 and 4096<=i%65536<20480):b[i]^=0x66
names='stringLiterals stringLiteralData strings events properties methods parameterDefaultValues fieldDefaultValues fieldAndParameterDefaultValueData fieldMarshaledSizes parameters fields genericParameters genericParameterConstraints genericContainers nestedTypes interfaces vtableMethods interfaceOffsets typeDefinitions images assemblies fieldRefs referencedAssemblies attributeData attributeDataRanges unresolvedIndirectCallParameterTypes unresolvedIndirectCallParameterRanges windowsRuntimeTypeNames windowsRuntimeStrings exportedTypeDefinitions'.split()
sections={n:dict(zip(('offset','size','count'),struct.unpack_from('<III',b,8+i*12))) for i,n in enumerate(names)}
def st(idx):
 o=sections['strings']['offset']+idx
 return b[o:b.index(0,o)].decode('utf8','replace')
def records(name,fmt):
 s=sections[name];sz=struct.calcsize(fmt);assert s['size']==sz*s['count'],(name,s,sz)
 return [struct.unpack_from(fmt,b,s['offset']+i*sz) for i in range(s['count'])]
types=[]
for i,r in enumerate(records('typeDefinitions','<IIHHHH9I8HII')):
 types.append(dict(index=i,name=st(r[0]),namespace=st(r[1]),byval=r[2],fieldStart=r[7],methodStart=r[8],methodCount=r[15],fieldCount=r[17],token=r[-1]))
methods=[]
for i,r in enumerate(records('methods','<IHHIHHI4H')):
 methods.append(dict(index=i,name=st(r[0]),declaringType=r[1],returnType=r[2],parameterStart=r[4],token=r[6],flags=r[7],parameterCount=r[-1]))
fields=[]
for i,r in enumerate(records('fields','<IHI')):fields.append(dict(index=i,name=st(r[0]),type=r[1],token=r[2]))
images=[]
for r in records('images','<IIHIH5I'):images.append(dict(name=st(r[0]),typeStart=r[2],typeCount=r[3]))
for t in types:
 t['image']=next((im['name'] for im in images if im['typeStart']<=t['index']<im['typeStart']+im['typeCount']),None)
 t['methods']=methods[t['methodStart']:t['methodStart']+t['methodCount']]
 t['fields']=fields[t['fieldStart']:t['fieldStart']+t['fieldCount']]
result={'sections':sections,'images':images,'types':types}
(ROOT/'reports/metadata-parsed.json').write_text(json.dumps(result,ensure_ascii=False,indent=2))
selected=[t for t in types if 'Pairzzle' in t['image'] or 'Pairzzle' in t['name'] or 'Hint' in t['name']]
(ROOT/'reports/game-types.json').write_text(json.dumps(selected,ensure_ascii=False,indent=2))
(ROOT/'reports/metadata-string-table.txt').write_text(b[sections['strings']['offset']:sections['strings']['offset']+sections['strings']['size']].decode('utf8','replace').replace('\0','\n'))
for t in selected:
 if any(x in t['name'] for x in ['Solver','Rules','HintReason','GameSession','HintDefine']):
  print(t['index'],t['image'],t['namespace'],t['name']);print('FIELDS',[f['name'] for f in t['fields']]);print('METHODS',[(m['index'],m['name'],hex(m['token'])) for m in t['methods']])
