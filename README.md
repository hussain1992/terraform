# jumpstart-appservice

[[_TOC_]]

# Information on DevOps, JumpStart Kits, Onboarding, and FAQ can be found here: 
https://att.sharepoint.com/sites/PublicCloud/SitePages/Azure-DevOps.aspx
# Kit Description

For information on how to use Stratum-based kits, such as adding and removing layers, deploying multiple layers of the same resource type, composing custom layers, and more; see [Stratum Kits Wiki](https://dev.azure.com/ATTDevOps/ATT%20Cloud/_wiki/wikis/DevOps%20Automation/1467/Understand-layers-workflow).

using this jumpstartkit you can deploy

- Appservice.
- integrate your VNET with appservice.
- add custom host name binding to the app service.
- promote app service to slot.
- a pass database.

## This kit contains layers:

- Resource Group
- Virtual networks, subnets, network security groups
- appservice
- Log Analytics Workspace
- Storage account
- Key Vault
- Key Vault Diagnostics
- Application insights
- Azure SQL database
- Private endpoints
- Private DNS
- Private DNS A Records

# Pre-requisites

- Service connection to the ACC-Azure-00 Stratum artifact feed
  - Project Settings -> Service Connections -> New Service Connection -> Azure Repos/Team Foundation Server
  - Connection URL: https://dev.azure.com/ACC-Azure-00
  - Personal Access Token: Token with "Packaging Read" access
  - Service Connection Name: ACC-Azure-00 Stratum Feed
- Separate service connections to required subscriptions
- [DevOps Onboarding Services (contains storage account for state)](https://dev.azure.com/ATTDevOps/ATT%20Cloud/_git/att-onboarding-devops-services?path=%2FREADME.md&_a=preview)
- [Image Builder pipeline (if using custom images)](https://dev.azure.com/ATTDevOps/ATT%20Cloud/_git/jumpstart-image-builder-sig?path=%2FREADME.md&_a=preview)
- A container in the state storage account
- ADO agent MSI has storage account key operator role on the storage where state is saved

# Step-by-Step: Minimum variables to change to deploy

We have a centralized tokenization system to update most of the variables in one place (variables.dev.yaml). 
However, ideally all variable values in /layers/env should be reviewed to enusre they meet your application requirements. 
For example, a resource group is named in each layer and while it may not be required to deploy the kit, it is recommended to change the value. 
To deploy this kit on first attempt, the following minimum modifications are required:

## Preparing Kit

1. Download the kit version from the [artifact feed](https://dev.azure.com/ACC-Azure-00/Stratum). The download command will be on the overview page of the artifact you choose. You may need to set your proxy to use the CLI
   - set http_proxy=http://sub.proxy.att.com:8080
   - set https_proxy=http://sub.proxy.att.com:8080
   - set AZURE_CLI_DISABLE_CONNECTION_VERIFICATION=1
1. Create a repo for your application in your ADO organization
1. Add the Layers and Pipelines folders to your repo
1. Modify the files below

**NOTE: Only the kit must be downloaded. Layers do not need to be downloaded as they will be retrieved as your pipeline runs**

## Variables.yaml

1. motsId
1. agent_pool - Name of the ADO agent pool (see: pre-reqs)
1. projectName - Name of the ADO project for this deployment
1. pipelineId - The pipeline ID of image builder (if using IB)
1. artifactFeedCredentials - PAT based service connection name to the artifact feed (see: pre-reqs)
1. useMsi - true or false depending on whether you are using a managed identity for your ADO agent pool (true is preferred)
1. terraformDebug - true or false depending on whether you want to enable Terraform debugging
1. terraformDebugType - set to "TRACE" or left blank ("") depending on whether you want to enable Terraform debugging

## Variables.dev.yaml

1. serviceConnectionApp - Service connection name to dev subscription
1. backendResourceGroupName - Resource Group where storage account containing Terraform state resides
1. backendStorageAccountName - Storage account where Terraform state will reside
1. backendContainerName - Container name for Terraform state
1. Remove resources block where noted if not planning to use Image Builder on first deployment
6. **In the Jumstart Variables section (a comment line), the values below are assigned default vaules and will need to be updated before use:**
    1. resource_group_name - the name of the resource group for the layer deployment
    2. networking_resource_group_name - the name of the resource group where the networking piece will reside
    3. key_vault_name - the name of the key vault for the layer deployment
    4. msi_object_id - the id of the management identity
    5. storage_account_name - the name of the storage account that will be in use
    6. log_analytics_name - the name of the log analytics instance
    7. ado_resource_group_name - the name of the Azure DevOps resource group
    8. ado_vnet_name - the name of the Azure DevOps virtual network
    9. ado_subnet_name - the name of the Azure DevOps subnet
    10. ado_subscription_id - the id of the Azure DevOps subscription
    11. ado_key_vault_name - the name of the Azure DevOps key vault
    12. subscription_id - the id of the Azure subscription
    1.  tenant_id - the id of the Azure tenant

## Pipeline.dev.yaml

1. Remove resources block where noted if not planning to use Image Builder on first deployment

**It is recommended to "Find in files" for Layers/env and update all references for the files below. These instructions assume the centralized tokenization is working properly and does not identify all reference points for the variable changes**

## var-privateendpoints.auto.tfvars

1. private_endpoints.pe2.resource_name - Must match what was changed in var-keyvault.auto.tfvars
1. private_endpoints.pe3.resource_name - Must match what was changed in var-keyvault.auto.tfvars
1. private_endpoints.pe4.resource_name - Must match what was changed in var-keyvault.auto.tfvars

## var-azsql.auto.tfvars

1. server_name

# Adding and Removing Layers

## Adding

1. Identify the layer and version you wish to add
1. Add an object to the layer parameters in Pipeline.env.yaml
1. Use the examples auto.tfvars file included with the layer as a starting point
1. Name the auto.tfvars file the same as the layer name ie: var-<layername>.auto.tfvars

## Adding multiple layers of the same type

Multiple layers of the same type can be added by setting the layer name attributes in Pipeline.env.yaml. This example deploys two resource group layers with one network layer dependent. Note the dependencies for the networking (myrg1: resourcegrup). **When a layer has a custom name, there must be a matching variable file (var-myrg1.auto.tfvars instead of var-resourcegroup.auto.tfvars)**

    name: myrg1
    type: resourcegroup
    version: "0.0.1"
    skip: false
    dependencies:
      start: start

    name: myrg2
    type: resourcegroup
    version: "0.0.1"
    skip: false
    dependencies:
      start: start

    name: networking
    type: networking
    version: "0.0.1"
    skip: false
    dependencies:
      myrg1: resourcegroup

## Removing layers

1. Remove the reference from Pipeline.env.yaml
1. Delete the matching auto.tfvars file
   **Note: Removing a layer does not destroy the resource**

# Skipping Layers

There are two ways to skip layers. These exist to focus troubleshooting efforts.

## Setting skip: true

Each layer has a "skip: false" by default. When setting this to true, the stage will still run however Terraform will not execute. If skipping the first layer (usually resourcegroup), "start: start" must be placed in the first layer that is not skipped. Since resourcegroup is a fast layer and automatic skip detection will not attempt to apply, it is usually recommended to leave the first layer as skip: false.

## Automatic Skip Detection

When the Terraform plan stage does not detect any changes, the apply stage will not execute any Terraform commands. The stage will still run, however Terraform plan is skipped. This is not optional
