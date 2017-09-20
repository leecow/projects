# See help entry below for flags and usage example.
# update the variables in the 'Versions' section below to target the desired release. 

clear

### Versions ###
VER_SDK="1.1.4"
VER_RUNTIME_10="1.0.7"
VER_RUNTIME_11="1.1.4"
VER_HOST="1.0.1"
VER_HOST_11="1.1.0"
VER_HOSTFXR="1.0.1"
VER_HOSTFXR_11="1.1.0"

DLC_ROOT_SDK="F/4/F/F4FCB6EC-5F05-4DF8-822C-FF013DF1B17F"
DLC_ROOT_RUNTIME_10="E/9/E/E9E929B2-6532-43D7-98D2-E0B4445912BD"
DLC_ROOT_RUNTIME_11="6/F/B/6FB4F9D2-699B-4A40-A674-B7FF41E0E4D2"

# Locations, generall fixed and do not need to be updated. 
BLOB_ROOT_SDK="https://dotnetcli.blob.core.windows.net/dotnet/Sdk/"
BLOB_ROOT_RUNTIME="https://dotnetcli.blob.core.windows.net/dotnet/Runtime/"
DLC="https://download.microsoft.com/download/"

#### File name stubs for each component ####
DEV="dotnet-dev"
SDK="dotnet-sdk"
RUNTIME="dotnet"
SHARED="dotnet-sharedframework"
HOST="dotnet-host"
HOSTFXR="dotnet-hostfxr"
####################################################

#### Initialize and process command line options ####
C_RUNTIME='false'
C_SDK='false'
C_INSTALLER='false'
C_BINARY='false'
C_ALL='true'
C_PLATFORM='all'
C_VERSION='00'
TESTMODE="false"

while test $# -gt 0; do
    case "$1" in
        -h|help)
            echo ""
            echo "Flags:"
            echo "  -a | --all ........ Default: All packages, all platforms, version 1.0 and 1.1. Providing any other flag will override."
            echo "  -b | --binary ..... binary packages"
            echo "  -i | --installer .. installer packages"
            echo "  -p | --platform ... platform [osx, linux, win]"
            echo "  -r | --runtime .... Runtime"
            echo "  -s | --SDK ........ SDK"
            echo "  -t | --test ....... Test mode: text output only and no downloads initiated."
            echo "  -v | --version .... Version base to be downloaded [10, 11]"
            echo " "
            echo "Usage examples:"
            echo "  ./dotnet-dl.sh -r -i -v 10 ..... All v10 Runtime installers"
            echo "  ./dotnet-dl.sh -p osx -i ....... All osx installers"
            echo "  ./dotnet-dl.sh -p win -i -v11 .. V11 win installers"
            echo "  ./dotnet-dl.sh -p linux ........ All Linux installers and binary packages"
            exit 0
            ;;
        -a|--all)
            C_ALL='true'
            shift
            ;;
        -b|--binary)
            C_BINARY='true'
            C_ALL='false'
            shift
            ;;
        -i|--installer)
            C_INSTALLER='true'
            C_ALL='false'
            shift
            ;;
        -p|--platform)
            shift
            C_PLATFORM=$1
            # need a check here for valid platform values. osx, win, linux for now.
            shift
            ;;
        -r|--runtime)
            C_RUNTIME='true'
            C_ALL='false'
            shift
            ;;
        -s|--sdk)
            C_SDK='true'
            C_ALL='false'
            shift
            ;;
        -t|--test)
            TESTMODE='true'
            shift
            ;;
        -v|--version)
            shift
            C_VERSION=$1
            shift
            ;;
        *)
            echo "Undefined parameter."
            break
            ;;
    esac
done

