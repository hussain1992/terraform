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
    kitPath="kits/$basedOnStratumKitName/"
fi

ARM_SUBSCRIPTION_ID=$(az account show --query id --out tsv)
# if useMsi is set to true, terraform will use MSI rather than SPN. 
# Client ID and Client Secret variables are not needed when using MSI. 
# Use of MSI via this environment variable should override any terraform use of SPN.  
export ARM_USE_MSI=$useMsi

echo "Move layer TF variables to layer source"
if [[ $layerType == "none" ]];
then
  mv -v $kitPath/Infra-Code/* ./layer-$layerType 2> /dev/null
fi
mv -v $kitPath/Infra-Configuration/var-$layerName.auto.tfvars ./layer-$layerType 2> /dev/null
mv -v $kitPath/Layers/$environment/var-$layerName.tf ./layer-$layerType 2> /dev/null
mv -v $kitPath/Layers/$environment/var-$layerName.auto.tfvars ./layer-$layerType 2> /dev/null
mv -v $kitPath/Layers/$environment/var-$layerName-dependencies.tf ./layer-$layerType 2> /dev/null
mv -v $kitPath/Layers/$environment/$layerName.* ./layer-$layerType 2> /dev/null
mv -v $kitPath/Layers/$environment/$inputFile ./layer-$layerType 2> /dev/null

# For vm, vmss cloud inits or custom script extensions
if [[ -d "$kitPath/Layers/scripts" ]];
then
  echo "$kitPath/Layers/scripts exists on your filesystem."
  ls $kitPath/Layers/scripts

  #TODO - allow param for where the user wants to place this
  cp -v $kitPath/Layers/scripts/* ./layer-$layerType 2> /dev/null
fi

cd ./layer-$layerType
ls -Flah

if [[ $useMsi == "false" ]];
then
  echo "Terraform Init"
   ${providerPath}terraform init -input=false \
  -backend-config="resource_group_name=$backendResourceGroupName" \
  -backend-config="storage_account_name=$backendStorageAccountName" \
  -backend-config="container_name=$backendContainerName" \
  -backend-config="key=$layerName.tfstate" \
  -backend-config="subscription_id=$ARM_SUBSCRIPTION_ID" \
  -backend-config="tenant_id=$tenantId" \
  -backend-config="client_id=$servicePrincipalId" \
  -backend-config="client_secret=$servicePrincipalKey"
else
  echo "Terraform Init"
  ${providerPath}terraform init -input=false \
  -backend-config="resource_group_name=$backendResourceGroupName" \
  -backend-config="storage_account_name=$backendStorageAccountName" \
  -backend-config="container_name=$backendContainerName" \
  -backend-config="key=$layerName.tfstate" \
  -backend-config="subscription_id=$ARM_SUBSCRIPTION_ID" \
  -backend-config="tenant_id=$tenantId"
fi

${providerPath}terraform workspace new $environment 2> /dev/null
${providerPath}terraform workspace select $environment

pwd
ls -Flah

set -e

if [[ $layerDestroy == "False" ]];
then
  echo "Terraform Apply"
  if [[ $useMsi == "false" ]];
    then
      ${providerPath}terraform apply \
      -var="subscription_id=$ARM_SUBSCRIPTION_ID" \
      -var="tenant_id=$tenantId" -auto-approve \
      -var="client_id=$servicePrincipalId" \
      -var="client_secret=$servicePrincipalKey" 
    else
      ${providerPath}terraform apply \
      -var="subscription_id=$ARM_SUBSCRIPTION_ID" \
      -var="tenant_id=$tenantId" -auto-approve 
  fi
fi

if [[ $layerDestroy == "True" ]];
then
  echo "Terraform Destroy"
  if [[ $useMsi == "false" ]];
  then
    ${providerPath}terraform destroy \
    -var="subscription_id=$ARM_SUBSCRIPTION_ID" \
    -var="tenant_id=$tenantId" -auto-approve \
    -var="client_id=$servicePrincipalId" \
    -var="client_secret=$servicePrincipalKey" 
  else
    ${providerPath}terraform destroy \
    -var="subscription_id=$ARM_SUBSCRIPTION_ID" \
    -var="tenant_id=$tenantId" -auto-approve 
  fi
fi
