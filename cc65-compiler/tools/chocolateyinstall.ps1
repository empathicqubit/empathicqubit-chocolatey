$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://sourceforge.net/projects/cc65/files/cc65-snapshot-win32.zip/download'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = $url
  softwareName  = 'cc65*'
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyZipPackage @packageArgs