function dl_runtime_installers()
{
    echo ""
    echo "Downloading Runtime Installers"
    echo ""

    if [ $C_VERSION = "10" ] || [ $C_VERSION = "00" ]
        then
            case "$C_PLATFORM" in
                linux)
                    declare -a runtime_installers=('ubuntu-x64.'$VER_RUNTIME_10'.deb' 'ubuntu.16.04-x64.'$VER_RUNTIME_10'.deb')
                ;;
                osx)
                    declare -a runtime_installers=('osx-x64.'$VER_RUNTIME_10'.pkg')
                ;;
                win)
                    declare -a runtime_installers=('win-x64.'$VER_RUNTIME_10'.exe' 'win-x86.'$VER_RUNTIME_10'.exe')
                ;;
                all)
                    declare -a runtime_installers=('osx-x64.'$VER_RUNTIME_10'.pkg' 'ubuntu-x64.'$VER_RUNTIME_10'.deb' 'ubuntu.16.04-x64.'$VER_RUNTIME_10'.deb' 'win-x64.'$VER_RUNTIME_10'.exe' 'win-x86.'$VER_RUNTIME_10'.exe')
                ;;
            esac

            for i in "${runtime_installers[@]}"
                do
                :
                if [[ $i = *'deb'* ]]
                # account for linux file name differences between Ubuntu and everyone else. 
                then
                    SHARED_NAME=$SHARED
                else
                    SHARED_NAME=$RUNTIME
                fi
        
                tmp_dl=${SHARED_NAME}"-"${i}" "${BLOB_ROOT_RUNTIME}${VER_RUNTIME_10}"/"${SHARED_NAME}"-"${i}
                if [ $TESTMODE = true ]
                    then
                        echo $tmp_dl
                    else
                        curl -o $tmp_dl
                fi
            done
    fi

    if [ $C_VERSION = "11" ] || [ $C_VERSION = "00" ]
        then
            case "$C_PLATFORM" in
                linux)
                    declare -a runtime_installers=('ubuntu-x64.'$VER_RUNTIME_11'.deb' 'ubuntu.16.04-x64.'$VER_RUNTIME_11'.deb')
                ;;
                osx)
                declare -a runtime_installers=('osx-x64.'$VER_RUNTIME_11'.pkg')
                ;;
                win)
                    declare -a runtime_installers=('win-x64.'$VER_RUNTIME_11'.exe' 'win-x86.'$VER_RUNTIME_11'.exe')
                ;;
                all)
                    declare -a runtime_installers=('osx-x64.'$VER_RUNTIME_11'.pkg' 'ubuntu-x64.'$VER_RUNTIME_11'.deb' 'ubuntu.16.04-x64.'$VER_RUNTIME_11'.deb' 'win-x64.'$VER_RUNTIME_11'.exe' 'win-x86.'$VER_RUNTIME_11'.exe')
                ;;
            esac

            for i in "${runtime_installers[@]}"
                do
                :
                if [[ $i = *'deb'* ]]
                # account for linux file name differences between Ubuntu and everyone else. 
                then
                    SHARED_NAME=$SHARED
                else
                    SHARED_NAME=$RUNTIME
                fi
        
                tmp_dl=${SHARED_NAME}"-"${i}" "${BLOB_ROOT_RUNTIME}${VER_RUNTIME_11}"/"${SHARED_NAME}"-"${i}
                if [ $TESTMODE = true ]
                    then
                        echo $tmp_dl
                    else
                        curl -o $tmp_dl
                fi
            done
    fi
}

