$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://lsnes.tasbot.net/lsnes-rrtest-1613424691.7z'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = $url
  softwareName  = 'lsnes*'
  checksum      = '0a4547fbfdfa7270e1c27020e137b57d4e1cff9f84047d4bc6dd384d0e4f73a2'
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
