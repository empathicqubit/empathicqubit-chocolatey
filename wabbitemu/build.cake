#addin nuget:?package=Cake.Http&version=2.0.0
#addin nuget:?package=Newtonsoft.Json&version=12.0.3
#addin nuget:?package=Cake.FileHelpers&version=5.0.0
// JSON.parse($0.textContent)[0].assets.find(x => /win64/i.test(x.name)).browser_download_url
// https://api.github.com/repos/Vice-Team/svn-mirror/releases?per_page=1
var releasesText = HttpGet("https://api.github.com/repos/empathicqubit/wabbitemu/releases?per_page=1");
dynamic releases = Newtonsoft.Json.JsonConvert.DeserializeObject(releasesText);
dynamic release = releases[0];
var body = (string)release.body;
var assets = (IEnumerable<object>)release.assets;
dynamic asset = assets.First((dynamic x) => new System.Text.RegularExpressions.Regex("^wabbitemu.*\\.exe", System.Text.RegularExpressions.RegexOptions.IgnoreCase).IsMatch((string)x.name));

var url = (string)asset.browser_download_url;
var name = (string)asset.name;
var ver = new System.Text.RegularExpressions.Regex("([0-9]+\\b\\.?){3,}").Match(url).Groups[0].Value;

Information($"URL: {url}");
Information($"Name: {name}");
Information($"Version: {ver}");

var cacheFilePath = "./build/" + name;
if(!FileExists(cacheFilePath)) {
	var dl = DownloadFile(url);
	CreateDirectory("./build");
	MoveFile(dl, cacheFilePath);
}
var sha = CalculateFileHash(cacheFilePath, HashAlgorithm.SHA256).ToHex();
var newText = FileReadText("./chocolateyinstall.ps1").Replace("<REPLACEME_CHECKSUM>", sha);
newText = newText.Replace("<REPLACEME_URL>", url);
try {
	CreateDirectory("./tools");
}
catch {}
FileWriteText("./tools/chocolateyinstall.ps1", newText);
CopyFile("./chocolateyuninstall.ps1", "./tools/chocolateyuninstall.ps1");
ChocolateyPack("./wabbitemu.nuspec", new ChocolateyPackSettings {
	Version = ver + "-pre" + new System.Random().Next(),
});
