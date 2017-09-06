# Generate the following for a given 1.x release version:
#  - file list
#  - expected blob location
#  - final DLC url
#  - aka.ms names and links

# Examples
# https://dotnetcli.blob.core.windows.net/dotnet/Sdk/1.0.4/dotnet-dev-osx-x64.1.0.4.pkg
# https://dotnetcli.blob.core.windows.net/dotnet/Runtime/1.1.2/dotnet-osx-x64.1.1.2.pkg

# https://download.microsoft.com/download/7/8/5/7852163D-1A56-4642-84B6-60A8537343EF/dotnet-osx-x64.1.0.5.pkg
# https://download.microsoft.com/download/D/0/2/D028801E-0802-43C8-9F9F-C7DB0A39B344/dotnet-osx-x64.1.1.2.pkg
# https://download.microsoft.com/download/B/9/F/B9F1AF57-C14A-4670-9973-CDF47209B5BF/dotnet-dev-osx-x64.1.0.4.pkg

# dotnet-osx-x64.1.0.5.pkg

# Usage
# Update the Versions and Locations values as appropriate
# run the script './release-link-gen-v1.sh'
# copy or redirect the output as needed. 

# NOTE: filespec used for generation only works with .NET Core 1.0+

# Versions
VER_SDK="1.1.3"
VER_RUNTIME="1.1.3"

# Locations
BLOB_ROOT_SDK="https://dotnetcli.blob.core.windows.net/dotnet/Sdk/"
BLOB_ROOT_RUNTIME="https://dotnetcli.blob.core.windows.net/dotnet/Runtime/"
DLC="https://download.microsoft.com/download/"
DLC_ROOT_SDK="7/8/5/7852163D-1A56-4642-84B6-60A8537343EF"
DLC_ROOT_RUNTIME="F/4/F/F4FCB6EC-5F05-4DF8-822C-FF013DF1B17F"

# Names
DEV="dotnet-dev"
SDK="dotnet-sdk"
RUNTIME="dotnet"
HOST="dotnet-host"
HOSTFXR="dotnet-hostfxr"

# Installers
printf "%s\n\n" "Installers"

# SDK Installers
printf "%s\n\n" "SDK Installers"
declare -a dev_installers=('osx-x64.'$VER_SDK'.pkg' 'win-x64.'$VER_SDK'.exe' 'win-x86.'$VER_SDK'.exe' 'ubuntu-x64.'$VER_SDK'.deb' 'ubuntu.16.04-x64.'$VER_SDK'.deb' 'ubuntu.16.10-x64.'$VER_SDK'.deb')
    
    for i in "${dev_installers[@]}"
        do
        :
        printf "%s\n" $DEV"-"$i" "$BLOB_ROOT_SDK$VER_SDK"/"$DEV"-"$i" "$DLC$DLC_ROOT_SDK"/"$DEV"-"$i
    done

# because Ubuntu had to be different ...
declare -a sdk_installers=('ubuntu-x64.'$VER_SDK'.deb' 'ubuntu.16.04-x64.'$VER_SDK'.deb')
    
    for i in "${sdk_installers[@]}"
        do
        :
        printf "%s\n" $SDK"-"$i" "$BLOB_ROOT_SDK$VER_SDK"/"$SDK"-"$i" "$DLC$DLC_ROOT_SDK"/"$SDK"-"$i
    done

    printf "%s\n" 

# Runtime Installers
printf "%s\n\n" "Runtime Installers"
declare -a runtime_installers=('osx-x64.'$VER_RUNTIME'.pkg' 'win-x64.'$VER_RUNTIME'.exe' 'win-x86.'$VER_RUNTIME'.exe')

    for i in "${runtime_installers[@]}"
        do
        : 
        printf "%s\n" $RUNTIME"-"$i" "$BLOB_ROOT_RUNTIME$VER_RUNTIME"/"$RUNTIME"-"$i" "$DLC$DLC_ROOT_RUNTIME"/"$RUNTIME"-"$i
    done
    printf "%s\n"
 
# Host
printf "%s\n\n" "Host (dotnet.exe)"
declare -a host_installers=('ubuntu-x64.'$VER_RUNTIME'.deb' 'ubuntu.16.04-x64.'$VER_RUNTIME'.deb' 'ubuntu.16.10-x64.'$VER_RUNTIME'.deb')

    for i in "${host_installers[@]}"
    do
        : 
        printf "%s\n" $HOST"-"$i" "$BLOB_ROOT_RUNTIME$VER_RUNTIME"/"$HOST"-"$i" "$DLC$DLC_ROOT_RUNTIME"/"$HOST"-"$i
    done
    printf "%s\n"

# HostFXR
printf "%s\n\n" "HostFXR"
declare -a hostfxr_installers=('ubuntu-x64.'$VER_RUNTIME'.deb' 'ubuntu.16.04-x64.'$VER_RUNTIME'.deb' 'ubuntu.16.10-x64.'$VER_RUNTIME'.deb')

    for i in "${hostfxr_installers[@]}"
    do
        : 
        printf "%s\n" $HOSTFXR"-"$i" "$BLOB_ROOT_RUNTIME$VER_RUNTIME"/"$HOSTFXR"-"$i" "$DLC$DLC_ROOT_RUNTIME"/"$HOSTFXR"-"$i
    done
    printf "%s\n"

# Binary Archives
printf "%s\n\n" "Binary Archives"

# SDK Binary Archives
printf "%s\n\n" "SDK Binary Archives"
declare -a sdk_archives=('centos-x64.'$VER_SDK'.tar.gz' 'debian-x64.'$VER_SDK'.tar.gz' 'fedora.23-x64.'$VER_SDK'.tar.gz' 'opensuse.42.1-x64.'$VER_SDK'.tar.gz' 'osx-x64.'$VER_SDK'.tar.gz' 'rhel-x64.'$VER_SDK'.tar.gz' 'ubuntu-x64.'$VER_SDK'.tar.gz' 'ubuntu.16.04-x64.'$VER_SDK'.tar.gz' 'ubuntu.16.10-x64.'$VER_SDK'.tar.gz' 'win-x64.'$VER_SDK'.zip' 'win-x86.'$VER_SDK'.zip')

    for i in "${sdk_archives[@]}"
        do
        : 
        printf "%s\n" $DEV"-"$i" "$BLOB_ROOT_SDK$VER_SDK"/"$DEV"-"$i" "$DLC$DLC_ROOT_SDK"/"$DEV"-"$i
    done
    printf "%s\n"

# Runtime Binary Archives
printf "%s\n\n" "Runtime Binary Archives"
declare -a runtime_archives=('win-x64.'$VER_RUNTIME'.zip' 'win-x86.'$VER_RUNTIME'.zip' 'osx-x64.'$VER_RUNTIME'.tar.gz' 'centos-x64.'$VER_RUNTIME'.tar.gz' 'debian-x64.'$VER_RUNTIME'.tar.gz' 'fedora.23-x64.'$VER_RUNTIME'.tar.gz' 'rhel-x64.'$VER_RUNTIME'.tar.gz' 'ubuntu-x64.'$VER_RUNTIME'.tar.gz' 'ubuntu.16.04-x64.'$VER_RUNTIME'.tar.gz' 'ubuntu.16.10-x64.'$VER_RUNTIME'.tar.gz')

    for i in "${runtime_archives[@]}"
        do
        : 
        printf "%s\n" $RUNTIME"-"$i" "$BLOB_ROOT_RUNTIME$VER_RUNTIME"/"$RUNTIME"-"$i" "$DLC$DLC_ROOT_RUNTIME"/"$RUNTIME"-"$i
    done
    printf "%s\n"