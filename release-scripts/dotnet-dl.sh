#!/usr/bin/env bash
# See help entry below for flags and usage example.
# Update the Version and location data in release-versions.sh to target the desired release. 

clear

. ./release-versions.sh

#### File name stubs for each component ####
DEV="dotnet-dev"
SDK="dotnet-sdk"
RUNTIME_10="dotnet"
RUNTIME_20="dotnet-runtime"
SHARED="dotnet-sharedframework"
HOST="dotnet-host"
HOSTFXR="dotnet-hostfxr"
####################################################

#### Initialize and process command line options ####
C_RUNTIME='true'
C_SDK='true'
C_INSTALLER='true'
C_BINARY='true'
C_ALL='false'
C_PLATFORM='all'
C_VERSION='00'
TESTMODE='false'

function print_settings()
{
    echo ""
    echo " --------------------------------------------------------"
    echo "|                     Tool parameters                    |"
    echo " --------------------------------------------------------"
    echo " C_RUNTIME: "   $C_RUNTIME
    echo " C_SDK: "       $C_SDK
    echo " C_INSTALLER: " $C_INSTALLER
    echo " C_BINARY: "    $C_BINARY
    echo " C_ALL: "       $C_ALL
    echo " C_PLATFORM: "  $C_PLATFORM
    echo " C_VERSION: "   $C_VERSION
    echo " C_TESTMODE: "  $TESTMODE
}

function print_help()
{
    echo ""
    echo " --------------------------------------------------------"
    echo "|             Download tool for .NET Core                |"
    echo " --------------------------------------------------------"
    echo "Flags:"
    echo "  -a | --all ........ All packages, all platforms, version 1.0 and 1.1. Providing any other flag will override."
    echo "  -b | --binary ..... Binary packages"
    echo "  -i | --installer .. Installer packages"
    echo "  -p | --platform ... Platform [linux, osx, win, all]"
    echo "  -r | --runtime .... Runtime"
    echo "  -s | --sdk ........ SDK"
    echo "  -t | --test ....... Test mode: text output only and no downloads initiated."
    echo "  -v | --version .... Version base to be downloaded [10, 11, 20]"
    echo " "
    echo "Usage examples:"
    echo "  ./dotnet-dl.sh -r -i -v 10 .......... All 1.0 runtime installers"
    echo "  ./dotnet-dl.sh -v 20 ................ All 2.0 installers and binary packages"
    echo "  ./dotnet-dl.sh -p osx -i -v 20 ...... 2.0 osx installers"
    echo "  ./dotnet-dl.sh -s -p win -i -v 11 ... 1.1 win sdk installers"
    echo "  ./dotnet-dl.sh -r -b linux -v 20 .... Linux runtime binary packages"
    echo ""
}

function print_env()
{
    echo " --------------------------------------"
    echo "| Variables set by release-versions.sh |"
    echo " --------------------------------------"
    ### Versions ###
    echo
    echo "-- Versions: Runtime --"
    echo "1.0 Host:     " $VER_HOST_10
    echo "1.0 Host FXR: " $VER_HOSTFXR_10
    echo "1.0 Runtime:  " $VER_RUNTIME_10
    echo "1.1 Host:     " $VER_HOST_11
    echo "1.1 Host FXR: " $VER_HOSTFXR_11
    echo "1.1 Runtime:  " $VER_RUNTIME_11
    echo "2.0 Runtime:  " $VER_RUNTIME_20
    echo "-- Versions: SDK --"
    echo "1.0 SDK:      " $VER_SDK_10
    echo "1.1 SDK:      " $VER_SDK_11
    echo "2.0 SDK:      " $VER_SDK_20
    # Locations
    echo
    echo "-- Containers and urls --"
    echo "DLC Runtime 1.0: " $DLC_ROOT_RUNTIME_10
    echo "DLC SDK 1.0: " $DLC_ROOT_SDK_10
    echo "DLC SDK 1.1: " $DLC_ROOT_SDK_11
    echo "DLC Runtime 1.1: " $DLC_ROOT_RUNTIME_11
    echo "DLC SDK 2.0: " $DLC_ROOT_SDK_20
    echo "Blob SDK: " $BLOB_ROOT_SDK
    echo "Blob Runtime: " $BLOB_ROOT_RUNTIME
    echo "DLC URL: " $DLC
}

