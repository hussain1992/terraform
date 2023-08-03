while [ $# -gt 0 ]; do
  case "$1" in
      layerName=*)
      layerName="${1#*=}"
      ;;

      environment=*)
      environment="${1#*=}"
      ;;

      backendResourceGroupName=*)
      backendResourceGroupName="${1#*=}"
      ;;

      backendStorageAccountName=*)
      backendStorageAccountName="${1#*=}"
      ;;

      backendContainerName=*)
      backendContainerName="${1#*=}"
      ;;

      buildRepositoryName=*)
      buildRepositoryName="${1#*=}"
      ;;

      basedOnStratumKitName=*)
      basedOnStratumKitName="${1#*=}"
      ;;

      layerType=*)
      layerType="${1#*=}"
      ;;

      layerDestroy=*)
      layerDestroy="${1#*=}"
      ;;

      kitPath=*)
      kitPath="${1#*=}"
      ;;

      provider=*)
      provider="${1#*=}"
      ;;

      useMsi=*)
      useMsi="${1#*=}"
      ;;

      inputFile=*)
      inputFile="${1#*=}"
      ;;

      providerPath=*)
      providerPath="${1#*=}"
      ;;
    *)
      echo "***************************"
      echo "* Invalid argument:"
      echo "* ($1)"
      echo "***************************"
      exit 1
  esac
  shift
done

if [ -z "$kitPath" ]
then
      kitPath="."
fi

echo "layerName:" $layerName
echo "environment:" $environment
echo "backendResourceGroupName:" $backendResourceGroupName
echo "backendStorageAccountName:" $backendStorageAccountName
echo "backendContainerName:" $backendContainerName
echo "buildRepositoryName:" $buildRepositoryName
echo "basedOnStratumKitName:" $basedOnStratumKitName
echo "layerType:" $layerType
echo "layerDestroy:" $layerDestroy
echo "kitPath:" $kitPath
echo "provider:" $provider
echo "inputFile:" $inputFile
echo "useMsi:" $useMsi
echo "providerPath:" $providerPath

if [[ $buildRepositoryName == "Stratum" ]];
then
    echo "Working directory kits/$basedOnStratumKitName because running from Stratum"
    kitPath="kits/$basedOnStratumKitName"
fi

ARM_SUBSCRIPTION_ID=$(az account show --query id --out tsv)

echo "Move layer files to layer source"
mv $kitPath/Layers/$environment/var-$layerName.* ./layer-$layerType
mv $kitPath/Layers/$environment/$layerName.* ./layer-$layerType
mv $kitPath/Layers/$environment/$inputFile ./layer-$layerType

cd ./layer-$layerType
ls -Flah

chmod +x $inputFile
chmod +x main.apply.sh
./main.apply.sh layerName=$layerName environment=$environment backendResourceGroupName=$backendResourceGroupName backendStorageAccountName=$backendStorageAccountName backendContainerName=$backendContainerName buildRepositoryName=$buildRepositoryName basedOnStratumKitName=$basedOnStratumKitName layerType=$layerType layerDestroy=$layerDestroy kitPath=$kitPath provider=$layerProvider useMsi=$useMsi inputFile=$inputFile providerPath=$providerPath

if [[ $detailedExitCode = 0 ]];
then
  echo "No changes detected. Skipping apply"
  echo True > $BUILD_ARTIFACTSTAGINGDIRECTORY/skip.txt
else
  echo "Changes detected. Continuing with apply"
  echo False > $BUILD_ARTIFACTSTAGINGDIRECTORY/skip.txt
fi