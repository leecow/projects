# Download page generator for .NET Core 1.x
# Not compatible with .NET Core 2.x releases

# Update the Version and Location variables
# Run this script and redirect output to md file. eg ./dl-page-gen-v1 > 1.0.5-download.md
# Paste in sections marked with "*** PLACEHOLDER --- ***".

# Versions
VER_SDK="1.1.3"
VER_RUNTIME="1.0.6"

# Locations
BLOB_ROOT_SDK="https://dotnetcli.blob.core.windows.net/dotnet/Sdk/"
BLOB_ROOT_RUNTIME="https://dotnetcli.blob.core.windows.net/dotnet/Runtime/"
BLOB_ROOT_CHECKSUM="https://dotnetcli.blob.core.windows.net/dotnet/checksums/"
DLC="https://download.microsoft.com/download/"
DLC_ROOT_SDK="B/9/F/B9F1AF57-C14A-4670-9973-CDF47209B5BF"
DLC_ROOT_RUNTIME="7/8/5/7852163D-1A56-4642-84B6-60A8537343EF"

printf "%s\n" "# .NET Core "$VER_RUNTIME
printf "%s\n" 
printf "%s\n" ".NET Core "$VER_RUNTIME" comprises:"
printf "%s\n" 
printf "%s\n" "* .NET Core Runtime "$VER_RUNTIME
printf "%s\n" "* .NET Core SDK "$VER_SDK

printf "%s\n" 
printf "%s\n" "|         | SDK Installer                                         | SDK Binaries                                                         | Runtime Installer                                                  | Runtime Binaries                                                   |"
printf "%s\n" "| ------- | :---------------------------------------------------: | :-------------------------------------------------------------------:| :----------------------------------------------------------------: | :----------------------------------------------------------------: |"
printf "%s\n" "| Windows                 | [32-bit]("$DLC$DLC_ROOT_SDK"/dotnet-dev-win-x86."$VER_SDK".exe) / [64-bit]("$DLC$DLC_ROOT_SDK"/dotnet-dev-win-x64."$VER_SDK".exe)  | [32-bit]("$DLC$DLC_ROOT_SDK"/dotnet-dev-win-x86."$VER_SDK".zip) / [64-bit]("$DLC$DLC_ROOT_SDK"/dotnet-dev-win-x64."$VER_SDK".zip) | [32-bit]("$DLC$DLC_ROOT_RUNTIME"/dotnet-win-x86."$VER_RUNTIME".exe) / [64-bit]("$DLC$DLC_ROOT_RUNTIME"/dotnet-win-x64."$VER_RUNTIME".exe) | [32-bit]("$DLC$DLC_ROOT_RUNTIME"/dotnet-win-x86."$VER_RUNTIME".zip) / [64-bit]("$DLC$DLC_ROOT_RUNTIME"/dotnet-win-x64."$VER_RUNTIME".zip) |"
printf "%s\n" "| macOS                   | [64-bit]("$DLC$DLC_ROOT_SDK"/dotnet-dev-osx-x64."$VER_SDK".pkg)  | [64-bit]("$DLC$DLC_ROOT_SDK"/dotnet-dev-osx-x64."$VER_SDK".tar.gz)                          | [64-bit]("$DLC$DLC_ROOT_RUNTIME"/dotnet-osx-x64."$VER_RUNTIME".pkg) | [64-bit]("$DLC$DLC_ROOT_RUNTIME"/dotnet-osx-x64."$VER_RUNTIME".tar.gz) |"
printf "%s\n" "| CentOS 7.1              | -                                                         | [64-bit]("$DLC$DLC_ROOT_SDK"/dotnet-dev-centos-x64."$VER_SDK".tar.gz)                          | - | [64-bit]("$DLC$DLC_ROOT_RUNTIME"/dotnet-centos-x64."$VER_RUNTIME".tar.gz) |"
printf "%s\n" "| Debian 8                | -                                                         | [64-bit]("$DLC$DLC_ROOT_SDK"/dotnet-dev-debian-x64."$VER_SDK".tar.gz)                          | - | [64-bit]("$DLC$DLC_ROOT_RUNTIME"/dotnet-debian-x64."$VER_RUNTIME".tar.gz) |"
printf "%s\n" "| Ubuntu 14.04            |[64-bit]("$DLC$DLC_ROOT_SDK"/dotnet-sdk-ubuntu-x64."$VER_SDK".deb)   | [64-bit]("$DLC$DLC_ROOT_SDK"/dotnet-dev-ubuntu-x64."$VER_SDK".tar.gz)                          |[64-bit]("$DLC$DLC_ROOT_RUNTIME"/dotnet-sharedframework-ubuntu-x64."$VER_RUNTIME".deb) | [64-bit]("$DLC$DLC_ROOT_RUNTIME"/dotnet-ubuntu-x64."$VER_RUNTIME".tar.gz) |"
printf "%s\n" "| Ubuntu 16.04            |[64-bit]("$DLC$DLC_ROOT_SDK"/dotnet-sdk-ubuntu.16.04-x64."$VER_SDK".deb)   | [64-bit]("$DLC$DLC_ROOT_SDK"/dotnet-dev-ubuntu.16.04-x64."$VER_SDK".tar.gz)                          |[64-bit]("$DLC$DLC_ROOT_RUNTIME"/dotnet-sharedframework-ubuntu.16.04-x64."$VER_RUNTIME".deb) | [64-bit]("$DLC$DLC_ROOT_RUNTIME"/dotnet-ubuntu.16.04-x64."$VER_RUNTIME".tar.gz) |"
printf "%s\n" "| RHEL 7                  | -                                                         | [64-bit]("$DLC$DLC_ROOT_SDK"/dotnet-dev-rhel-x64."$VER_SDK".tar.gz)                          | - | [64-bit]("$DLC$DLC_ROOT_RUNTIME"/dotnet-rhel-x64."$VER_RUNTIME".tar.gz) |"

printf "%s\n" 
printf "%s\n" "**Checksum** files to verify downloads are available as follows:"
printf "%s\n" "* [Checksums_Runtime]("$BLOB_ROOT_CHECKSUM$VER_RUNTIME"-runtime-sha.txt)"
printf "%s\n" "* [Checksums_SDK]("$BLOB_ROOT_CHECKSUM$VER_SDK"-sdk-sha.txt)"
printf "%s\n"
printf "%s\n" "**Debug Symbols**"
printf "%s\n" "* [Shared Framework]("$DLC$DLC_ROOT_RUNTIME"/corefx-"$VER_RUNTIME"-symbols.zip)"
printf "%s\n" "* [Runtime]("$DLC$DLC_ROOT_RUNTIME"/coreclr-"$VER_RUNTIME"-symbols.zip)"

printf "%s\n" 
printf "%s\n" "## Docker"
printf "%s\n" 
printf "%s\n" "Images for .NET Core "$VER_RUNTIME" are available on [Docker](https://hub.docker.com/r/microsoft/dotnet/)."


printf "%s\n" "## Installing .NET Core on Linux"
printf "%s\n" 