# input parameter testing

if [ $# -eq 0 ] 
then
    echo "No parameters. Printing env and help ..."
    TESTMODE='true'
    print_help
    print_env
    exit 0
fi

while test $# -gt 0; do
    case "$1" in
        -h|help)
            print_help
            exit 0
            ;;
        -a|--all)
            C_ALL='true'
            shift
            ;;
        -b|--binary)
            C_BINARY='true'
            C_ALL='false'
            C_INSTALLER='false'
            shift
            ;;
        -i|--installer)
            C_INSTALLER='true'
            C_BINARY='false'
            C_ALL='false'
            shift
            ;;
        -p|--platform)
            shift
            C_PLATFORM=$1
            C_ALL='false'
            # is osx, linux, win?
            if [ $C_PLATFORM = 'linux' ] || [ $C_PLATFORM = 'osx' ] || [ $C_PLATFORM = 'win' ] || [ $C_PLATFORM = 'all' ]
            then
                shift
            else
                echo '"'$C_PLATFORM'"' "platform unknown. Please use linux, osx, win or all."
                print_help
                exit 0
            fi
            ;;
        -r|--runtime)
            C_RUNTIME='true'
            C_SDK='false'
            C_ALL='false'
            shift
            ;;
        -s|--sdk)
            C_SDK='true'
            C_RUNTIME='false'
            C_ALL='false'
            shift
            ;;
        -t|--test)
            TESTMODE='true'
            print_settings
            print_env
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

if [ $C_VERSION = "00" ]
then
    clear
    echo "Please provide a version number."
    print_help
    exit 0
fi

