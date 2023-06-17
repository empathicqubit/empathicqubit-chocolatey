$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://sourceforge.net/projects/goattracker2/files/GoatTracker%202/2.76/GoatTracker_2.76.zip'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = $url
  softwareName  = 'goattracker2*'
  checksum      = 'c1b6b159ec0d37ae68599ac83be8934a71cd543e480eb5225f844b62151cea34'
  checksumType  = 'sha256'
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyZipPackage @packageArgs
