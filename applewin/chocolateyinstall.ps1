$ver = $env:ChocolateyPackageVersion
$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = '<REPLACEME_URL>'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = "$toolsDir/AppleWin-$ver"
  url           = $url
  softwareName  = 'applewin*'
  checksum      = '<REPLACEME_CHECKSUM>'
  checksumType  = 'sha256'
  validExitCodes= @(0, 3010, 1641)
}

Get-ChildItem $toolsDir | Where-Object -Property Name -Like '*AppleWin*' | Remove-Item -Recurse
Install-ChocolateyZipPackage @packageArgs
$appleWinDir = "$((Get-ChildItem $toolsDir | Where-Object -Property Name -Like '*AppleWin*').FullName)"

foreach ($exe in $(Get-ChildItem -Path "$appleWinDir" -Filter '*.exe')) {
	Write-Host "Checking "$exe.Name
	Write-Host "Adding shortcut to "$exe.Name
	Install-ChocolateyShortcut `
	  -ShortcutFilePath "$([Environment]::GetFolderPath('CommonStartMenu'))/Programs/AppleWin/$($exe.BaseName).lnk" `
	  -TargetPath $exe.FullName
}
