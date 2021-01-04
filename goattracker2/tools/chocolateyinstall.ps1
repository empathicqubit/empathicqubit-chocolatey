$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://pilotfiber.dl.sourceforge.net/project/goattracker2/GoatTracker%202/2.74/GoatTracker_2.74.zip'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = $url
  softwareName  = 'goattracker2*'
  checksum      = '91A859A70E0F3524ADEBCE2D28F00289DB1A93344F126B5DA6E22A8BD646F249'
  checksumType  = 'sha256'
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyZipPackage @packageArgs