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

if [[ $buildRepositoryName = "Stratum" ]];
then
    echo "Working directory kits/$basedOnStratumKitName because running from Stratum"
    kitPath="kits/$basedOnStratumKitName"
fi

ARM_SUBSCRIPTION_ID=$(az account show --query id --out tsv)
# if useMsi is set to true, terraform will use MSI rather than SPN. 
# Client ID and Client Secret variables are not needed when using MSI. 
# Use of MSI via this environment variable should override any terraform use of SPN.  
export ARM_USE_MSI=$useMsi

set +e

if [[ $(az group exists -n $backendResourceGroupName -o tsv) = false ]];
then
    echo "$backendResourceGroupName RG was not found. Please ensure the base infrastructure pipeline ran successfully and try again"
    exit -1
else
    echo "Using resource group $backendResourceGroupName"
fi
az storage account show -n $backendStorageAccountName -g $backendResourceGroupName &> /dev/null
set -e
if [[ $? -eq 0 ]];
then
    echo "Using storage account $backendStorageAccountName in resource group $backendResourceGroupName"
else
    echo "$backendStorageAccountName storage account in resource group $backendResourceGroupName was not found."
    exit -1
fi
az storage container create --name $backendContainerName --account-name $backendStorageAccountName 