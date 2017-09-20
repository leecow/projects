# what would make sense to parameterize at call time?
# installers and binaries makes some sense
# how about platform? deb, rpm, exe, pkg, zip?
# 1.0 vs 1.1?

# flags 
#   -v = version (1.0, 1.1)
#   -p = platform (?)
#   -t = package type (installer, archive)
#   - = SDK or Runtime

# eg sh blob-dl.sh -v 1.0 -p ubuntu -t installer

while getopts vpt flag
    do
        case "${flag}"
            in
            v) VERSION=${OPTARG};;
            p) PLATFORM=${OPTARG};;
            t) PACKAGE=${OPTARG};;
        esac
    done

# Versions
VER_SDK="1.1.4"
VER_RUNTIME_10="1.0.7"
VER_RUNTIME_11="1.1.4"
VER_HOST="1.0.1"
VER_HOST_11="1.1.0"
VER_HOSTFXR="1.0.1"
VER_HOSTFXR_11="1.1.0"

# Locations
BLOB_ROOT_SDK="https://dotnetcli.blob.core.windows.net/dotnet/Sdk/"
BLOB_ROOT_RUNTIME="https://dotnetcli.blob.core.windows.net/dotnet/Runtime/"
DLC="https://download.microsoft.com/download/"
DLC_ROOT_SDK="F/4/F/F4FCB6EC-5F05-4DF8-822C-FF013DF1B17F"
DLC_ROOT_RUNTIME_10="E/9/E/E9E929B2-6532-43D7-98D2-E0B4445912BD"
DLC_ROOT_RUNTIME_11="6/F/B/6FB4F9D2-699B-4A40-A674-B7FF41E0E4D2"

# Names
DEV="dotnet-dev"
SDK="dotnet-sdk"
RUNTIME="dotnet"
SHARED="dotnet-sharedframework"
HOST="dotnet-host"
HOSTFXR="dotnet-hostfxr"

# Installers

# SDK Installers
declare -a dev_installers=('osx-x64.'$VER_SDK'.pkg' 'win-x64.'$VER_SDK'.exe' 'win-x86.'$VER_SDK'.exe')
    
    for i in "${dev_installers[@]}"
        do
        :
        #printf "%s\n" $DEV"-"$i" "$BLOB_ROOT_SDK$VER_SDK"/"$DEV"-"$i" "$DLC$DLC_ROOT_SDK"/"$DEV"-"$i
        curl -o $DEV"-"$i $BLOB_ROOT_SDK$VER_SDK"/"$DEV"-"$i
    done

# Ubuntu SDK installers
declare -a sdk_installers=('ubuntu-x64.'$VER_SDK'.deb' 'ubuntu.16.04-x64.'$VER_SDK'.deb')
    
    for i in "${sdk_installers[@]}"
        do
        :
        curl -o $SDK"-"$i $BLOB_ROOT_SDK$VER_SDK"/"$SDK"-"$i
    done

# 1.0 Runtime Installers
declare -a runtime_installers=('osx-x64.'$VER_RUNTIME_10'.pkg' 'win-x64.'$VER_RUNTIME_10'.exe' 'win-x86.'$VER_RUNTIME_10'.exe')

    for i in "${runtime_installers[@]}"
        do
        : 
        #printf "%s\n" $RUNTIME"-"$i" "$BLOB_ROOT_RUNTIME$VER_RUNTIME_10"/"$RUNTIME"-"$i" "$DLC$DLC_ROOT_RUNTIME_10"/"$RUNTIME"-"$i
        curl -o $RUNTIME"-"$i $BLOB_ROOT_RUNTIME$VER_RUNTIME_10"/"$RUNTIME"-"$i
    done

# 1.1 Runtime Installers
declare -a runtime_installers=('osx-x64.'$VER_RUNTIME_11'.pkg' 'win-x64.'$VER_RUNTIME_11'.exe' 'win-x86.'$VER_RUNTIME_11'.exe')

    for i in "${runtime_installers[@]}"
        do
        : 
        #printf "%s\n" $RUNTIME"-"$i" "$BLOB_ROOT_RUNTIME$VER_RUNTIME_11"/"$RUNTIME"-"$i" "$DLC$DLC_ROOT_RUNTIME_11"/"$RUNTIME"-"$i
        curl -o $RUNTIME"-"$i $BLOB_ROOT_RUNTIME$VER_RUNTIME_11"/"$RUNTIME"-"$i
    done

#1.0 Ubuntu Runtime Installers
declare -a ubuntu_shared=('ubuntu-x64.'$VER_RUNTIME_10'.deb' 'ubuntu.16.04-x64.'$VER_RUNTIME_10'.deb')

    for i in "${ubuntu_shared[@]}"
    do
        : 
        curl -o $SHARED"-"$i $BLOB_ROOT_RUNTIME$VER_RUNTIME_10"/"$SHARED"-"$i
    done
    printf "%s\n"

#1.1 Ubuntu Runtime Installers
declare -a ubuntu_shared=('ubuntu-x64.'$VER_RUNTIME_11'.deb' 'ubuntu.16.04-x64.'$VER_RUNTIME_11'.deb')

    for i in "${ubuntu_shared[@]}"
    do
        : 
        curl -o $SHARED"-"$i $BLOB_ROOT_RUNTIME$VER_RUNTIME_11"/"$SHARED"-"$i
    done