function dl_runtime_installers()
{
    echo ""
    echo "Downloading Runtime Installers"
    echo ""
            case "$C_PLATFORM" in
                linux)
                    if [ $C_VERSION = "10" ]
                    then
                        declare -a runtime_installers=('ubuntu-x64.'$VER_RUNTIME_10'.deb' 'ubuntu.16.04-x64.'$VER_RUNTIME_10'.deb')
                    fi
                    if [ $C_VERSION = "11" ]
                    then
                        declare -a runtime_installers=('ubuntu-x64.'$VER_RUNTIME_11'.deb' 'ubuntu.16.04-x64.'$VER_RUNTIME_11'.deb')
                    fi
                    if [ $C_VERSION = "20" ]
                    then
                        declare -a runtime_installers=('debian-x64.deb' 'rhel-x64.rpm' 'ubuntu-x64.deb' 'ubuntu.16.04-x64.deb')
                    fi
                ;;
                osx)
                    if [ $C_VERSION = "10" ]
                    then
                        declare -a runtime_installers=('osx-x64.'$VER_RUNTIME_10'.pkg')
                    fi
                    if [ $C_VERSION = "11" ]
                    then
                        declare -a runtime_installers=('osx-x64.'$VER_RUNTIME_11'.pkg')
                    fi
                    if [ $C_VERSION = "20" ]
                    then
                        declare -a runtime_installers=('osx-x64.pkg')
                    fi
                ;;
                win)
                    if [ $C_VERSION = "10" ]
                    then
                        declare -a runtime_installers=('win-x64.'$VER_RUNTIME_10'.exe' 'win-x86.'$VER_RUNTIME_10'.exe')
                    fi
                    if [ $C_VERSION = "11" ]
                    then
                        declare -a runtime_installers=('win-x64.'$VER_RUNTIME_11'.exe' 'win-x86.'$VER_RUNTIME_11'.exe')
                    fi
                    if [ $C_VERSION = "20" ]
                    then
                        declare -a runtime_installers=('win-x64.exe' 'win-x86.exe')
                    fi
                ;;
                all)
                    if [ $C_VERSION = "10" ]
                    then
                        declare -a runtime_installers=('osx-x64.'$VER_RUNTIME_10'.pkg' 'ubuntu-x64.'$VER_RUNTIME_10'.deb' 'ubuntu.16.04-x64.'$VER_RUNTIME_10'.deb' 'win-x64.'$VER_RUNTIME_10'.exe' 'win-x86.'$VER_RUNTIME_10'.exe')
                    fi
                    if [ $C_VERSION = "11" ]
                    then
                        declare -a runtime_installers=('osx-x64.'$VER_RUNTIME_11'.pkg' 'ubuntu-x64.'$VER_RUNTIME_11'.deb' 'ubuntu.16.04-x64.'$VER_RUNTIME_11'.deb' 'win-x64.'$VER_RUNTIME_11'.exe' 'win-x86.'$VER_RUNTIME_11'.exe')
                    fi
                    if [ $C_VERSION = "20" ]
                    then
                        declare -a runtime_installers=('osx-x64.pkg' 'win-x64.exe' 'win-x86.exe' 'debian-x64.deb' 'rhel-x64.rpm' 'ubuntu-x64.deb' 'ubuntu.16.04-x64.deb')
                    fi
                ;;
            esac

            for i in "${runtime_installers[@]}"
                do
                :
                if [[ $i = *'deb'* ]] && [[ $C_VERSION != 20 ]]
                # account for linux file name differences between Ubuntu and everyone else. 
                then
                    SHARED_NAME=$SHARED
                else
                    SHARED_NAME=$RUNTIME_10
                fi
                # build tmp_dl according to version filespec
                case "$C_VERSION" in
                    10)
                        tmp_dl=${SHARED_NAME}"-"${i}" "${BLOB_ROOT_RUNTIME}${VER_RUNTIME_10}"/"${SHARED_NAME}"-"${i}
                    ;;
                    11)
                        tmp_dl=${SHARED_NAME}"-"${i}" "${BLOB_ROOT_RUNTIME}${VER_RUNTIME_11}"/"${SHARED_NAME}"-"${i}
                    ;;
                    20)                        
                        tmp_dl=${RUNTIME_20}"-"${VER_RUNTIME_20}"-"${i}" "${BLOB_ROOT_RUNTIME}${VER_RUNTIME_20}"/"${RUNTIME_20}"-"${VER_RUNTIME_20}"-"${i}
                    ;;
                esac

                if [ $TESTMODE = true ]
                    then
                        echo $tmp_dl
                    else
                        echo $tmp_dl
                        curl -o $tmp_dl
                fi
            done
}

