$ErrorActionPreference = 'Stop';
Remove-Item -Recurse "$([Environment]::GetFolderPath('CommonStartMenu'))/Programs/Wabbitemu"
