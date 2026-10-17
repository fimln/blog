$ErrorActionPreference = 'Stop'
Set-Location -LiteralPath $PSScriptRoot
$hugo = Join-Path $PSScriptRoot '.tools/hugo/hugo.exe'
if (-not (Test-Path -LiteralPath $hugo)) { throw 'Hugo is missing. Run ./setup.ps1 first.' }
& $hugo --gc --destination dist/site --cleanDestinationDir
if ($LASTEXITCODE -ne 0) { throw 'Hugo production build failed.' }
$sitePath = Join-Path $PSScriptRoot 'dist/site'
$archivePath = Join-Path $PSScriptRoot 'dist/blog-static.zip'
[IO.File]::WriteAllText((Join-Path $sitePath '.nojekyll'), '')
Compress-Archive -Path (Join-Path $sitePath '*') -DestinationPath $archivePath -Force
Write-Output "Static package: $archivePath"
