$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://lsnes.tasbot.net/lsnes-rr2-beta25.7z'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = $url
  softwareName  = 'lsnes*'
  checksum      = 'fded149d81387cc7664b199cea111714068888049a2555d4547f169c7a4e0655'
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
