$ErrorActionPreference = 'Stop'
$version = '0.167.0'
$toolPath = Join-Path $PSScriptRoot '.tools/hugo'
$executable = Join-Path $toolPath 'hugo.exe'
if ((Test-Path -LiteralPath $executable) -and ((& $executable version) -like "hugo v$version-*")) {
    Write-Output "Hugo $version is already installed."
    return
}
New-Item -ItemType Directory -Path $toolPath -Force | Out-Null
$archive = "hugo_${version}_windows-amd64.zip"
$download = Join-Path $toolPath $archive
$checksums = Join-Path $toolPath "hugo_${version}_checksums.txt"
$release = "https://github.com/gohugoio/hugo/releases/download/v$version"
Invoke-WebRequest "$release/$archive" -OutFile $download
Invoke-WebRequest "$release/hugo_${version}_checksums.txt" -OutFile $checksums
$expected = ((Get-Content $checksums | Where-Object { ($_ -split '\s+')[-1] -eq $archive }) -split '\s+')[0]
if (-not $expected -or (Get-FileHash $download -Algorithm SHA256).Hash -ne $expected) { throw 'Hugo checksum verification failed.' }
Expand-Archive -LiteralPath $download -DestinationPath $toolPath -Force -ErrorAction Stop
& (Join-Path $toolPath 'hugo.exe') version
if ($LASTEXITCODE -ne 0) { throw 'Hugo setup failed.' }
