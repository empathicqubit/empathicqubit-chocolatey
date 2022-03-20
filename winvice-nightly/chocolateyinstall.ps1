$splits = $env:ChocolateyPackageVersion.Split('-')
$ver = $splits[0]
$rev = $splits[1]
$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = '<REPLACEME_URL>'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = $url
  softwareName  = 'winvice*'
  checksum      = '<REPLACEME_CHECKSUM>'
  checksumType  = 'sha256'
  validExitCodes= @(0, 3010, 1641)
}

Get-ChildItem $toolsDir | Where-Object -Property Name -Like '*GTK3VICE*' | Remove-Item -Recurse
Install-ChocolateyZipPackage @packageArgs
$gtkdir = "$((Get-ChildItem $toolsDir | Where-Object -Property Name -Like '*GTK3VICE*').FullName)"
New-Item -ItemType File "${gtkdir}/bin/gspawn-win64-helper-console.exe.ignore"
New-Item -ItemType File "${gtkdir}/bin/gspawn-win64-helper.exe.ignore"

foreach ($exe in $(Get-ChildItem -Path "$gtkdir/bin" -Filter '*.exe')) {
	Write-Host "Checking "$exe.Name
	if(
		@('gspawn-win64-helper.exe', 'gspawn-win64-helper-console.exe', 'petcat.exe', 'c1541.exe', 'cartconv.exe').Contains($exe.Name)
		) {
		continue
	}
	Write-Host "Adding shortcut to "$exe.Name
	Install-ChocolateyShortcut `
	  -ShortcutFilePath "$([Environment]::GetFolderPath('CommonStartMenu'))/Programs/VICE/$($exe.BaseName).lnk" `
	  -TargetPath $exe.FullName
}