function dl_host_installers()
{
    echo ""
    echo "Downloading Host and HostFXR Installers"
    echo ""

    if [ $C_VERSION = "10" ] || [ $C_VERSION = "00" ]
    then
        case "$C_PLATFORM" in
            linux)
                declare -a hostfxr_installers=('ubuntu-x64.'$VER_HOSTFXR'.deb' 'ubuntu.16.04-x64.'$VER_HOSTFXR'.deb')
                declare -a host_installers=('ubuntu-x64.'$VER_HOST'.deb' 'ubuntu.16.04-x64.'$VER_HOST'.deb')
            ;;
            osx)
                echo "No separate host and hostfxr installers for osx."
            ;;
            win)
                echo "No separate host and hostfxr installers for win."
            ;;
            all)
                declare -a hostfxr_installers=('ubuntu-x64.'$VER_HOSTFXR'.deb' 'ubuntu.16.04-x64.'$VER_HOSTFXR'.deb')
                declare -a host_installers=('ubuntu-x64.'$VER_HOST'.deb' 'ubuntu.16.04-x64.'$VER_HOST'.deb')
            ;;
        esac
        
        for i in "${hostfxr_installers[@]}"
        do
            : 
            tmp_dl=${HOSTFXR}"-"${i}" "${BLOB_ROOT_RUNTIME}${VER_RUNTIME_10}"/"${HOSTFXR}"-"${i}
            if [ $TESTMODE = true ]
                then
                    echo $tmp_dl
                else
                    curl -o $tmp_dl

            fi
        done
        for i in "${host_installers[@]}"
        do
            : 
            tmp_dl=${HOST}"-"${i}" "${BLOB_ROOT_RUNTIME}${VER_RUNTIME_10}"/"${HOST}"-"${i}
            if [ $TESTMODE = true ]
                then
                    echo $tmp_dl
                else
                    curl -o $tmp_dl
            fi
        done
    fi

    if [ $C_VERSION = "11" ] || [ $C_VERSION = "00" ]
        then
            case "$C_PLATFORM" in
                linux)
                    declare -a hostfxr_installers=('ubuntu-x64.'$VER_HOSTFXR_11'.deb' 'ubuntu.16.04-x64.'$VER_HOSTFXR_11'.deb')
                    declare -a host_installers=('ubuntu-x64.'$VER_HOST_11'.deb' 'ubuntu.16.04-x64.'$VER_HOST_11'.deb')
                ;;
                osx)
                    echo "No separate host and hostfxr installers for osx."
                ;;
                win)
                    echo "No separate host and hostfxr installers for win."
                ;;
                all)
                    declare -a hostfxr_installers=('ubuntu-x64.'$VER_HOSTFXR_11'.deb' 'ubuntu.16.04-x64.'$VER_HOSTFXR_11'.deb')
                    declare -a host_installers=('ubuntu-x64.'$VER_HOST_11'.deb' 'ubuntu.16.04-x64.'$VER_HOST_11'.deb')
                ;;
            esac
        for i in "${hostfxr_installers[@]}"
            do
                : 
                tmp_dl=${HOSTFXR}"-"${i}" "${BLOB_ROOT_RUNTIME}${VER_RUNTIME_11}"/"${HOSTFXR}"-"${i}
                if [ $TESTMODE = true ]
                    then
                        echo $tmp_dl
                    else
                        curl -o $tmp_dl
                fi
            done
        for i in "${host_installers[@]}"
            do
                : 
                tmp_dl=${HOST}"-"${i}" "${BLOB_ROOT_RUNTIME}${VER_RUNTIME_11}"/"${HOST}"-"${i}
                if [ $TESTMODE = true ]
                    then
                        echo $tmp_dl
                    else
                        curl -o $tmp_dl
                fi
            done
    fi
}

function dl_sdk_installers()
{
    echo ""
    echo "Downloading SDK Installers"
    echo ""

    case "$C_PLATFORM" in
        linux)
            declare -a dev_installers=('ubuntu-x64.'$VER_SDK'.deb' 'ubuntu.16.04-x64.'$VER_SDK'.deb')
            ;;
        osx)
            declare -a dev_installers=('osx-x64.'$VER_SDK'.pkg')
            ;;
        win)
            declare -a dev_installers=('win-x64.'$VER_SDK'.exe' 'win-x86.'$VER_SDK'.exe')
            ;;
        all)
            declare -a dev_installers=('osx-x64.'$VER_SDK'.pkg' 'win-x64.'$VER_SDK'.exe' 'win-x86.'$VER_SDK'.exe' 'ubuntu-x64.'$VER_SDK'.deb' 'ubuntu.16.04-x64.'$VER_SDK'.deb')
            ;;
    esac
            
    for i in "${dev_installers[@]}"
        do
        :
        if [[ $i = *'deb'* ]]
        # account for sdk file name differences between Ubuntu and everyone else. 
        then
            DEV_NAME=$SDK
        else
            DEV_NAME=$DEV
        fi
        tmp_dl=${DEV_NAME}"-"${i}" "${BLOB_ROOT_SDK}${VER_SDK}"/"${DEV_NAME}"-"${i}
        if [ $TESTMODE = true ]
            then
                echo $tmp_dl
            else
                curl -o $tmp_dl
        fi
    done
        
    for i in "${sdk_installers[@]}"
        do
        :
        tmp_dl=${SDK}"-"${i}" "${BLOB_ROOT_SDK}${VER_SDK}"/"${SDK}"-"${i}
        if [ $TESTMODE = true ]
            then
                echo $tmp_dl
            else
                curl -o $tmp_dl
        fi
    done

}

