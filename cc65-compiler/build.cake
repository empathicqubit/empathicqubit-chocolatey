#addin nuget:?package=Cake.FileHelpers
// JSON.parse($0.textContent)[0].assets.find(x => /win64/i.test(x.name)).browser_download_url
// https://api.github.com/repos/Vice-Team/svn-mirror/releases?per_page=1

var url = "https://sourceforge.net/projects/cc65/files/cc65-snapshot-win32.zip/download";
var ver = "2.19";

Information($"URL: {url}");

var zipFilePath = "./build/cc65-snapshot-win32.zip";
if(FileExists(zipFilePath)) {
	DeleteFile(zipFilePath);
}

var dl = DownloadFile(url);
CreateDirectory("./build");
MoveFile(dl, zipFilePath);

var sha = CalculateFileHash(zipFilePath, HashAlgorithm.SHA256).ToHex();
var extractDir = Context.Environment.GetSpecialPath(SpecialPath.LocalTemp) + "/cc65-extract-" + sha;


try {
	DeleteDirectory(extractDir, new DeleteDirectorySettings {
		Recursive = true,
		Force = true
	});
}
catch {}

try {
	Information(extractDir);
	CreateDirectory(extractDir);
	Unzip(zipFilePath, extractDir);

	var rev = "";

	var proc = StartAndReturnProcess(extractDir + "/bin/cc65.exe", new ProcessSettings {
            RedirectStandardError = true,
            Arguments = new ProcessArgumentBuilder()
                .Append(@"--version")
            }
        );

	proc.WaitForExit();
        var output = String.Join("", proc.GetStandardError());
	rev = new System.Text.RegularExpressions.Regex("[0-9a-fA-F]+$", System.Text.RegularExpressions.RegexOptions.Multiline).Match(output).ToString();

	ChocolateyPack("./cc65-compiler.nuspec", new ChocolateyPackSettings {
		Version = ver + "-" + rev,
	});
}
finally {
	try {
		throw new Exception();
		DeleteDirectory(extractDir, new DeleteDirectorySettings {
			Recursive = true,
			Force = true
		});
	}
	catch {}
}
