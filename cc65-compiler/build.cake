var version = "2.17";
if(!DirectoryExists("./build/cc65-" + version)) {
	var cc65Zip = DownloadFile("https://github.com/cc65/cc65/archive/V" + version + ".zip");
	Unzip(cc65Zip, "./build");
}
int exitCode = StartProcess("make", "-j32 -C ./build/cc65-" + version);
if(exitCode != 0) {
	throw new Exception("Failure");
}
exitCode = StartProcess("make", "-j32 -C ./build/cc65-" + version + " zip");
if(exitCode != 0) {
	throw new Exception("Failure");
}
if(DirectoryExists("./tools")) {
    DeleteDirectory("./tools", recursive: true);
}
Unzip("./build/cc65-" + version + "/cc65.zip", "./tools");
ChocolateyPack("./cc65-compiler.nuspec", new ChocolateyPackSettings {
	Version = version,
});
