// Generate native configuration workbooks with the project's three-row contract.
import fs from 'node:fs/promises';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { Workbook, SpreadsheetFile } from '@oai/artifact-tool';
const root=path.resolve(path.dirname(fileURLToPath(import.meta.url)), '../..');
const tables=JSON.parse(await fs.readFile(path.join(root,'artifacts/levels/cuddledoku/tables.json'),'utf8'));
for(const [name,{fields,rows}] of Object.entries(tables)) {
  const wb=Workbook.create(); const sheet=wb.worksheets.add(name);
  const matrix=[fields.map(f=>f[0]),fields.map(f=>f[0]),fields.map(f=>f[1]),...rows];
  const end=String.fromCharCode(64+fields.length);
  sheet.getRange(`A1:${end}${matrix.length}`).values=matrix;
  sheet.getRange(`A1:${end}3`).format.fill='#E9E2F5';
  sheet.getRange(`A1:${end}${matrix.length}`).format.columnWidth=22;
  sheet.getRange(`A1:${end}3`).format.rowHeight=24;
  for(let i=0;i<fields.length;i++) {
    const field=fields[i][0], col=String.fromCharCode(65+i);
    if(['Cells','PuzzleHash','PlaceSfxAddress','RuleDeck'].includes(field)) sheet.getRange(`${col}1:${col}${matrix.length}`).format.columnWidth=70;
    else if(['Id','SetRef','ClauseSetRef','BoardRef','LabelKey'].includes(field)) sheet.getRange(`${col}1:${col}${matrix.length}`).format.columnWidth=30;
  }
  wb.recalculate();
  const check=await wb.inspect({kind:'table',range:`${name}!A1:${end}5`,include:'values',tableMaxRows:5,tableMaxCols:fields.length,maxChars:1600});
  console.log(name,check.ndjson);
  const out=path.join(root,'output/native-catalog-build');await fs.mkdir(out,{recursive:true});
  // XLSX is an intermediate only; Export-Xlsm.ps1 writes the final macro-enabled package.
  await (await SpreadsheetFile.exportXlsx(wb)).save(path.join(out,`${name}.xlsx`));
  const preview=await wb.render({sheetName:name,range:`A1:${end}6`,scale:1});
  await fs.writeFile(path.join(out,`${name}.png`),new Uint8Array(await preview.arrayBuffer()));
  await fs.rename(path.join(out,`${name}.xlsx.inspect.ndjson`),path.join(out,`${name}.inspect.ndjson`)).catch(e=>{if(e.code!=='ENOENT') throw e;});
  console.log(`Exported ${name}: ${rows.length} records`);
}
