# download mac packages
# zip them up for signing submission
# find out if there's an api to automate submission (Jacques mail from way back?)
# drive pkgutil to bulk validate

TESTMODE="false"
C_ALL="true"
C_VERSION='00'
C_SDK='false'
C_RUNTIME='true'
declare -a FILELIST
array_size=${#FILELIST[@]}

### Versions ###
VER_SDK="1.1.4"
VER_RUNTIME_10="1.0.7"
VER_RUNTIME_11="1.1.4"

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

while test $# -gt 0; do
    case "$1" in
        -h|help)
            echo ""
            echo "Flags:"
            echo "  -a | --all ........ Default: All packages, all platforms, version 1.0 and 1.1. Providing any other flag will override."
            echo "  -r | --runtime .... Runtime only will be downloaded"
            echo "  -s | --sdk ........ SDK only will be downloaded"
            echo "  -t | --test ....... Test mode: text output only and no downloads initiated. Zips will be attempted."
            echo "  -v | --version .... Version base to be downloaded [10, 11]"
            echo " "
            echo "Usage examples:"
            echo "  ./mac-sign.sh ..... Downloads v1.0 and v1.1 Runtime and SDK and creates zips."
            echo " ./mac-sign.sh -v 10 .. Downloads v1.0 Runtime, associated SDK and creates zips."
            exit 0
            ;;
        -a|--all)
            C_ALL='true'
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
            declare -a runtime_installers=('osx-x64.'$VER_RUNTIME_10'.pkg')
            for i in "${runtime_installers[@]}"
            do
            :
                tmp_dl=${RUNTIME}"-"${i}" "${BLOB_ROOT_RUNTIME}${VER_RUNTIME_10}"/"${RUNTIME}"-"${i}
                array_size=${#FILELIST[@]}
                FILELIST[$array_size]=${RUNTIME}"-"${i}
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
        declare -a runtime_installers=('osx-x64.'$VER_RUNTIME_11'.pkg')
        for i in "${runtime_installers[@]}"
        do
        :
            tmp_dl=${RUNTIME}"-"${i}" "${BLOB_ROOT_RUNTIME}${VER_RUNTIME_11}"/"${RUNTIME}"-"${i}
            array_size=${#FILELIST[@]}
            FILELIST[$array_size]=${RUNTIME}"-"${i}
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

    declare -a sdk_installers=('osx-x64.'$VER_SDK'.pkg')
        
    for i in "${sdk_installers[@]}"
        do
        :
        tmp_dl=${SDK}"-"${i}" "${BLOB_ROOT_SDK}${VER_SDK}"/"${SDK}"-"${i}
        array_size=${#FILELIST[@]}
        FILELIST[$array_size]=${SDK}"-"${i}
        if [ $TESTMODE = true ]
            then
                echo $tmp_dl
            else
                curl -o $tmp_dl
        fi
    done
}

function create_zips()
{
    echo ""
    echo "Zipping pkg files in the current working directory ..."
    echo "${FILELIST[@]}"
    echo ""

    for i in "${FILELIST[@]}"
    do
    :
        echo "zipping: "$i
        zipname=${i/pkg/zip}
        zip $zipname $i
    done

}

### circuit breaker for parse testing
# exit 0  
####

if [ $C_ALL = true ]
    then
        echo ""
        echo "## Downloading all packages ... ##"
        echo ""
        dl_sdk_installers
        dl_runtime_installers
    elif [ $C_SDK = true ]
    then
        echo ""
        echo "## Downloading SDK ... ##"
        echo ""
        dl_sdk_installers
    elif [ $C_RUNTIME = true ]
    then
        echo ""
        echo "## Downloading Runtime ... ##"
        echo ""
        dl_runtime_installers
fi

create_zips