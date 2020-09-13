$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://vice.pokefinder.org/dl.php?file=GTK3VICE-3.4-win64-r38511.zip'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = $url
  softwareName  = 'winvice*'
  checksum      = '00D91BEF37CA4807D6357F039E70259337224819C2B83D09AD2E95681186953C'
  checksumType  = 'sha256'
  validExitCodes= @(0, 3010, 1641)
}

Get-ChildItem $toolsDir | Where-Object -Property Name -Like '*GTK3VICE*' | Sort-Object -Property Name -Descending | Remove-Item -Recurse
Install-ChocolateyZipPackage @packageArgs