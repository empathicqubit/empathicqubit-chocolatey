$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://lsnes.tasbot.net/lsnes-rrtest-1624628005.7z'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = $url
  softwareName  = 'lsnes*'
  checksum      = 'e6295704873ef44762bb6dd3d80f692a345bc13654bf92eaae09183c8030a6ae'
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
