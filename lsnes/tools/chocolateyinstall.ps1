$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://lsnes.tasbot.net/lsnes-rr2-beta24.7z'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = $url
  softwareName  = 'lsnes*'
  checksum      = '9d3dc711e22bca6a7246db99ceeb6f380ea0b74ea3cbb09d6b4f5a5a2e3a24f2'
  checksumType  = 'sha256'
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyZipPackage @packageArgs
