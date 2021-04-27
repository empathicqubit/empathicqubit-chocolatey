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

foreach ($exe in $(Get-ChildItem -Path "$toolsDir" -Filter '*.exe')) {
	Write-Host "Checking "$exe.Name
	if(
		-not @('lsnes-gambatte.exe', 'lsnes-bsnes.exe').Contains($exe.Name)
		) {
		continue
	}
	Write-Host "Adding shortcut to "$exe.Name
	Install-ChocolateyShortcut `
	  -ShortcutFilePath "$([Environment]::GetFolderPath('CommonStartMenu'))/Programs/lsnes/$($exe.BaseName).lnk" `
	  -TargetPath $exe.FullName
}
