$ErrorActionPreference = 'Stop'

# Resolve the user's Ruby tools without embedding a machine-specific path.
$rubyGemDirectory = (& wsl -d Debian -- ruby -r rubygems -e Gem.user_dir.display).Trim()
$wslUserDirectory = (& wsl -d Debian -- printenv HOME).Trim()
& wsl -d Debian --cd $PSScriptRoot -- env JEKYLL_ENV=production BUNDLE_FROZEN=true "BUNDLE_PATH=$wslUserDirectory/.bundle/blog" "$rubyGemDirectory/bin/bundle" exec jekyll build --destination dist/site
if ($LASTEXITCODE -ne 0) { throw 'Jekyll production build failed.' }

$sitePath = Join-Path $PSScriptRoot 'dist\site'
$archivePath = Join-Path $PSScriptRoot 'dist\blog-static.zip'
[IO.File]::WriteAllText((Join-Path $sitePath '.nojekyll'), '')
Compress-Archive -Path (Join-Path $sitePath '*') -DestinationPath $archivePath -Force
Write-Output "Static package: $archivePath"
