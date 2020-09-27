﻿$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://vice.pokefinder.org/dl.php?file=GTK3VICE-3.4-win64-r38635.zip'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = $url
  softwareName  = 'winvice*'
  checksum      = 'dc2565382d7bb87195d78f2ed774919903f7f7c6c776f9539aab2672c96de858'
  checksumType  = 'sha256'
  validExitCodes= @(0, 3010, 1641)
}

Get-ChildItem $toolsDir | Where-Object -Property Name -Like '*GTK3VICE*' | Remove-Item -Recurse
Install-ChocolateyZipPackage @packageArgs
$gtkdir = "$((Get-ChildItem $toolsDir | Where-Object -Property Name -Like '*GTK3VICE*').FullName)"
New-Item -ItemType File "${gtkdir}/bin/gspawn-win64-helper-console.exe.ignore"
New-Item -ItemType File "${gtkdir}/bin/gspawn-win64-helper.exe.ignore"
