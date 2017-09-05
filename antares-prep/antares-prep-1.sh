
# Rapid Update zip spec
# | Directory         | Description                                                | Antares Zip |
# | --                | --                                                         | -- |
# | additionalDeps    | ASP.NET Core deps files for App Services and App Insights  | included in the store package |
# | dotnet            | dotnet.exe                                                 | dotnet-host-[version]-antares-win-x86.zip |
# | hostfxr           | Runtime binding policy                                     | dotnet-hostfxr-[version]-antares-win-x86.zip |
# | sdk               | Versioned directories containing the SDK                   | dotnet-sdk-[version]-antares-win-x86.zip |
# | shared            | Versioned directories containing the Shared Framework      | dotnet-runtime-[version]-antares-win-x86.zip |
# | store             | Runtime package store                                      | aspnetcore-store-[version]-antares-win-x86.zip |


# -----------------------------------------------------------------------# 
VER_SDK="1.0.4"
VER_FX="1.0.5"
TMP_EXPLODE="tmp-explode-"$VER_FX
TMP_ZIP="tmp-zip-"$VER_FX 
BLOB_LOCATION="https://dotnetcli.blob.core.windows.net/dotnet/Sdk/"$VER_SDK"/"

ANT_SUFFIX="-antares-win-x86.zip"

# ----------- 1.x filenames ------------- #
SOURCE_SDK="dotnet-dev-win-x86."$VER_SDK".zip"

DOTNET="dotnet-host-"$VER_FX$ANT_SUFFIX
HOSTFXR="dotnet-hostfxr-"$VER_FX$ANT_SUFFIX
SDK="dotnet-sdk-"$VER_SDK$ANT_SUFFIX
SHARED="dotnet-runtime-"$VER_FX$ANT_SUFFIX

# Clean the working directories
if [ -d $TMP_ZIP ]; then
  rm -r $TMP_ZIP
fi
if [ -d $TMP_EXPLODE ]; then
  rm -r $TMP_EXPLODE
fi

# Download and explode
mkdir $TMP_ZIP
curl -sSL -o $TMP_ZIP/$SOURCE_SDK $BLOB_LOCATION$SOURCE_SDK
mkdir $TMP_EXPLODE
unzip $TMP_ZIP/$SOURCE_SDK -d $TMP_EXPLODE

# Make zips
cd $TMP_EXPLODE
printf "Creating: "$DOTNET"\n\n" > ../$TMP_ZIP/antares-prep.log
zip  ../$TMP_ZIP/$DOTNET dotnet.exe >> ../$TMP_ZIP/antares-prep.log
printf "\nCreating: "$HOSTFXR"\n\n" >> ../$TMP_ZIP/antares-prep.log
zip -r ../$TMP_ZIP/$HOSTFXR host >> ../$TMP_ZIP/antares-prep.log
printf "\nCreating: "$SHARED"\n\n" >> ../$TMP_ZIP/antares-prep.log
zip -r ../$TMP_ZIP/$SHARED shared >> ../$TMP_ZIP/antares-prep.log
printf "\nCreating: "$SDK"\n\n" >> ../$TMP_ZIP/antares-prep.log
zip -r ../$TMP_ZIP/$SDK sdk >> ../$TMP_ZIP/antares-prep.log

# Cleanup
cd ..
rm -r $TMP_EXPLODE