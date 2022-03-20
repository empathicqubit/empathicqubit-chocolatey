#addin nuget:?package=Cake.Http
#addin nuget:?package=Newtonsoft.Json&version=12.0.3
#addin nuget:?package=Cake.FileHelpers
// JSON.parse($0.textContent)[0].assets.find(x => /win64/i.test(x.name)).browser_download_url
// https://api.github.com/repos/Vice-Team/svn-mirror/releases?per_page=1
var releasesText = HttpGet("https://api.github.com/repos/Vice-Team/svn-mirror/releases?per_page=1");
dynamic releases = Newtonsoft.Json.JsonConvert.DeserializeObject(releasesText);
dynamic release = releases[0];
var assets = (IEnumerable<object>)release.assets;
dynamic asset = assets.First((dynamic x) => new System.Text.RegularExpressions.Regex("-win64-.*\\.zip", System.Text.RegularExpressions.RegexOptions.IgnoreCase).IsMatch((string)x.name));

var url = (string)asset.browser_download_url;
var name = (string)asset.name;
var ver = new System.Text.RegularExpressions.Regex("GTK.*-([0-9]+\\.[0-9]+(\\.[0-9]+)?)-").Match(name).Groups[1].Value;
var rev = (string)release.tag_name;

Information($"URL: {url}");
Information($"Name: {name}");
Information($"Version: {ver}");
Information($"Revision: {rev}");

var zipFilePath = "./build/" + name;
if(!FileExists(zipFilePath)) {
	var dl = DownloadFile(url);
	CreateDirectory("./build");
	MoveFile(dl, zipFilePath);
}
var sha = CalculateFileHash(zipFilePath, HashAlgorithm.SHA256).ToHex();
var newText = FileReadText("./chocolateyinstall.ps1").Replace("<REPLACEME_CHECKSUM>", sha);
newText = newText.Replace("<REPLACEME_URL>", url);
try {
	CreateDirectory("./tools");
}
catch {}
FileWriteText("./tools/chocolateyinstall.ps1", newText);
CopyFile("./chocolateyuninstall.ps1", "./tools/chocolateyuninstall.ps1");
ChocolateyPack("./winvice-nightly.nuspec", new ChocolateyPackSettings {
	Version = ver + "-" + rev,
});
