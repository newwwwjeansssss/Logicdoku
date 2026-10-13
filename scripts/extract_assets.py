from pathlib import Path
import UnityPy,json,collections
UnityPy.config.FALLBACK_UNITY_VERSION="6000.3.16f1"
root=Path(__file__).resolve().parents[1]
out=root/'decoded';out.mkdir(exist_ok=True)
report=[]
for p in (root/'extracted/assets/AssetBundle').glob('*.ab'):
    raw=p.read_bytes(); offset=raw.find(b'UnityFS\0'); item={'bundle':p.name,'offset':offset,'objects':[]}
    try:
        env=UnityPy.load(raw[offset:])
        for obj in env.objects:
            typ=obj.type.name
            try:
                data=obj.read(); name=getattr(data,'m_Name','')
                row={'type':typ,'name':name,'id':obj.path_id}
                if typ=='TextAsset':
                    d=out/p.stem;d.mkdir(exist_ok=True)
                    dest=d/(str(obj.path_id)+'_'+name.replace('/','_'))
                    body=data.m_Script
                    dest.write_bytes(body.encode('utf8','surrogateescape') if isinstance(body,str) else body)
                    row['file']=str(dest.relative_to(root))
                item['objects'].append(row)
            except Exception as e: item['objects'].append({'type':typ,'error':str(e)})
    except Exception as e: item['error']=str(e)
    report.append(item)
    print(p.name,collections.Counter(x['type'] for x in item['objects']),item.get('error',''))
(root/'reports/asset-index.json').write_text(json.dumps(report,ensure_ascii=False,indent=2))
