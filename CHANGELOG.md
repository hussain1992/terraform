# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [6.0.0] - 2022-05-22
- Versioning refresh - All 6.0 layers are compatible with 6.0 kits
- 6.0 kits support local automation scripts instead of packaged with layers individually
- Data blocks that can be replaced with a resource ID string have been replaced
- Added variable ado_agent_subnet_name to variables.dev.yaml
This was needed for some kits to successfully deploy storage accounts and containers.
[749262](https://dev.azure.com/ATTDevOps/ATT%20Cloud/_workitems/edit/749262/)

## [Unreleased] 2022-02-25
### Changed
Updated Log Analytics Workspace references to match across all layers and kits. The following are now in use:
log_analytics_workspace
log_analytics_workspace_id
log_analytics_workspace_rg
[#731894](https://dev.azure.com/ATTDevOps/ATT%20Cloud/_workitems/edit/731894/)

## [5.2.0] - 2022-01-21
- Add private endpoint and private DNS zone for ADO ACR
- Add ACR Pull Permissions to Appservice MSI

## [5.1.0] - 2022-01-21
- Add missing site_config settings
- Add default property acr_use_managed_identity_credentials to true to enforce secure connection
- Add default property vnet_route_all_enabled from appsettings into site_config

## [5.0.0] - 2022-01-21
- Versioning refresh - All Terraform 1.0 layers will be 5.x.x
- Redirected bash scripting mv and cp commands to dev/null and added verbose
- Skip detection text file logic removed for pipeline variable output
- Skip Plan option per layer
- Optional terraform binary path per layer
- Terraform Registry optional per layer
- Run pipeline as one job without TF plan (optional)
- Terraform debug set to false by default

## [unreleased] - 2022-01-27
### Added
- Added option to use Azure AD account for SQL server admin login
- [702914](https://dev.azure.com/ATTDevOps/ATT%20Cloud/_workitems/edit/702914/)

## [2.7.0] - 2021-08-17
### Changed
- Altered the qetza task root directory so that users would not have to edit Layers.yaml

## [2.6.0] - 2021-08-03
### Changed
- Changed the Variables yaml files, making some variables concatenated from other defined strings in order to match customer naming standards. Comments added to assist users in understanding what variables needed to be changed, with examples. Other kit functionality unchanged. 

### Added
- Added the ability to enable Terraform debugging [#668719](https://dev.azure.com/ATTDevOps/ATT%20Cloud/_workitems/edit/668719)

## [2.5.0] - 2021-06-01
### Changed
- Modified the provided keyvault auto.tfvars file to have an empty list for allowed networks rather than "any" (specified by 0.0.0.0/0). This change restricts access by default to only the PE. 

## [2.4.0] - 2021-04-26

### Changed
- Modified README.md to identify centralized tokenization and the variables users need to change before use


## [2.3.0] - 2020-03-10
- Added AMPLS layer to kit
## [2.2.0] - 2020-03-01

### Changed

- Code update in Jumpstart AppService Kit for new variables/tokens [#446690](https://dev.azure.com/ATTDevOps/ATT%20Cloud/_workitems/edit/446690)

## [2.1.0] - 2021-02-12

- The kit now supports the use of MSI or SPN for ADO agent pools, via the useMsi = true/false variable in Variables.yaml. The default and preferred choice is `true`. Note that the object id of the MSI is _required_ in the kevault tfvars file, as noted in the README and prior CHANGELOG.

## [2.0.0] - 2020-11-23

### Changed

The Kit and its layers now use MSI rather than SPN. Your ADO agent pool must have an MSI or the pipelines and layers will fail, complaining about authentication, missing service principal, etc.

SPN support is DISABLED in this version of the kit and the associated layers. (the variables are commented out and/or removed) If you wish to use SPN, use an earlier version of the kit or modify/customize the scripts and the layers.

## [1.5.0] - 2020-11-04

### Changed

- Dynamic Storage Account SAS Uri for App Service Backup [#224132](https://dev.azure.com/ATTDevOps/ATT%20Cloud/_workitems/edit/224132)
- Dynamic Storage Account SAS Uri for App Service Logs [#224133](https://dev.azure.com/ATTDevOps/ATT%20Cloud/_workitems/edit/224133)

## [1.4.0] - 2020-10-14

### Added

- Added ACR password to appservice settings.[#209347](https://dev.azure.com/ATTDevOps/06a79111-55ca-40be-b4ff-0982bd47e87c/_workitems/edit/209347)

## [1.3.0] - 2020-09-04

### Added

- Integration of Application insights with appservice. [#171827](https://dev.azure.com/ATTDevOps/06a79111-55ca-40be-b4ff-0982bd47e87c/_workitems/edit/171827)
- Intergation of keyvault with Appservice. [#171828](https://dev.azure.com/ATTDevOps/06a79111-55ca-40be-b4ff-0982bd47e87c/_workitems/edit/171828)
- Integration of VNET with App service slot. [#176163](https://dev.azure.com/ATTDevOps/06a79111-55ca-40be-b4ff-0982bd47e87c/_workitems/edit/176163)

## [1.0.0] - 2020-08-12

### Added

- Initial Commit and added Appservice JumpStart Kit to Stratum
