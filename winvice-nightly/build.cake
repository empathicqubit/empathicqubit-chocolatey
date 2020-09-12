if(DirectoryExists("./tools")) {
    DeleteDirectory("./tools", recursive: true);
}
var viceWebPage = DownloadFile("https://vice.pokefinder.org");
var match = new System.Text.RegularExpressions.Regex("\"(/dl\\.php\\?file=GTK3VICE-([0-9\\.]+)-[^\"]*-(r[0-9]+)\\.zip)\"").Match(System.IO.File.ReadAllText(viceWebPage.FullPath));
var viceDownloadUrl = match.Groups[1];
var version = match.Groups[2];
var revision = match.Groups[3];
Information(viceDownloadUrl);
Information(version);
Information(revision);
var viceZipFile = DownloadFile("https://vice.pokefinder.org" + viceDownloadUrl);
Unzip(viceZipFile, "./tools");
ChocolateyPack(new ChocolateyPackSettings {
    Id = "winvice-nightly",
    Title = "WinVICE Nightly",
    Version = version + "-" + revision,
    Authors = new[] {"Martin Pottendorfer", "Marco van den Heuvel", "Fabrizio Gennari", "Groepaz", "Olaf Seibert", "Marcus Sutton", "Kajtar Zsolt", "AreaScout", "Bas Wassink", "et al."},
    Owners = new[] {"EmpathicQubit"},
    Summary = "The Versatile Commodore Emulator",
    Description = "VICE is a program that runs on a Unix, MS-DOS, Win32, OS/2, BeOS, QNX 4.x, QNX 6.x, Amiga, Syllable or Mac OS X machine and executes programs intended for the old 8-bit computers. The current version emulates the C64, the C64DTV, the C128, the VIC20, practically all PET models, the PLUS4 and the CBM-II (aka C610/C510). An extra emulator is provided for C64 expanded with the CMD SuperCPU.",
    ProjectUrl = new Uri("http://vice-emu.sourceforge.net/"),
    PackageSourceUrl = new Uri("https://github.com/empathicqubit/empathicqubit-chocolatey"),
    ProjectSourceUrl = new Uri("http://sf.net/projects/vice-emu"),
    DocsUrl = new Uri("http://vice-emu.sourceforge.net/vice_toc.html"),
    MailingListUrl = new Uri("https://sourceforge.net/p/vice-emu/mailman/vice-emu-mail/"),
    BugTrackerUrl = new Uri("http://sourceforge.net/p/vice-emu/bugs/"),
    Tags = new[] { "WinVICE", "VICE", "Emulator", "Commodore", "C64", "C128", "PET", "VIC20"},
    LicenseUrl = new Uri("http://vice-emu.sourceforge.net/COPYING"),
    RequireLicenseAcceptance = false,
    IconUrl = new Uri("https://bytebucket.org/coldacid/chocolatey-packages/raw/master/winvice/vice-logo.png"),
    ReleaseNotes = new[] {"http://vice-emu.sourceforge.net/NEWS"},
    Files = new[] {
        new ChocolateyNuSpecContent { Source = "tools\\**", Target = "tools" },
    },
});