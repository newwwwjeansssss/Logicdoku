# Convert generated workbook packages without changing the project's Python tools.
$ErrorActionPreference = 'Stop'
$projectRoot = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '../..'))
Add-Type -AssemblyName System.IO.Compression.FileSystem
foreach ($tableName in @('puzzleRoute','puzzleBoard','puzzleClause','symbolSkin')) {
    $intermediate = Join-Path $projectRoot "output/native-catalog-build/$tableName.xlsx"
    $destination = Join-Path $projectRoot "Excle/$tableName.xlsm"
    $temporary = "$destination.tmp"
    Copy-Item -LiteralPath $intermediate -Destination $temporary -Force
    $package = [IO.Compression.ZipFile]::Open($temporary, [IO.Compression.ZipArchiveMode]::Update)
    try {
        $entry = $package.GetEntry('[Content_Types].xml')
        $reader = [IO.StreamReader]::new($entry.Open())
        $content = $reader.ReadToEnd(); $reader.Dispose()
        $xlsxType = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml'
        if (-not $content.Contains($xlsxType)) { throw "Unexpected workbook type: $tableName" }
        $content = $content.Replace($xlsxType, 'application/vnd.ms-excel.sheet.macroEnabled.main+xml')
        $entry.Delete()
        $writer = [IO.StreamWriter]::new($package.CreateEntry('[Content_Types].xml').Open(), [Text.UTF8Encoding]::new($false))
        $writer.Write($content); $writer.Dispose()
    } finally { $package.Dispose() }
    Move-Item -LiteralPath $temporary -Destination $destination -Force
    Write-Output "Exported $destination"
}
