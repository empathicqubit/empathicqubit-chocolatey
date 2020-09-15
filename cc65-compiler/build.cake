#addin Cake.FileHelpers
var version = "2.17";
var buildDir = "./build/cc65-" + version;
if(!DirectoryExists(buildDir)) {
	var cc65Zip = DownloadFile("https://github.com/cc65/cc65/archive/V" + version + ".zip");
	Unzip(cc65Zip, "./build");
}
int exitCode = StartProcess("make", "-j32 -C " + buildDir);
if(exitCode != 0) {
	throw new Exception("Failure");
}
exitCode = StartProcess("make", "-j32 -C " + buildDir + " zip");
if(exitCode != 0) {
	throw new Exception("Failure");
}
if(DirectoryExists("./tools")) {
    DeleteDirectory("./tools", recursive: true);
}
Unzip(buildDir + "/cc65.zip", "./tools");
var license = FileReadText(buildDir + "/LICENSE");
FileWriteText("./tools/LICENSE.txt", "From: https://raw.githubusercontent.com/cc65/cc65/master/LICENSE\n\n" + license);
CopyFile("./VERIFICATION.txt", "./tools/VERIFICATION.txt");
ChocolateyPack("./cc65-compiler.nuspec", new ChocolateyPackSettings {
	Version = version,
});