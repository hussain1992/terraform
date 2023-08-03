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
