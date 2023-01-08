$splits = $env:ChocolateyPackageVersion.Split('-')
$ver = $splits[0]
$rev = $splits[1]
$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileFullPath  = "$toolsDir/Wabbitemu.exe"
  url           = '<REPLACEME_URL>'
  softwareName  = 'wabbitemu*'
  checksum      = '<REPLACEME_CHECKSUM>'
  checksumType  = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

Install-ChocolateyShortcut `
	-ShortcutFilePath "$([Environment]::GetFolderPath('CommonStartMenu'))/Programs/Wabbitemu/Wabbitemu.lnk" `
	-TargetPath $packageArgs.fileFullPath
