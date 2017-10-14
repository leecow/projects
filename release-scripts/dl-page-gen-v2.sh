# Download page generator for .NET Core 2
# Not compatible with .NET Core 1.x releases

# Update the Version and Location variables
# Run this script and redirect output to md file. eg ./dl-page-gen-v2 > 2.0.1-download.md

clear

. ./release-versions.sh

# Versions
# VER_SDK="2.0.2"
# VER_RUNTIME="2.0.0"

# Locations
# BLOB_ROOT_SDK="https://dotnetcli.blob.core.windows.net/dotnet/Sdk/"
# BLOB_ROOT_RUNTIME="https://dotnetcli.blob.core.windows.net/dotnet/Runtime/"
# BLOB_ROOT_CHECKSUM="https://dotnetcli.blob.core.windows.net/dotnet/checksums/"
# DLC="https://download.microsoft.com/download/"
# DLC_ROOT_SDK="7/3/A/73A3E4DC-F019-47D1-9951-0453676E059B"
# DLC_ROOT_RUNTIME="0/F/6/0F65E15E-5341-4964-8D82-42376AEEDB10"

printf "%s\n" "# .NET Core "$VER_RUNTIME_20
printf "%s\n" 
printf "%s\n" ".NET Core "$VER_RUNTIME_20" comprises:"
printf "%s\n" 
printf "%s\n" "* .NET Core Runtime "$VER_RUNTIME_20
printf "%s\n" "* .NET Core SDK "$VER_SDK_20

printf "%s\n" 
printf "%s\n" "|         | SDK Installer                                         | SDK Binaries                                                         | Runtime Installer                                                  | Runtime Binaries                                                   |"
printf "%s\n" "| ------- | :---------------------------------------------------: | :-------------------------------------------------------------------:| :----------------------------------------------------------------: | :----------------------------------------------------------------: |"
printf "%s\n" "| Windows | [32-bit]("$DLC$DLC_ROOT_SDK_20"/dotnet-sdk-$VER_SDK_20-win-x86.exe) / [64-bit]("$DLC$DLC_ROOT_SDK_20"/dotnet-sdk-"$VER_SDK_20"-win-x64.exe)  | [32-bit]("$DLC$DLC_ROOT_RUNTIME_20"/dotnet-sdk-"$VER_SDK_20"-win-x86.zip) / [64-bit]("$DLC$DLC_ROOT_SDK_20"/dotnet-sdk-"$VER_SDK_20"-win-x64.zip) | [32-bit]("$DLC$DLC_ROOT_RUNTIME_20"/dotnet-runtime-"$VER_RUNTIME_20"-win-x86.exe) / [64-bit]("$DLC$DLC_ROOT_RUNTIME_20"/dotnet-runtime-"$VER_RUNTIME_20"-win-x64.exe) | [32-bit]("$DLC$DLC_ROOT_RUNTIME_20"/dotnet-runtime-"$VER_RUNTIME_20"-win-x86.zip) / [64-bit]("$DLC$DLC_ROOT_RUNTIME_20"/dotnet-runtime-"$VER_RUNTIME_20"-win-x64.zip) |"
printf "%s\n" "| macOS   | [64-bit]("$DLC$DLC_ROOT_SDK_20"/dotnet-sdk-$VER_SDK_20-osx-x64.pkg)  | [64-bit]("$DLC$DLC_ROOT_SDK_20"/dotnet-sdk-"$VER_SDK_20"-osx-x64.tar.gz)| [64-bit]("$DLC$DLC_ROOT_RUNTIME_20"/dotnet-runtime-"$VER_RUNTIME_20"-osx-x64.pkg)      | [64-bit]("$DLC$DLC_ROOT_RUNTIME_20"/dotnet-runtime-"$VER_RUNTIME_20"-osx-x64.tar.gz)   |"
printf "%s\n" "| Linux * | See installations steps below                         | [64-bit]("$DLC$DLC_ROOT_SDK_20"/dotnet-sdk-"$VER_SDK_20"-linux-x64.tar.gz)     | -                                                                  | [64-bit]("$DLC$DLC_ROOT_RUNTIME_20"/dotnet-runtime-"$VER_RUNTIME_20"-linux-x64.tar.gz) |"

printf "%s\n" 
printf "%s\n" "**Checksum** files to verify downloads are available as follows:"
printf "%s\n" "* [Checksums_Runtime]("$BLOB_ROOT_CHECKSUM$VER_RUNTIME_20"-runtime-sha.txt)"
printf "%s\n" "* [Checksums_SDK]("$BLOB_ROOT_CHECKSUM$VER_SDK_20"-sdk-sha.txt)"
printf "%s\n"
printf "%s\n" "**Debug Symbols**"
printf "%s\n" "* [Shared Framework]("$DLC$DLC_ROOT_RUNTIME_20"/corefx-2.0-symbols.zip)"
printf "%s\n" "* [Runtime]("$DLC$DLC_ROOT_RUNTIME_20"/coreclr-2.0-symbols.zip)"

printf "%s\n" 
printf "%s\n" "## Docker"
printf "%s\n" 
printf "%s\n" "Images for .NET Core "$VER_RUNTIME_20" are available on [Docker](https://hub.docker.com/r/microsoft/dotnet/)."


printf "%s\n" "## Installing .NET Core on Linux"
printf "%s\n" 
printf "%s\n" "### Uninstall any Preview versions"
printf "%s\n" 
printf "%s\n" "If you have .NET Core Previews installed, it will need to be removed before attempting to install .NET Core 2.0. This can be done by running a command such as the following."
printf "%s\n" 
printf "%s\n" '`sudo apt remove dotnet-dev-2.0.0-preview2-006497`'

