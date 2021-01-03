$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/VICE-Team/svn-mirror/releases/download/r39493/GTK3VICE-3.5-win64-r39493.zip'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = $url
  softwareName  = 'winvice*'
  checksum      = '289773a81e57230f7142f780e20f1d3b4393a9dc5efd53ebf7587ac727b1c555'
  checksumType  = 'sha256'
  validExitCodes= @(0, 3010, 1641)
}

Get-ChildItem $toolsDir | Where-Object -Property Name -Like '*GTK3VICE*' | Remove-Item -Recurse
Install-ChocolateyZipPackage @packageArgs
$gtkdir = "$((Get-ChildItem $toolsDir | Where-Object -Property Name -Like '*GTK3VICE*').FullName)"
New-Item -ItemType File "${gtkdir}/bin/gspawn-win64-helper-console.exe.ignore"
New-Item -ItemType File "${gtkdir}/bin/gspawn-win64-helper.exe.ignore"
