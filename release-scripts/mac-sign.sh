# [x] download mac packages
# [x] zip them up for signing submission
# [ ] find out if there's an api to automate submission (Jacques mail from way back?)
# [ ] drive pkgutil to bulk validate
# [x] see help section below for usage details

clear

. ./release-versions.sh

TESTMODE="false"
C_ALL="true"
C_VERSION='20'
C_SDK='false'
C_RUNTIME='true'
C_CHECKSIG='false'
C_ZIP='false'
declare -a FILELIST
array_size=${#FILELIST[@]}

#### File name stubs for each component ####
SDK="dotnet-sdk"
RUNTIME_10="dotnet"
RUNTIME_20="dotnet-runtime"

while test $# -gt 0; do
    case "$1" in
        -h|--help)
            echo ""
            echo "Flags:"
            echo "  -h | --help ....... This message."
            echo "  -v | --version .... Version base to be downloaded [10, 11, 20]. Default is 20"
            echo "  -r | --runtime .... Runtime only will be downloaded."
            echo "  -s | --sdk ........ SDK only will be downloaded."
            echo "  -z | --zip ........ Create zip containing the pkg for PRSS signing submission."
            echo "  -c | --check ...... Check signatures of the pkg files."
            echo "  -t | --test ....... Test mode: text output only and no downloads initiated. Zips will be attempted."
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
        -c|--check)
            C_CHECKSIG='true'
            shift
            ;;
        -z|--zip)
            C_ZIP='true'
            shift
            ;;
        *)
            echo "Undefined parameter."
            exit 0
            ;;
    esac
done

function dl_runtime_installers()
{
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
    
    for i in "${runtime_installers[@]}"
    do
    :
        case "$C_VERSION" in
        10)
            tmp_dl=${RUNTIME_10}"-"${i}" "${BLOB_ROOT_RUNTIME}${VER_RUNTIME_10}"/"${RUNTIME_10}"-"${i}
            array_size=${#FILELIST[@]}
            FILELIST[$array_size]=${RUNTIME_10}"-"${i}
        ;;
        11)
            tmp_dl=${RUNTIME_10}"-"${i}" "${BLOB_ROOT_RUNTIME}${VER_RUNTIME_11}"/"${RUNTIME_10}"-"${i}
            array_size=${#FILELIST[@]}
            FILELIST[$array_size]=${RUNTIME_10}"-"${i}
        ;;
        20)
            tmp_dl=${RUNTIME_20}"-"${VER_RUNTIME_20}"-"${i}" "${BLOB_ROOT_RUNTIME}${VER_RUNTIME_20}"/"${RUNTIME_20}"-"${VER_RUNTIME_20}"-"${i}
            array_size=${#FILELIST[@]}
            FILELIST[$array_size]=${RUNTIME_20}"-"${VER_RUNTIME_20}"-"${i}
        ;;
        esac
        
        if [ $TESTMODE = true ]
            then
                echo $tmp_dl
            else
                echo "Downloading" $tmp_dl
                curl -# -o $tmp_dl
        fi
    done
}

function dl_sdk_installers()
{
    if [ $C_VERSION = "10" ] || [ $C_VERSION = "11" ]
    then
        declare -a sdk_installers=('osx-x64.'$VER_SDK_10'.pkg')
    fi
    if [ $C_VERSION = "20" ]
    then
        declare -a sdk_installers=('osx-x64.pkg')
    fi
        
    for i in "${sdk_installers[@]}"
        do
        :
        case "$C_VERSION" in
        10 | 11)
            tmp_dl=${SDK}"-"${i}" "${BLOB_ROOT_SDK}${VER_SDK_10}"/"${SDK}"-"${i}
            array_size=${#FILELIST[@]}
            FILELIST[$array_size]=${SDK}"-"${i}
        ;;
        20)
            tmp_dl=${SDK}"-"${VER_SDK_20}"-"${i}" "${BLOB_ROOT_SDK}${VER_SDK_20}"/"${SDK}"-"${VER_SDK_20}"-"${i}
            array_size=${#FILELIST[@]}
            FILELIST[$array_size]=${SDK}"-"${VER_SDK_20}"-"${i}
        ;;
        esac

        if [ $TESTMODE = true ]
            then
                echo $tmp_dl
            else
                echo "Downloading" $tmp_dl
                curl -# -o $tmp_dl
        fi
    done
}

function create_zips()
{
    for i in "${FILELIST[@]}"
    do
    :
            echo "zipping: "$i
            echo ""
            zipname=${i/pkg/zip}
            zip $zipname $i
    done
}

function check_signatures()
{
    for i in "${FILELIST[@]}"
    do
    :
        echo "checking: "$i
        echo ""
        pkgutil --check-signature $i
    done
}

### circuit breaker for parse testing
# exit 0  
####

if [ $C_ALL = true ]
    then
        dl_sdk_installers
        dl_runtime_installers
    elif [ $C_SDK = true ]
    then
        dl_sdk_installers
    elif [ $C_RUNTIME = true ]
    then
        dl_runtime_installers
fi

if [ $C_ZIP = 'true' ]
then
    create_zips
fi

if [ $C_CHECKSIG = 'true' ]
then
    check_signatures
fi