function dl_host_installers()
{
    echo ""
    echo "Downloading Host and HostFXR Installers"
    echo ""
        case "$C_PLATFORM" in
            linux)
                if [ $C_VERSION = "10" ]
                then
                    declare -a hostfxr_installers=('ubuntu-x64.'$VER_HOSTFXR_10'.deb' 'ubuntu.16.04-x64.'$VER_HOSTFXR_10'.deb')
                    declare -a host_installers=('ubuntu-x64.'$VER_HOST_10'.deb' 'ubuntu.16.04-x64.'$VER_HOST_10'.deb')
                fi
                if [ $C_VERSION = "11" ]
                then
                    declare -a hostfxr_installers=('ubuntu-x64.'$VER_HOSTFXR_11'.deb' 'ubuntu.16.04-x64.'$VER_HOSTFXR_11'.deb')
                    declare -a host_installers=('ubuntu-x64.'$VER_HOST_11'.deb' 'ubuntu.16.04-x64.'$VER_HOST_11'.deb')
                fi
                if [ $C_VERSION = "20" ]
                then
                    declare -a hostfxr_installers=('debian-x64.deb' 'rhel-x64.rpm' 'ubuntu-x64.deb' 'ubuntu.16.04-x64.deb')
                    declare -a hostfxr_installers=('debian-x64.deb' 'rhel-x64.rpm' 'ubuntu-x64.deb' 'ubuntu.16.04-x64.deb')
                fi
            ;;
            osx)
                echo "No separate host and hostfxr installers for osx."
            ;;
            win)
                echo "No separate host and hostfxr installers for win."
            ;;
            all)
                if [ $C_VERSION = "10" ] || [ $C_VERSION = "00" ]
                then
                    declare -a hostfxr_installers=('ubuntu-x64.'$VER_HOSTFXR_10'.deb' 'ubuntu.16.04-x64.'$VER_HOSTFXR_10'.deb')
                    declare -a host_installers=('ubuntu-x64.'$VER_HOST_10'.deb' 'ubuntu.16.04-x64.'$VER_HOST_10'.deb')
                fi
                if [ $C_VERSION = "11" ]
                then
                    declare -a hostfxr_installers=('ubuntu-x64.'$VER_HOSTFXR_11'.deb' 'ubuntu.16.04-x64.'$VER_HOSTFXR_11'.deb')
                    declare -a host_installers=('ubuntu-x64.'$VER_HOST_11'.deb' 'ubuntu.16.04-x64.'$VER_HOST_11'.deb')
                fi
                if [ $C_VERSION = "20" ]
                then
                    declare -a hostfxr_installers=('debian-x64.deb' 'rhel-x64.rpm' 'ubuntu-x64.deb' 'ubuntu.16.04-x64.deb')
                    declare -a host_installers=('debian-x64.deb' 'rhel-x64.rpm' 'ubuntu-x64.deb' 'ubuntu.16.04-x64.deb')
                fi
            ;;
        esac
        
        for i in "${hostfxr_installers[@]}"
        do
            : 
            case "$C_VERSION" in
            10)
                tmp_dl=${HOSTFXR}"-"${i}" "${BLOB_ROOT_RUNTIME}${VER_RUNTIME_10}"/"${HOSTFXR}"-"${i}
            ;;
            11)
                tmp_dl=${HOSTFXR}"-"${i}" "${BLOB_ROOT_RUNTIME}${VER_RUNTIME_11}"/"${HOSTFXR}"-"${i}
            ;;
            20)
                tmp_dl=${HOSTFXR}"-"${VER_RUNTIME_20}"-"${i}" "${BLOB_ROOT_RUNTIME}${VER_RUNTIME_20}"/"${HOSTFXR}"-"${VER_RUNTIME_20}"-"${i}
            ;;
            esac

            if [ $TESTMODE = true ]
                then
                    echo $tmp_dl
                else
                    echo $tmp_dl
                    curl -o $tmp_dl
            fi
        done

        for i in "${host_installers[@]}"
        do
            : 
            case "$C_VERSION" in
            10)
                tmp_dl=${HOST}"-"${i}" "${BLOB_ROOT_RUNTIME}${VER_RUNTIME_10}"/"${HOST}"-"${i}
            ;;
            11)
                tmp_dl=${HOST}"-"${i}" "${BLOB_ROOT_RUNTIME}${VER_RUNTIME_11}"/"${HOST}"-"${i}
            ;;
            20)
                tmp_dl=${HOST}"-"${VER_RUNTIME_20}"-"${i}" "${BLOB_ROOT_RUNTIME}${HOST}"-"${VER_RUNTIME_20}"-"${i}
            ;;
            esac

            if [ $TESTMODE = true ]
                then
                    echo $tmp_dl
                else
                    echo $tmp_dl
                    curl -o $tmp_dl
            fi
        done
}

