$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://vice.pokefinder.org/dl.php?file=GTK3VICE-3.4-win64-r38557.zip'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = $url
  softwareName  = 'winvice*'
  checksum      = 'B8FD323619B288FECD2D5A4BB3DB49FDE6FA0B6E946961DA98CE29FCE131CA37'
  checksumType  = 'sha256'
  validExitCodes= @(0, 3010, 1641)
}

Get-ChildItem $toolsDir | Where-Object -Property Name -Like '*GTK3VICE*' | Sort-Object -Property Name -Descending | Remove-Item -Recurse
Install-ChocolateyZipPackage @packageArgs