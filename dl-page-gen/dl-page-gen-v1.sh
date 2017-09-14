# Download page generator for .NET Core 1.x
# Not compatible with .NET Core 2.x releases

# Update the Version and Location variables
# Run this script and redirect output to md file. eg ./dl-page-gen-v1 > 1.0.5-download.md

# Versions
VER_SDK="1.1.4"
VER_RUNTIME="1.1.4"

# Locations
# 1.0.6 - E/9/E/E9E929B2-6532-43D7-98D2-E0B4445912BD
# 1.1.4 - 6/F/B/6FB4F9D2-699B-4A40-A674-B7FF41E0E4D2
# SDK 1.1.4 - F/4/F/F4FCB6EC-5F05-4DF8-822C-FF013DF1B17F

BLOB_ROOT_SDK="https://dotnetcli.blob.core.windows.net/dotnet/Sdk/"
BLOB_ROOT_RUNTIME="https://dotnetcli.blob.core.windows.net/dotnet/Runtime/"
BLOB_ROOT_CHECKSUM="https://dotnetcli.blob.core.windows.net/dotnet/checksums/"
DLC="https://download.microsoft.com/download/"
DLC_ROOT_SDK="F/4/F/F4FCB6EC-5F05-4DF8-822C-FF013DF1B17F"
DLC_ROOT_RUNTIME="6/F/B/6FB4F9D2-699B-4A40-A674-B7FF41E0E4D2"

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
printf "%s\n"
printf "%s\n" "## Installing .NET Core on Linux"
printf "%s\n" 
printf "%s\n" "### Ubuntu and Debian based systems"
printf "%s\n" 
printf "%s\n" 'Register the Microsoft key, the product repository for your distro and install required system dependencies with the following scripts.'
printf "%s\n" 
printf "%s\n" "#### Ubuntu 16.04 and Linux Mint 18"
printf "%s\n" 
printf "%s\n" '```bash'
printf "%s\n" 'curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg'
printf "%s\n" 'sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg'
printf "%s\n" 'sudo sh -c '\''echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-xenial-prod xenial main" > /etc/apt/sources.list.d/dotnetdev.list'\'
printf "%s\n" '```'
printf "%s\n" 
printf "%s\n" "#### Ubuntu 14.04 and Linux Mint 17"
printf "%s\n" 
printf "%s\n" '```bash'
printf "%s\n" 'curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg'
printf "%s\n" 'sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg'
printf "%s\n" 'sudo sh -c '\''echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-trusty-prod trusty main" > /etc/apt/sources.list.d/dotnetdev.list'\'
printf "%s\n" '```'
printf "%s\n" 
printf "%s\n" "#### Update package cache and install .NET Core"
printf "%s\n" 
printf "%s\n" '```bash'
printf "%s\n" 'sudo apt-get update'
printf "%s\n" 'sudo apt-get install dotnet-sdk-'$VER_SDK
printf "%s\n" '```'
printf "%s\n" 
printf "%s\n" "## Installation from a binary archive"
printf "%s\n" 
printf "%s\n" 'Installing from the packages detailed above is recommended and you can also install from binary archive. When using binary archives to install, the contents must be extracted to a user location such as `$HOME/dotnet` and a symbolic link created for `dotnet`. This is a change from previous versions of .NET Core.'
printf "%s\n" 
printf "%s\n" '```bash'
printf "%s\n" 'mkdir -p $HOME/dotnet && tar zxf dotnet.tar.gz -C $HOME/dotnet'
printf "%s\n" 'export PATH=$PATH:$HOME/dotnet'
printf "%s\n" '```'
printf "%s\n" 
printf "%s\n" "## Windows Server Hosting"
printf "%s\n"
printf "%s\n" 'If you are looking to host stand-alone apps on Windows Servers, the ASP.NET Core Module for IIS can be installed separately on servers without installing .NET Core runtime. You can download the Windows (Server Hosting) installer and run the following command from an Administrator command prompt:'
printf "%s\n" 
printf "%s\n" '[DotNetCore.1.0.6_1.1.3-WindowsHosting.exe]('$DLC$DLC_ROOT_RUNTIME'/DotNetCore.1.0.6_1.1.3-WindowsHosting.exe)'