function dl_sdk_installers()
{
    echo ""
    echo "Downloading SDK installers ..."
    echo ""

    case "$C_PLATFORM" in
        linux)
            if [ $C_VERSION = "10" ] || [ $C_VERSION = "11" ] || [ $C_VERSION = "00" ]
            then
                declare -a dev_installers=('ubuntu-x64.'$VER_SDK_11'.deb' 'ubuntu.16.04-x64.'$VER_SDK_11'.deb')
            fi
            if [ $C_VERSION = "20" ]
            then
                declare -a dev_installers=('debian-x64.deb' 'rhel-x64.rpm' 'ubuntu-x64.deb' 'ubuntu.16.04-x64.deb')

            fi
            ;;
        osx)
            if [ $C_VERSION = "10" ] || [ $C_VERSION = "11" ] || [ $C_VERSION = "00" ]
            then
                declare -a dev_installers=('osx-x64.'$VER_SDK_11'.pkg')
            fi
            if [ $C_VERSION = "20" ]
            then
                declare -a dev_installers=('osx-x64.pkg')

            fi
            ;;
        win)
            if [ $C_VERSION = "10" ] || [ $C_VERSION = "11" ] || [ $C_VERSION = "00" ]
            then
                declare -a dev_installers=('win-x64.'$VER_SDK_11'.exe' 'win-x86.'$VER_SDK_11'.exe')
            fi
            if [ $C_VERSION = "20" ]
            then
                declare -a dev_installers=('win-x86.exe' 'win-x64.exe')

            fi
            ;;
        all)
            if [ $C_VERSION = "10" ] || [ $C_VERSION = "11" ] || [ $C_VERSION = "00" ]
            then
                declare -a dev_installers=('osx-x64.'$VER_SDK_11'.pkg' 'win-x64.'$VER_SDK_11'.exe' 'win-x86.'$VER_SDK_11'.exe' 'ubuntu-x64.'$VER_SDK_11'.deb' 'ubuntu.16.04-x64.'$VER_SDK_11'.deb')
            fi
            if [ $C_VERSION = "20" ]
            then
                declare -a dev_installers=('debian-x64.deb' 'osx-x64.pkg' 'rhel-x64.rpm' 'ubuntu-x64.deb' 'ubuntu.16.04-x64.deb' 'win-x86.exe' 'win-x64.exe')

            fi
            ;;
    esac
            
    for i in "${dev_installers[@]}"
        do
        :
        if [ $C_VERSION = "10" ] || [ $C_VERSION = "11" ] || [ $C_VERSION = "00" ]
        then
            if [[ $i = *'deb'* ]]
            # account for sdk file name differences between Ubuntu and everyone else. 
            then
                DEV_NAME=$SDK
            else
                DEV_NAME=$DEV
            fi
            tmp_dl=${DEV_NAME}"-"${i}" "${BLOB_ROOT_SDK}${VER_SDK_11}"/"${DEV_NAME}"-"${i}
        fi
        if [ $C_VERSION = "20" ]
        then
            tmp_dl=${SDK}"-"${VER_SDK_20}"-"${i}" "${BLOB_ROOT_SDK}${VER_SDK_20}"/"${SDK}"-"${VER_SDK_20}"-"${i}
        fi
        if [ $TESTMODE = true ]
            then
                echo $tmp_dl
            else
                echo $tmp_dl
                curl -o $tmp_dl
        fi
    done
        
    for i in "${sdk_installers[@]}"
        do
        :
        tmp_dl=${SDK}"-"${i}" "${BLOB_ROOT_SDK}${VER_SDK_11}"/"${SDK}"-"${i}
        if [ $TESTMODE = true ]
            then
                echo $tmp_dl
            else
                echo $tmp_dl
                curl -o $tmp_dl
        fi
    done

}

