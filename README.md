# empathicqubit-chocolatey

Chocolatey packages:

* [cc65-compiler](https://community.chocolatey.org/packages/cc65-compiler)\
Build script uses Cake and .NET Framework. No attention was given to make the script cross platform, as it will not compile correctly on Linux. You need make and mingw.
* [lsnes](https://community.chocolatey.org/packages/lsnes)\
Basic nuspec which can be built on any platform.
* [winvice-nightly](https://community.chocolatey.org/packages/winvice-nightly)\
Build script uses the Cake tool for .NET Core. You will need the .NET Core SDK. Every step works on Linux except for the pack step, which should be able to be swapped out for `dotnet pack` fairly easily.
* [wabbitemu](https://community.chocolatey.org/packages/wabbitemu)\
Build script uses the Cake tool for .NET Core. You will need the .NET Core SDK. Does not build on Linux, because Wabbit is Windows-only
* [goattracker](https://community.chocolatey.org/packages/goattracker)\
Basic nuspec which can be built on any platform.
