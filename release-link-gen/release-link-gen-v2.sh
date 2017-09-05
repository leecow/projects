# Generate the following for a given 2.x release version:
#  - file list
#  - expected blob location
#  - final DLC url
#  - aka.ms names and links

# Example
# https://dotnetcli.blob.core.windows.net/dotnet/Sdk/2.0.0/dotnet-sdk-2.0.0-osx-x64.pkg
# https://download.microsoft.com/download/0/F/D/0FD852A4-7EA1-4E2A-983A-0484AC19B92C/dotnet-sdk-2.0.0-osx-x64.pkg
# dotnet-sdk-2.0.0-osx-x64

# Usage
# Update the Versions and Locations values as appropriate
# run the script './release-link-gen-v2.sh'
# copy or redirect the output as needed. 

# NOTE: filespec used for generation only works with .NET Core 2.0+

# Versions
VER_SDK="2.0.1"
VER_FX="2.0.1"

# Locations
BLOB_ROOT_SDK="https://dotnetcli.blob.core.windows.net/dotnet/Sdk/"
BLOB_ROOT_FX="https://dotnetcli.blob.core.windows.net/dotnet/Runtime/"
DLC="https://download.microsoft.com/download/"
DLC_ROOT_SDK="7/3/A/73A3E4DC-F019-47D1-9951-0453676E059B"
DLC_ROOT_FX="0/F/6/0F65E15E-5341-4964-8D82-42376AEEDB10"

# Names
SDK="dotnet-sdk"
RUNTIME="dotnet-runtime"
HOST="dotnet-host"
HOSTFXR="dotnet-hostfxr"

# Installers
printf "%s\n\n" "Installers"

# SDK Installers
printf "%s\n\n" "SDK Installers"
declare -a sdk_installers=('osx-x64.pkg' 'win-x64.exe' 'win-x86.exe' 'debian-x64.deb' 'ubuntu-x64.deb' 'ubuntu.16.04-x64.deb' 'rhel-x64.rpm')
    
    for i in "${sdk_installers[@]}"
        do
        : 
        printf "%s\n" $SDK"-"$VER_SDK"-"$i" "$BLOB_ROOT_SDK$VER_SDK"/"$SDK"-"$VER_SDK"-"$i" "$DLC$DLC_ROOT_SDK"/"$SDK"-"$VER_SDK"-"$i
    done
    printf "%s\n" 

# Runtime Installers
printf "%s\n\n" "Runtime Installers"
declare -a runtime_installers=('osx-x64.pkg' 'win-x64.exe' 'win-x86.exe' 'debian.8-x64.deb' 'debian.9-x64.deb' 'ubuntu.14.04-x64.deb' 'ubuntu.16.04-x64.deb' 'ubuntu.17.04-x64.deb' 'rhel-x64.rpm')

    for i in "${runtime_installers[@]}"
        do
        : 
        printf "%s\n" $RUNTIME"-"$VER_FX"-"$i" "$BLOB_ROOT_FX$VER_FX"/"$RUNTIME"-"$VER_FX"-"$i" "$DLC$DLC_ROOT_FX"/"$RUNTIME"-"$VER_FX"-"$i
    done
    printf "%s\n"

# Host
printf "%s\n\n" "Host (dotnet.exe)"
declare -a host_installers=('debian.8-x64.deb' 'debian.9-x64.deb' 'ubuntu.14.04-x64.deb' 'ubuntu.16.04-x64.deb' 'ubuntu.17.04-x64.deb' 'rhel-x64.rpm')

    for i in "${host_installers[@]}"
    do
        : 
        printf "%s\n" $HOST"-"$VER_FX"-"$i" "$BLOB_ROOT_FX$VER_FX"/"$HOST"-"$VER_FX"-"$i" "$DLC$DLC_ROOT_FX"/"$HOST"-"$VER_FX"-"$i
    done
    printf "%s\n"

# HostFXR
printf "%s\n\n" "HostFXR"
declare -a hostfxr_installers=('debian.8-x64.deb' 'debian.9-x64.deb' 'ubuntu.14.04-x64.deb' 'ubuntu.16.04-x64.deb' 'ubuntu.17.04-x64.deb' 'rhel.7-x64.rpm')

    for i in "${hostfxr_installers[@]}"
        do
        : 
        printf "%s\n" $HOSTFXR"-"$VER_FX"-"$i" "$BLOB_ROOT_FX$VER_FX"/"$HOSTFXR"-"$VER_FX"-"$i" "$DLC$DLC_ROOT_FX"/"$HOSTFXR"-"$VER_FX"-"$i
    done
    printf "%s\n"

# Binary Archives
printf "%s\n\n" "Binary Archives"

# SDK Binary Archives
printf "%s\n\n" "SDK Binary Archives"
declare -a sdk_archives=('linux-x64.tar.gz' 'osx-x64.tar.gz' 'win-x64.zip' 'win-x86.zip')


    for i in "${sdk_archives[@]}"
        do
        : 
        printf "%s\n" $SDK"-"$VER_SDK"-"$i" "$BLOB_ROOT_SDK$VER_SDK"/"$SDK"-"$VER_SDK"-"$i" "$DLC$DLC_ROOT_SDK"/"$SDK"-"$VER_SDK"-"$i
    done
    printf "%s\n"

# Runtime Binary Archives
printf "%s\n\n" "Runtime Binary Archives"
declare -a runtime_archives=('linux-x64.tar.gz' 'osx-x64.tar.gz' 'win-x64.zip' 'win-x86.zip')

    for i in "${runtime_archives[@]}"
        do
        : 
        printf "%s\n" $RUNTIME"-"$VER_FX"-"$i" "$BLOB_ROOT_FX$VER_FX"/"$RUNTIME"-"$VER_FX"-"$i" "$DLC$DLC_ROOT_FX"/"$RUNTIME"-"$VER_FX"-"$i
    done
    printf "%s\n"