function dl_sdk_binaries()
{
    echo ""
    echo "Downloading SDK binaries ... v"$C_VERSION
    echo ""
    case "$C_PLATFORM" in
        linux)
            if [ $C_VERSION = "10" ] || [ $C_VERSION = "11" ] || [ $C_VERSION = "00" ]
            then
                declare -a sdk_archives=('centos-x64.'$VER_SDK_11'.tar.gz' 'debian-x64.'$VER_SDK_11'.tar.gz' 'fedora.24-x64.'$VER_SDK_11'.tar.gz' 'rhel-x64.'$VER_SDK_11'.tar.gz' 'ubuntu-x64.'$VER_SDK_11'.tar.gz' 'ubuntu.16.04-x64.'$VER_SDK_11'.tar.gz')
            fi
            if [ $C_VERSION = "20" ]
            then
                declare -a sdk_archives=('linux-x64.tar.gz')
            fi
            ;;
        osx)
            if [ $C_VERSION = "10" ] || [ $C_VERSION = "11" ] || [ $C_VERSION = "00" ]
            then
                declare -a sdk_archives=('osx-x64.'$VER_SDK_11'.tar.gz')
            fi
            if [ $C_VERSION = "20" ]
            then
                declare -a sdk_archives=('osx-x64.tar.gz')
            fi
            ;;
        win)
            if [ $C_VERSION = "10" ] || [ $C_VERSION = "11" ] || [ $C_VERSION = "00" ]
            then
                declare -a sdk_archives=('win-x64.'$VER_SDK_11'.zip' 'win-x86.'$VER_SDK_11'.zip')
            fi
            if [ $C_VERSION = "20" ]
            then
                declare -a sdk_archives=('win-x64.zip' 'win-x86.zip')
            fi
            ;;
        all)
            if [ $C_VERSION = "10" ] || [ $C_VERSION = "11" ] || [ $C_VERSION = "00" ]
            then
                declare -a sdk_archives=('centos-x64.'$VER_SDK_11'.tar.gz' 'debian-x64.'$VER_SDK_11'.tar.gz' 'fedora.24-x64.'$VER_SDK_11'.tar.gz' 'osx-x64.'$VER_SDK_11'.tar.gz' 'rhel-x64.'$VER_SDK_11'.tar.gz' 'ubuntu-x64.'$VER_SDK_11'.tar.gz' 'ubuntu.16.04-x64.'$VER_SDK_11'.tar.gz' 'win-x64.'$VER_SDK_11'.zip' 'win-x86.'$VER_SDK_11'.zip')
            fi
            if [ $C_VERSION = "20" ]
            then
                declare -a sdk_archives=('linux-x64.tar.gz' 'osx-x64.tar.gz' 'win-x64.zip' 'win-x86.zip')
            fi
            ;;
    esac

        for i in "${sdk_archives[@]}"
            do
            : 
            if [ $C_VERSION = "10" ] || [ $C_VERSION = "11" ] || [ $C_VERSION = "00" ]
            then
                tmp_dl=${DEV}"-"${i}" "${BLOB_ROOT_SDK}${VER_SDK_11}"/"${DEV}"-"${i}
            fi
            if [ $C_VERSION = "20" ]
            then
                tmp_dl=${SDK}"-"${VER_SDK_20}"-"${i}" "${BLOB_ROOT_SDK}${VER_SDK_20}"/"${SDK}"-"${VER_SDK_20}"-"${i}
            fi
            if [ $TESTMODE = true ]
                then
                    echo $tmp_dl
                else
                    echo $tmp_dl
                    curl -o $tmp_dl
            fi
        done
}