function dl_sdk_binaries()
{
    echo ""
    echo "downloading sdk binaries"
    echo ""
    case "$C_PLATFORM" in
        linux)
            declare -a sdk_archives=('centos-x64.'$VER_SDK'.tar.gz' 'debian-x64.'$VER_SDK'.tar.gz' 'fedora.24-x64.'$VER_SDK'.tar.gz' 'opensuse.42.1-x64.'$VER_SDK'.tar.gz' 'rhel-x64.'$VER_SDK'.tar.gz' 'ubuntu-x64.'$VER_SDK'.tar.gz' 'ubuntu.16.04-x64.'$VER_SDK'.tar.gz')
            ;;
        osx)
            declare -a sdk_archives=('osx-x64.'$VER_SDK'.tar.gz')
            ;;
        win)
            declare -a sdk_archives=('win-x64.'$VER_SDK'.zip' 'win-x86.'$VER_SDK'.zip')
            ;;
        all)
            declare -a sdk_archives=('centos-x64.'$VER_SDK'.tar.gz' 'debian-x64.'$VER_SDK'.tar.gz' 'fedora.24-x64.'$VER_SDK'.tar.gz' 'opensuse.42.1-x64.'$VER_SDK'.tar.gz' 'osx-x64.'$VER_SDK'.tar.gz' 'rhel-x64.'$VER_SDK'.tar.gz' 'ubuntu-x64.'$VER_SDK'.tar.gz' 'ubuntu.16.04-x64.'$VER_SDK'.tar.gz' 'win-x64.'$VER_SDK'.zip' 'win-x86.'$VER_SDK'.zip')
            ;;
    esac

        for i in "${sdk_archives[@]}"
            do
            : 
            tmp_dl=${DEV}"-"${i}" "${BLOB_ROOT_SDK}${VER_SDK}"/"${DEV}"-"${i}
                if [ $TESTMODE = true ]
                    then
                        echo $tmp_dl
                    else
                        curl -o $tmp_dl
                fi
        done
}

