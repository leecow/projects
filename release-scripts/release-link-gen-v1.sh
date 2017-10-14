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
# Update the Versions and Locations values as appropriate in release-versions.sh
# run the script './release-link-gen-v1.sh'
# copy or redirect the output as needed. 

# NOTE: filespec used for generation only works with .NET Core 1.0+

. ./release-versions.sh

# Names
DEV="dotnet-dev"
SDK="dotnet-sdk"
RUNTIME="dotnet"
SHARED="dotnet-sharedframework"
HOST="dotnet-host"
HOSTFXR="dotnet-hostfxr"

# Installers
printf "%s\n\n" "Installers"

# SDK Installers
printf "%s\n\n" "SDK Installers"
declare -a dev_installers=('osx-x64.'$VER_SDK_11'.pkg' 'win-x64.'$VER_SDK_11'.exe' 'win-x86.'$VER_SDK_11'.exe')
    
    for i in "${dev_installers[@]}"
        do
        :
        printf "%s\n" $DEV"-"$i" "$BLOB_ROOT_SDK$VER_SDK_11"/"$DEV"-"$i" "$DLC$DLC_ROOT_SDK"/"$DEV"-"$i
    done

# because Ubuntu had to be different ...
declare -a sdk_installers=('ubuntu-x64.'$VER_SDK_11'.deb' 'ubuntu.16.04-x64.'$VER_SDK_11'.deb')
    
    for i in "${sdk_installers[@]}"
        do
        :
        printf "%s\n" $SDK"-"$i" "$BLOB_ROOT_SDK$VER_SDK_11"/"$SDK"-"$i" "$DLC$DLC_ROOT_SDK"/"$SDK"-"$i
    done

    printf "%s\n" 

# 1.0 Runtime Installers
printf "%s\n\n" $VER_RUNTIME_10" Runtime Installers"
declare -a runtime_installers=('osx-x64.'$VER_RUNTIME_10'.pkg' 'win-x64.'$VER_RUNTIME_10'.exe' 'win-x86.'$VER_RUNTIME_10'.exe')

    for i in "${runtime_installers[@]}"
        do
        : 
        printf "%s\n" $RUNTIME"-"$i" "$BLOB_ROOT_RUNTIME$VER_RUNTIME_10"/"$RUNTIME"-"$i" "$DLC$DLC_ROOT_RUNTIME_10"/"$RUNTIME"-"$i
    done
    printf "%s\n"

## 1.1 Runtime Installers
printf "%s\n\n" $VER_RUNTIME_11" Runtime Installers"
declare -a runtime_installers=('osx-x64.'$VER_RUNTIME_11'.pkg' 'win-x64.'$VER_RUNTIME_11'.exe' 'win-x86.'$VER_RUNTIME_11'.exe')

    for i in "${runtime_installers[@]}"
        do
        : 
        printf "%s\n" $RUNTIME"-"$i" "$BLOB_ROOT_RUNTIME$VER_RUNTIME_11"/"$RUNTIME"-"$i" "$DLC$DLC_ROOT_RUNTIME_11"/"$RUNTIME"-"$i
    done
    printf "%s\n"

#1.0 Ubuntu Runtime Installers

printf "%s\n\n" $VER_RUNTIME_10" Ubuntu Shared Framework"
declare -a ubuntu_shared=('ubuntu-x64.'$VER_RUNTIME_10'.deb' 'ubuntu.16.04-x64.'$VER_RUNTIME_10'.deb' 'ubuntu.16.10-x64.'$VER_RUNTIME_10'.deb')

    for i in "${ubuntu_shared[@]}"
    do
        : 
        printf "%s\n" $SHARED"-"$i" "$BLOB_ROOT_RUNTIME$VER_RUNTIME_10"/"$SHARED"-"$i" "$DLC$DLC_ROOT_RUNTIME_10"/"$SHARED"-"$i
    done
    printf "%s\n"

#1.1 Ubuntu Runtime Installers

printf "%s\n\n" $VER_RUNTIME_11" Ubuntu Shared Framework"
declare -a ubuntu_shared=('ubuntu-x64.'$VER_RUNTIME_11'.deb' 'ubuntu.16.04-x64.'$VER_RUNTIME_11'.deb' 'ubuntu.16.10-x64.'$VER_RUNTIME_11'.deb')

    for i in "${ubuntu_shared[@]}"
    do
        : 
        printf "%s\n" $SHARED"-"$i" "$BLOB_ROOT_RUNTIME$VER_RUNTIME_11"/"$SHARED"-"$i" "$DLC$DLC_ROOT_RUNTIME_11"/"$SHARED"-"$i
    done
    printf "%s\n"

# 1.0 Host
printf "%s\n\n" "1.0 Host (dotnet.exe)"
declare -a host_installers=('ubuntu-x64.'$VER_HOST_10'.deb' 'ubuntu.16.04-x64.'$VER_HOST_10'.deb' 'ubuntu.16.10-x64.'$VER_HOST_10'.deb')

    for i in "${host_installers[@]}"
    do
        : 
        printf "%s\n" $HOST"-"$i" "$BLOB_ROOT_RUNTIME$VER_RUNTIME_10"/"$HOST"-"$i" "$DLC$DLC_ROOT_RUNTIME"/"$HOST"-"$i
    done
    printf "%s\n"