function dl_runtime_binaries(){
    echo ""
    echo "Downloading Runtime Binaries"
    echo ""
        case "$C_PLATFORM" in
            linux)
                if [ $C_VERSION = "10" ] || [ $C_VERSION = "11" ]
                then
                    declare -a runtime_archives=('centos-x64.'$VER_RUNTIME_10'.tar.gz' 'debian-x64.'$VER_RUNTIME_10'.tar.gz' 'rhel-x64.'$VER_RUNTIME_10'.tar.gz' 'ubuntu-x64.'$VER_RUNTIME_10'.tar.gz' 'ubuntu.16.04-x64.'$VER_RUNTIME_10'.tar.gz')
                fi
                if [ $C_VERSION = "11" ]
                then
                    declare -a runtime_archives=('centos-x64.'$VER_RUNTIME_11'.tar.gz' 'debian-x64.'$VER_RUNTIME_11'.tar.gz' 'rhel-x64.'$VER_RUNTIME_11'.tar.gz' 'ubuntu-x64.'$VER_RUNTIME_11'.tar.gz' 'ubuntu.16.04-x64.'$VER_RUNTIME_11'.tar.gz')
                fi
                if [ $C_VERSION = "20" ]
                then
                    declare -a runtime_archives=('linux-x64.tar.gz')
                fi
            ;;
            osx)
                if [ $C_VERSION = "10" ]
                then
                    declare -a runtime_archives=('osx-x64.'$VER_RUNTIME_10'.tar.gz')
                fi
                if [ $C_VERSION = "11" ]
                then
                    declare -a runtime_archives=('centos-x64.'$VER_RUNTIME_11'.tar.gz' 'debian-x64.'$VER_RUNTIME_11'.tar.gz' 'rhel-x64.'$VER_RUNTIME_11'.tar.gz' 'ubuntu-x64.'$VER_RUNTIME_11'.tar.gz' 'ubuntu.16.04-x64.'$VER_RUNTIME_11'.tar.gz')
                fi
                if [ $C_VERSION = "20" ]
                then
                    declare -a runtime_archives=('osx-x64.tar.gz')
                fi
            ;;
            win)
                if [ $C_VERSION = "10" ]
                then
                    declare -a runtime_archives=('win-x64.'$VER_RUNTIME_10'.zip' 'win-x86.'$VER_RUNTIME_10'.zip')
                fi
                if [ $C_VERSION = "11" ]
                then
                    declare -a runtime_archives=('centos-x64.'$VER_RUNTIME_11'.tar.gz' 'debian-x64.'$VER_RUNTIME_11'.tar.gz' 'rhel-x64.'$VER_RUNTIME_11'.tar.gz' 'ubuntu-x64.'$VER_RUNTIME_11'.tar.gz' 'ubuntu.16.04-x64.'$VER_RUNTIME_11'.tar.gz')
                fi
                if [ $C_VERSION = "20" ]
                then
                    declare -a runtime_archives=('win-x64.zip' 'win-x86.zip')
                fi
            ;;
            all)
                if [ $C_VERSION = "10" ]
                then
                    declare -a runtime_archives=('centos-x64.'$VER_RUNTIME_10'.tar.gz' 'debian-x64.'$VER_RUNTIME_10'.tar.gz' 'rhel-x64.'$VER_RUNTIME_10'.tar.gz' 'ubuntu-x64.'$VER_RUNTIME_10'.tar.gz' 'ubuntu.16.04-x64.'$VER_RUNTIME_10'.tar.gz' 'osx-x64.'$VER_RUNTIME_10'.tar.gz' 'win-x64.'$VER_RUNTIME_10'.zip' 'win-x86.'$VER_RUNTIME_10'.zip')
                fi
                if [ $C_VERSION = "11" ]
                then
                    declare -a runtime_archives=('centos-x64.'$VER_RUNTIME_11'.tar.gz' 'debian-x64.'$VER_RUNTIME_11'.tar.gz' 'rhel-x64.'$VER_RUNTIME_11'.tar.gz' 'ubuntu-x64.'$VER_RUNTIME_11'.tar.gz' 'ubuntu.16.04-x64.'$VER_RUNTIME_11'.tar.gz')
                fi
                if [ $C_VERSION = "20" ]
                then
                    declare -a runtime_archives=('linux-x64.tar.gz' 'osx-x64.tar.gz' 'win-x64.zip' 'win-x86.zip')
                fi
            ;;

        esac   

        for i in "${runtime_archives[@]}"
            do
            : 
            if [ $C_VERSION = "10" ] || [ $C_VERSION = "11" ] || [ $C_VERSION = "00" ]
            then
                tmp_dl=${RUNTIME_10}"-"${i}" "${BLOB_ROOT_RUNTIME}${VER_RUNTIME_10}"/"${RUNTIME_10}"-"${i}
            fi
            if [ $C_VERSION = "20" ]
            then
                tmp_dl=${RUNTIME_20}"-"${VER_RUNTIME_20}"-"${i}" "${BLOB_ROOT_RUNTIME}${VER_RUNTIME_20}"/"${RUNTIME_20}"-"${VER_RUNTIME_20}"-"${i}
            fi
            if [ $TESTMODE = true ]
                then
                    echo $tmp_dl
                else
                    echo $tmp_dl
                    curl -o $tmp_dl
            fi
        done
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
            fi
            if [ $C_RUNTIME = true ]
            # Runtime Binary Archives
            then                
                dl_runtime_binaries
            fi
    fi

    if [ $C_INSTALLER = true ]
        then
            if [ $C_SDK = true ]
            # SDK Installers
            then
                dl_sdk_installers
            fi
            if [ $C_RUNTIME = true ]
            # Runtime installers
            then
                dl_runtime_installers
                dl_host_installers
            fi
    fi
fi