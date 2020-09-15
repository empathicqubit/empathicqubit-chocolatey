$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://vice.pokefinder.org/dl.php?file=GTK3VICE-3.4-win64-r38522.zip'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = $url
  softwareName  = 'winvice*'
  checksum      = 'A2CC50F1268DF3F1DBD319815CBCD9D501CCD6719C61622B7AB87634C6F82661'
  checksumType  = 'sha256'
  validExitCodes= @(0, 3010, 1641)
}

Get-ChildItem $toolsDir | Where-Object -Property Name -Like '*GTK3VICE*' | Sort-Object -Property Name -Descending | Remove-Item -Recurse
Install-ChocolateyZipPackage @packageArgs