# 1.0 HostFXR
printf "%s\n\n" "1.0 HostFXR"
declare -a hostfxr_installers=('ubuntu-x64.'$VER_HOSTFXR_10'.deb' 'ubuntu.16.04-x64.'$VER_HOSTFXR_10'.deb' 'ubuntu.16.10-x64.'$VER_HOSTFXR_10'.deb')

    for i in "${hostfxr_installers[@]}"
    do
        : 
        printf "%s\n" $HOSTFXR"-"$i" "$BLOB_ROOT_RUNTIME$VER_RUNTIME_10"/"$HOSTFXR"-"$i" "$DLC$DLC_ROOT_RUNTIME"/"$HOSTFXR"-"$i
    done
    printf "%s\n"

# 1.1 Host
printf "%s\n\n" "1.1 Host (dotnet.exe)"
declare -a host_installers=('ubuntu-x64.'$VER_HOST_11'.deb' 'ubuntu.16.04-x64.'$VER_HOST_11'.deb' 'ubuntu.16.10-x64.'$VER_HOST_11'.deb')

    for i in "${host_installers[@]}"
    do
        : 
        printf "%s\n" $HOST"-"$i" "$BLOB_ROOT_RUNTIME$VER_RUNTIME_11"/"$HOST"-"$i" "$DLC$DLC_ROOT_RUNTIME"/"$HOST"-"$i
    done
    printf "%s\n"

# 1.1 HostFXR
printf "%s\n\n" "1.1 HostFXR"
declare -a hostfxr_installers=('ubuntu-x64.'$VER_HOSTFXR_11'.deb' 'ubuntu.16.04-x64.'$VER_HOSTFXR_11'.deb' 'ubuntu.16.10-x64.'$VER_HOSTFXR_11'.deb')

    for i in "${hostfxr_installers[@]}"
    do
        : 
        printf "%s\n" $HOSTFXR"-"$i" "$BLOB_ROOT_RUNTIME$VER_RUNTIME_11"/"$HOSTFXR"-"$i" "$DLC$DLC_ROOT_RUNTIME"/"$HOSTFXR"-"$i
    done
    printf "%s\n"

# Binary Archives
printf "%s\n\n" "Binary Archives"

# SDK Binary Archives
printf "%s\n\n" "SDK Binary Archives"
declare -a sdk_archives=('centos-x64.'$VER_SDK_11'.tar.gz' 'debian-x64.'$VER_SDK_11'.tar.gz' 'fedora.24-x64.'$VER_SDK_11'.tar.gz' 'opensuse.42.1-x64.'$VER_SDK_11'.tar.gz' 'osx-x64.'$VER_SDK_11'.tar.gz' 'rhel-x64.'$VER_SDK_11'.tar.gz' 'ubuntu-x64.'$VER_SDK_11'.tar.gz' 'ubuntu.16.04-x64.'$VER_SDK_11'.tar.gz' 'win-x64.'$VER_SDK_11'.zip' 'win-x86.'$VER_SDK_11'.zip')

    for i in "${sdk_archives[@]}"
        do
        : 
        printf "%s\n" $DEV"-"$i" "$BLOB_ROOT_SDK$VER_SDK_11"/"$DEV"-"$i" "$DLC$DLC_ROOT_SDK"/"$DEV"-"$i
    done
    printf "%s\n"

# 1.0 Runtime Binary Archives
printf "%s\n\n" $VER_RUNTIME_10" Runtime Binary Archives"
declare -a runtime_archives=('win-x64.'$VER_RUNTIME_10'.zip' 'win-x86.'$VER_RUNTIME_10'.zip' 'osx-x64.'$VER_RUNTIME_10'.tar.gz' 'centos-x64.'$VER_RUNTIME_10'.tar.gz' 'debian-x64.'$VER_RUNTIME_10'.tar.gz' 'rhel-x64.'$VER_RUNTIME_10'.tar.gz' 'ubuntu-x64.'$VER_RUNTIME_10'.tar.gz' 'ubuntu.16.04-x64.'$VER_RUNTIME_10'.tar.gz')

    for i in "${runtime_archives[@]}"
        do
        : 
        printf "%s\n" $RUNTIME"-"$i" "$BLOB_ROOT_RUNTIME$VER_RUNTIME_10"/"$RUNTIME"-"$i" "$DLC$DLC_ROOT_RUNTIME_10"/"$RUNTIME"-"$i
    done
    printf "%s\n"

# 1.1 Runtime Binary Archives
printf "%s\n\n" $VER_RUNTIME_11" Runtime Binary Archives"
declare -a runtime_archives=('win-x64.'$VER_RUNTIME_11'.zip' 'win-x86.'$VER_RUNTIME_11'.zip' 'osx-x64.'$VER_RUNTIME_11'.tar.gz' 'centos-x64.'$VER_RUNTIME_11'.tar.gz' 'debian-x64.'$VER_RUNTIME_11'.tar.gz' 'fedora.24-x64.'$VER_RUNTIME_11'.tar.gz' 'rhel-x64.'$VER_RUNTIME_11'.tar.gz' 'ubuntu-x64.'$VER_RUNTIME_11'.tar.gz' 'ubuntu.16.04-x64.'$VER_RUNTIME_11'.tar.gz')

    for i in "${runtime_archives[@]}"
        do
        : 
        printf "%s\n" $RUNTIME"-"$i" "$BLOB_ROOT_RUNTIME$VER_RUNTIME_11"/"$RUNTIME"-"$i" "$DLC$DLC_ROOT_RUNTIME_11"/"$RUNTIME"-"$i
    done
    printf "%s\n"