$splits = $env:ChocolateyPackageVersion.Split('-')
$ver = $splits[0]
$rev = $splits[1]
$ErrorActionPreference = 'Stop';
$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = "https://github.com/VICE-Team/svn-mirror/releases/download/$rev/GTK3VICE-$ver-win64-$rev.zip"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = $url
  softwareName  = 'winvice*'
  checksum      = '<REPLACEME_CHECKSUM>'
  checksumType  = 'sha256'
  validExitCodes= @(0, 3010, 1641)
}

Get-ChildItem $toolsDir | Where-Object -Property Name -Like '*GTK3VICE*' | Remove-Item -Recurse
Install-ChocolateyZipPackage @packageArgs
$gtkdir = "$((Get-ChildItem $toolsDir | Where-Object -Property Name -Like '*GTK3VICE*').FullName)"
New-Item -ItemType File "${gtkdir}/bin/gspawn-win64-helper-console.exe.ignore"
New-Item -ItemType File "${gtkdir}/bin/gspawn-win64-helper.exe.ignore"