printf "%s\n" 
printf "%s\n" "### Ubuntu and Debian based systems"
printf "%s\n" 
printf "%s\n" "Register the Microsoft key, the product repository for your distro and install required system dependencies with the following scripts."
printf "%s\n" 
printf "%s\n" "#### Ubuntu 17.04"
printf "%s\n" 
printf "%s\n" '```bash'
printf "%s\n" 'curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg'
printf "%s\n" 'sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg'
printf "%s\n" 'sudo sh -c '\''echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-zesty-prod zesty main" > /etc/apt/sources.list.d/dotnetdev.list'\'
printf "%s\n" '```'
printf "%s\n" 
printf "%s\n" "#### Ubuntu 16.04"
printf "%s\n" 
printf "%s\n" '```bash'
printf "%s\n" 'curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg'
printf "%s\n" 'sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg'
printf "%s\n" 'sudo sh -c '\''echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-xenial-prod xenial main" > /etc/apt/sources.list.d/dotnetdev.list'\'
printf "%s\n" '```'
printf "%s\n" "#### Ubuntu 14.04"
printf "%s\n" 
printf "%s\n" '```bash'
printf "%s\n" 'curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg'
printf "%s\n" 'sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg'
printf "%s\n" "sudo sh -c "\'"echo "'"'"deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-trusty-prod trusty main"'"'" > /etc/apt/sources.list.d/dotnetdev.list"\'
printf "%s\n" '```'
printf "%s\n"
printf "%s\n" "Then, update the package cache and install .NET Core"
printf "%s\n" 
printf "%s\n" '```bash'
printf "%s\n" 'sudo apt-get update'
printf "%s\n" 'sudo apt-get install dotnet-sdk-'$VER_SDK_20
printf "%s\n" '```'
printf "%s\n" 
printf "%s\n" "### RHEL and Fedora based systems"
printf "%s\n" 
printf "%s\n" "Register the Microsoft key, the product repository for your distro and install required system dependencies with the following scripts."
printf "%s\n" 
printf "%s\n" "#### Fedora, CentOS, Oracle Linux, SUSE"
printf "%s\n" 
printf "%s\n" '```bash'
printf "%s\n" 'sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc'
printf "%s\n" 'sudo sh -c '\''echo -e "[packages-microsoft-com-prod]\nname=packages-microsoft-com-prod\nbaseurl=https://packages.microsoft.com/yumrepos/microsoft-rhel7.3-prod\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/dotnetdev.repo'\'
printf "%s\n" '```'
printf "%s\n" 
printf "%s\n" "Then, update the package cache and install .NET Core"
printf "%s\n" 
printf "%s\n" "#### Fedora, CentOS and Oracle Linux"
printf "%s\n" 
printf "%s\n" '```bash'
printf "%s\n" 'sudo yum update'
printf "%s\n" 'sudo yum install dotnet-sdk-'$VER_SDK_20
printf "%s\n" '```'
printf "%s\n" 
printf "%s\n" "#### SUSE Enterprise Linux and OpenSUSE"
printf "%s\n" 
printf "%s\n" '```bash'
printf "%s\n" 'sudo zypper update'
printf "%s\n" 'sudo zypper install dotnet-sdk-'$VER_SDK_20
printf "%s\n" '```'
printf "%s\n" 
printf "%s\n" '**Note:** When installing the SDK, SUSE and OpenSUSE may report that nothing provides libcurl. libcurl should already be installed on supported versions of both distros. Run zypper search libcurl to confirm. The error will present 2 "solutions". Choose "Solution 2" to continue installing .NET Core.'
printf "%s\n" 
printf "%s\n" "## Installation from a binary archive"
printf "%s\n" 
printf "%s\n" 'Installing from the packages detailed above is recommended and you can also install from binary archive. When using binary archives to install, the contents must be extracted to a user location such as `$HOME/dotnet` and a symbolic link created for `dotnet`.'
printf "%s\n" 
printf "%s\n" '```bash'
printf "%s\n" 'mkdir -p $HOME/dotnet && tar zxf dotnet.tar.gz -C $HOME/dotnet'
printf "%s\n" 'export PATH=$PATH:$HOME/dotnet'
printf "%s\n" '```'
printf "%s\n" 
printf "%s\n" "## Windows Server Hosting"
printf "%s\n" 
printf "%s\n" "If you are looking to host stand-alone apps on Windows Servers, the ASP.NET Core Module for IIS can be installed separately on servers without installing .NET Core runtime. You can download the Windows (Server Hosting) installer and run the following command from an Administrator command prompt:"
printf "%s\n" 
printf "%s\n" "[DotNetCore."$VER_RUNTIME_20"-WindowsHosting.exe]("$DLC$DLC_ROOT_RUNTIME_20"/DotNetCore."$VER_RUNTIME_20"-WindowsHosting.exe)"
printf "%s\n" 
printf "%s\n" "### ASP.NET Core Package Store"
printf "%s\n" 
printf "%s\n" "The Runtime Package Store is installed by the .NET Core SDK and the Windows Server Hosting installer. If you need to install the Runtime Package Store separately, the following can be used."
printf "%s\n" 
printf "%s\n" "* [AspNetCore."$VER_RUNTIME_20".RuntimePackageStore_x64.exe]("$DLC$DLC_ROOT_RUNTIME_20"/AspNetCore."$VER_RUNTIME_20".RuntimePackageStore_x64.exe)"
printf "%s\n" "* [AspNetCore."$VER_RUNTIME_20".RuntimePackageStore_x86.exe]("$DLC$DLC_ROOT_RUNTIME_20"/AspNetCore."$VER_RUNTIME_20".RuntimePackageStore_x86.exe)"