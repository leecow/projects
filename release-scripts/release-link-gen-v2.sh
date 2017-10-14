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
# Update the Versions and Locations values in release-versions.sh
# run the script './release-link-gen-v2.sh'
# copy or redirect the output as needed. 

# NOTE: filespec used for generation only works with .NET Core 2.0+

. ./release-versions.sh

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
        printf "%s\n" $SDK"-"$VER_SDK_20"-"$i" "$BLOB_ROOT_SDK$VER_SDK_20"/"$SDK"-"$VER_SDK_20"-"$i" "$DLC$DLC_ROOT_SDK_20"/"$SDK"-"$VER_SDK_20"-"$i
    done
    printf "%s\n" 

# Runtime Installers
printf "%s\n\n" "Runtime Installers"
declare -a runtime_installers=('osx-x64.pkg' 'win-x64.exe' 'win-x86.exe' 'debian.8-x64.deb' 'debian.9-x64.deb' 'ubuntu.14.04-x64.deb' 'ubuntu.16.04-x64.deb' 'ubuntu.17.04-x64.deb' 'rhel-x64.rpm')

    for i in "${runtime_installers[@]}"
        do
        : 
        printf "%s\n" $RUNTIME"-"$VER_RUNTIME_20"-"$i" "$BLOB_ROOT_RUNTIME$VER_RUNTIME_20"/"$RUNTIME"-"$VER_RUNTIME_20"-"$i" "$DLC$DLC_ROOT_RUNTIME_20"/"$RUNTIME"-"$VER_RUNTIME_20"-"$i
    done
    printf "%s\n"

# Host
printf "%s\n\n" "Host (dotnet.exe)"
declare -a host_installers=('debian.8-x64.deb' 'debian.9-x64.deb' 'ubuntu.14.04-x64.deb' 'ubuntu.16.04-x64.deb' 'ubuntu.17.04-x64.deb' 'rhel-x64.rpm')

    for i in "${host_installers[@]}"
    do
        : 
        printf "%s\n" $HOST"-"$VER_RUNTIME_20"-"$i" "$BLOB_ROOT_RUNTIME$VER_RUNTIME_20"/"$HOST"-"$VER_RUNTIME_20"-"$i" "$DLC$DLC_ROOT_RUNTIME_20"/"$HOST"-"$VER_RUNTIME_20"-"$i
    done
    printf "%s\n"

# HostFXR
printf "%s\n\n" "HostFXR"
declare -a hostfxr_installers=('debian.8-x64.deb' 'debian.9-x64.deb' 'ubuntu.14.04-x64.deb' 'ubuntu.16.04-x64.deb' 'ubuntu.17.04-x64.deb' 'rhel.7-x64.rpm')

    for i in "${hostfxr_installers[@]}"
        do
        : 
        printf "%s\n" $HOSTFXR"-"$VER_RUNTIME_20"-"$i" "$BLOB_ROOT_RUNTIME$VER_RUNTIME_20"/"$HOSTFXR"-"$VER_RUNTIME_20"-"$i" "$DLC$DLC_ROOT_RUNTIME_20"/"$HOSTFXR"-"$VER_RUNTIME_20"-"$i
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
        printf "%s\n" $SDK"-"$VER_SDK_20"-"$i" "$BLOB_ROOT_SDK$VER_SDK_20"/"$SDK"-"$VER_SDK_20"-"$i" "$DLC$DLC_ROOT_SDK_20"/"$SDK"-"$VER_SDK_20"-"$i
    done
    printf "%s\n"

# Runtime Binary Archives
printf "%s\n\n" "Runtime Binary Archives"
declare -a runtime_archives=('linux-x64.tar.gz' 'osx-x64.tar.gz' 'win-x64.zip' 'win-x86.zip')

    for i in "${runtime_archives[@]}"
        do
        : 
        printf "%s\n" $RUNTIME"-"$VER_RUNTIME_20"-"$i" "$BLOB_ROOT_RUNTIME$VER_RUNTIME_20"/"$RUNTIME"-"$VER_RUNTIME_20"-"$i" "$DLC$DLC_ROOT_RUNTIME_20"/"$RUNTIME"-"$VER_RUNTIME_20"-"$i
    done
    printf "%s\n"