# Host - need to account for the Host and FXR not always getting updated.
declare -a host_installers=('ubuntu-x64.'$VER_HOST'.deb' 'ubuntu.16.04-x64.'$VER_HOST'.deb')

    for i in "${host_installers[@]}"
    do
        : 
        curl -o $HOST"-"$i $BLOB_ROOT_RUNTIME$VER_RUNTIME_10"/"$HOST"-"$i
    done

# Host_11
declare -a host_installers=('ubuntu-x64.'$VER_HOST_11'.deb' 'ubuntu.16.04-x64.'$VER_HOST_11'.deb')

    for i in "${host_installers[@]}"
    do
        : 
        curl -o $HOST"-"$i $BLOB_ROOT_RUNTIME$VER_RUNTIME_11"/"$HOST"-"$i
    done

# HostFXR_10
declare -a hostfxr_installers=('ubuntu-x64.'$VER_HOSTFXR'.deb' 'ubuntu.16.04-x64.'$VER_HOSTFXR'.deb')

    for i in "${hostfxr_installers[@]}"
    do
        : 
        curl -o $HOSTFXR"-"$i $BLOB_ROOT_RUNTIME$VER_RUNTIME_10"/"$HOSTFXR"-"$i
    done

# HostFXR_11
declare -a hostfxr_installers=('ubuntu-x64.'$VER_HOSTFXR_11'.deb' 'ubuntu.16.04-x64.'$VER_HOSTFXR_11'.deb')

    for i in "${hostfxr_installers[@]}"
    do
        : 
        curl -o $HOSTFXR"-"$i $BLOB_ROOT_RUNTIME$VER_RUNTIME_11"/"$HOSTFXR"-"$i
    done


## Binary Archives

## SDK Binary Archives
declare -a sdk_archives=('centos-x64.'$VER_SDK'.tar.gz' 'debian-x64.'$VER_SDK'.tar.gz' 'fedora.24-x64.'$VER_SDK'.tar.gz' 'opensuse.42.1-x64.'$VER_SDK'.tar.gz' 'osx-x64.'$VER_SDK'.tar.gz' 'rhel-x64.'$VER_SDK'.tar.gz' 'ubuntu-x64.'$VER_SDK'.tar.gz' 'ubuntu.16.04-x64.'$VER_SDK'.tar.gz' 'win-x64.'$VER_SDK'.zip' 'win-x86.'$VER_SDK'.zip')

    for i in "${sdk_archives[@]}"
        do
        : 
        #printf "%s\n" $DEV"-"$i" "$BLOB_ROOT_SDK$VER_SDK"/"$DEV"-"$i" "$DLC$DLC_ROOT_SDK"/"$DEV"-"$i
        curl -o $DEV"-"$i" "$BLOB_ROOT_SDK$VER_SDK"/"$DEV"-"$i
    done

# 1.0 Runtime Binary Archives
declare -a runtime_archives=('win-x64.'$VER_RUNTIME_10'.zip' 'win-x86.'$VER_RUNTIME_10'.zip' 'osx-x64.'$VER_RUNTIME_10'.tar.gz' 'centos-x64.'$VER_RUNTIME_10'.tar.gz' 'debian-x64.'$VER_RUNTIME_10'.tar.gz' 'rhel-x64.'$VER_RUNTIME_10'.tar.gz' 'ubuntu-x64.'$VER_RUNTIME_10'.tar.gz' 'ubuntu.16.04-x64.'$VER_RUNTIME_10'.tar.gz')

    for i in "${runtime_archives[@]}"
        do
        : 
        #printf "%s\n" $RUNTIME"-"$i" "$BLOB_ROOT_RUNTIME$VER_RUNTIME_10"/"$RUNTIME"-"$i" "$DLC$DLC_ROOT_RUNTIME_10"/"$RUNTIME"-"$i
        curl -o $RUNTIME"-"$i" "$BLOB_ROOT_RUNTIME$VER_RUNTIME_10"/"$RUNTIME"-"$i
    done

# 1.1 Runtime Binary Archives
declare -a runtime_archives=('win-x64.'$VER_RUNTIME_11'.zip' 'win-x86.'$VER_RUNTIME_11'.zip' 'osx-x64.'$VER_RUNTIME_11'.tar.gz' 'centos-x64.'$VER_RUNTIME_11'.tar.gz' 'debian-x64.'$VER_RUNTIME_11'.tar.gz' 'fedora.24-x64.'$VER_RUNTIME_11'.tar.gz' 'rhel-x64.'$VER_RUNTIME_11'.tar.gz' 'ubuntu-x64.'$VER_RUNTIME_11'.tar.gz' 'ubuntu.16.04-x64.'$VER_RUNTIME_11'.tar.gz')

    for i in "${runtime_archives[@]}"
        do
        : 
        #printf "%s\n" $RUNTIME"-"$i" "$BLOB_ROOT_RUNTIME$VER_RUNTIME_11"/"$RUNTIME"-"$i" "$DLC$DLC_ROOT_RUNTIME_11"/"$RUNTIME"-"$i
        curl -o $RUNTIME"-"$i" "$BLOB_ROOT_RUNTIME$VER_RUNTIME_11"/"$RUNTIME"-"$i
    done