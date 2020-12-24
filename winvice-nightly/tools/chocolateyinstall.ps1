$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://sourceforge.net/projects/vice-emu/files/releases/binaries/windows/GTK3VICE-3.5-win64.7z/download'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = $url
  softwareName  = 'winvice*'
  checksum      = '54f0500a77515bdf75ede72188954a11738e62b91ae86cf5a02c824fd8917dac'
  checksumType  = 'sha256'
  validExitCodes= @(0, 3010, 1641)
}

Get-ChildItem $toolsDir | Where-Object -Property Name -Like '*GTK3VICE*' | Remove-Item -Recurse
Install-ChocolateyZipPackage @packageArgs
$gtkdir = "$((Get-ChildItem $toolsDir | Where-Object -Property Name -Like '*GTK3VICE*').FullName)"
New-Item -ItemType File "${gtkdir}/bin/gspawn-win64-helper-console.exe.ignore"
New-Item -ItemType File "${gtkdir}/bin/gspawn-win64-helper.exe.ignore"
