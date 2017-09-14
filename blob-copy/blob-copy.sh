


# -----------------------------------------------------------------------# 
VER_SDK="1.1.4"
VER_FX_10="1.0.4"
VER_FX_11="1.1.4"
TMP_EXPLODE="tmp-explode-"$VER_FX_11
TMP_ZIP="tmp-zip-"$VER_FX_11 
BLOB_SOURCE_SDK="https://dotnetcli.blob.core.windows.net/licavalc/Sdk/"$VER_SDK"/"
BLOB_SOURCE_FX_10_INSTALLERS="https://dotnetcli.blob.core.windows.net/dotnet/preview/Installers/"$VER_FX_10"/"
BLOB_SOURCE_FX_10_BINARIES="https://dotnetcli.blob.core.windows.net/dotnet/preview/BINARIES/"$VER_FX_10"/"
BLOB_SOURCE_FX_11_INSTALLERS="https://dotnetcli.blob.core.windows.net/dotnet/release/1.1.0/Installers/"$VER_FX_11"/"
BLOB_SOURCE_FX_11_BINARIES="https://dotnetcli.blob.core.windows.net/dotnet/release/1.1.0/BINARIES/"$VER_FX_11"/"

BLOB_TARGET_SDK="https://dotnetcli.blob.core.windows.net/dotnet/Sdk/"$VER_SDK"/"
BLOB_TARGET_FX_10="https://dotnetcli.blob.core.windows.net/dotnet/Runtime/"$VER_FX_10"/"
BLOB_TARGET_FX_11="https://dotnetcli.blob.core.windows.net/dotnet/Runtime/"$VER_FX_11"/"

# Clean the working directories
if [ -d $TMP_ZIP ]; then
  rm -r $TMP_ZIP
fi
if [ -d $TMP_EXPLODE ]; then
  rm -r $TMP_EXPLODE
fi

# Download
mkdir $TMP_ZIP
curl -sSL -o $TMP_ZIP/$SOURCE_SDK $BLOB_LOCATION$SOURCE_SDK

# Upload - probably need to worry about perms here


# Cleanup
cd ..
rm -r $TMP_EXPLODE