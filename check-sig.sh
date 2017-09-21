while test $# -gt 0; do
    case "$1" in
        -h|help)
            echo ""
            echo "Checks for the existence of a signature for all files in the current directory."
            echo "-------------------------------------------------------------------------------"
            echo "Usage:"
            echo "  ./check-sig [mac | rpm | deb]"
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


case "$1" in
  mac)
    for f in *.pkg
    do
      echo "Checking "$f "..."
      pkgutil --check-signature $f
    done
  ;;
  rpm)
    for f in *.rpm
    do
      echo "Checking "$f "..."
      rpm -K $f
    done
  ;;
  deb)
    for f in *.deb
    do
      echo "Checking "$f "..."
      dpkg-sig -c $f
    done
  ;;
esac