function dl_runtime_binaries(){
    echo ""
    echo "Downloading Runtime Binaries"
    echo ""
    if [ $C_VERSION = "10" ] || [ $C_VERSION = "00" ]
        then
            case "$C_PLATFORM" in
                linux)
                    declare -a runtime_archives=('centos-x64.'$VER_RUNTIME_10'.tar.gz' 'debian-x64.'$VER_RUNTIME_10'.tar.gz' 'rhel-x64.'$VER_RUNTIME_10'.tar.gz' 'ubuntu-x64.'$VER_RUNTIME_10'.tar.gz' 'ubuntu.16.04-x64.'$VER_RUNTIME_10'.tar.gz')
                ;;
                osx)
                    declare -a runtime_archives=('osx-x64.'$VER_RUNTIME_10'.tar.gz')
                ;;
                win)
                    declare -a runtime_archives=('win-x64.'$VER_RUNTIME_10'.zip' 'win-x86.'$VER_RUNTIME_10'.zip')
                ;;
                all)
                    declare -a runtime_archives=('centos-x64.'$VER_RUNTIME_10'.tar.gz' 'debian-x64.'$VER_RUNTIME_10'.tar.gz' 'rhel-x64.'$VER_RUNTIME_10'.tar.gz' 'ubuntu-x64.'$VER_RUNTIME_10'.tar.gz' 'ubuntu.16.04-x64.'$VER_RUNTIME_10'.tar.gz' 'osx-x64.'$VER_RUNTIME_10'.tar.gz' 'win-x64.'$VER_RUNTIME_10'.zip' 'win-x86.'$VER_RUNTIME_10'.zip')
                ;;

            esac      

            for i in "${runtime_archives[@]}"
                do
                : 
                tmp_dl=${RUNTIME}"-"${i}" "${BLOB_ROOT_RUNTIME}${VER_RUNTIME_10}"/"${RUNTIME}"-"${i}
                if [ $TESTMODE = true ]
                    then
                        echo $tmp_dl
                    else
                        curl -o $tmp_dl
                fi
            done
    fi

    if [ $C_VERSION = "11" ] || [ $C_VERSION = "00" ]
        then
            case "$C_PLATFORM" in
                linux)
                    declare -a runtime_archives=('centos-x64.'$VER_RUNTIME_11'.tar.gz' 'debian-x64.'$VER_RUNTIME_11'.tar.gz' 'fedora.24-x64.'$VER_RUNTIME_11'.tar.gz' 'rhel-x64.'$VER_RUNTIME_11'.tar.gz' 'ubuntu-x64.'$VER_RUNTIME_11'.tar.gz' 'ubuntu.16.04-x64.'$VER_RUNTIME_11'.tar.gz')
                ;;
                osx)
                    declare -a runtime_archives=('osx-x64.'$VER_RUNTIME_11'.tar.gz')
                ;;
                win)
                    declare -a runtime_archives=('win-x64.'$VER_RUNTIME_11'.zip' 'win-x86.'$VER_RUNTIME_11'.zip')
                ;;
                all)
                    declare -a runtime_archives=('centos-x64.'$VER_RUNTIME_11'.tar.gz' 'debian-x64.'$VER_RUNTIME_11'.tar.gz' 'fedora.24-x64.'$VER_RUNTIME_11'.tar.gz' 'rhel-x64.'$VER_RUNTIME_11'.tar.gz' 'ubuntu-x64.'$VER_RUNTIME_11'.tar.gz' 'ubuntu.16.04-x64.'$VER_RUNTIME_11'.tar.gz' 'osx-x64.'$VER_RUNTIME_11'.tar.gz' 'win-x64.'$VER_RUNTIME_11'.zip' 'win-x86.'$VER_RUNTIME_11'.zip')
                ;;
            esac     
        
            for i in "${runtime_archives[@]}"
                do
                :
                tmp_dl=${RUNTIME}"-"${i}" "${BLOB_ROOT_RUNTIME}${VER_RUNTIME_11}"/"${RUNTIME}"-"${i}
                if [ $TESTMODE = true ]
                    then
                        echo $tmp_dl
                    else
                        curl -o $tmp_dl
                fi
            done
    fi
}

#### Contol logic ####

# echo "##### command line settings #####"
# echo "Runtime: " $C_RUNTIME
# echo "SDK: " $C_SDK
# echo "VERSION: " $C_VERSION
# echo "INSTALLER: " $C_INSTALLER
# echo "BINARY: " $C_BINARY
# echo "PLATFORM: " $C_PLATFORM
# echo "ALL: " $C_ALL
# echo "#######################"

### circuit breaker for parse testing
# exit 0  
####

if [ $C_ALL = true ]
    then
        echo ""
        echo "## Downloading all packages ##"
        echo ""
        dl_sdk_binaries
        dl_sdk_installers
        dl_runtime_binaries
        dl_runtime_installers
        dl_host_installers
    elif [ $C_SDK = true ] && [ $C_BINARY != true ] && [ $C_INSTALLER != true ]
    then
        dl_sdk_binaries
        dl_sdk_installers
    elif [ $C_RUNTIME = true ] && [ $C_BINARY != true ] && [ $C_INSTALLER != true ]
    then
        dl_runtime_binaries
        dl_runtime_installers
        dl_host_installers
    else
    if [ $C_BINARY = true ]
        then
            if [ $C_SDK = true ]
            # SDK Binary Archives
            then
                dl_sdk_binaries
            elif [ $C_RUNTIME = true ]
            # Runtime Binary Archives
            then                
                dl_runtime_binaries
            else
                dl_sdk_binaries
                dl_runtime_binaries
            fi
    fi

    if [ $C_INSTALLER = true ]
        then
            if [ $C_SDK = true ]
            # SDK Installers
            then
                dl_sdk_installers
            elif [ $C_RUNTIME = true ]
            # Runtime installers
            then
                dl_runtime_installers
                dl_host_installers
            else
                dl_sdk_installers
                dl_runtime_installers
                dl_host_installers
            fi
    fi
fi