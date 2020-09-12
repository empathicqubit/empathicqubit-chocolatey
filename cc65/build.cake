var cc65Zip = DownloadFile("https://master.dl.sourceforge.net/project/cc65/cc65-snapshot-win32.zip");
if(DirectoryExists("./tools")) {
    DeleteDirectory("./tools", recursive: true);
}
Unzip(cc65Zip, "./tools");
ChocolateyPack("./cc65.nuspec", new ChocolateyPackSettings {});