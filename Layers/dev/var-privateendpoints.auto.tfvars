resource_group_name = "[__resource_group_name__]"

private_endpoints = {
  pe1 = {
    resource_name                 = "[__key_vault_name__]"
    name                          = "[__key_vault_name__]"
    subnet_id                     = "/subscriptions/[__subscription_id__]/resourceGroups/[__networking_resource_group_name__]/providers/Microsoft.Network/virtualNetworks/[__virtual_network_name__]/subnets/[__pe_snet_name__]"
    group_ids                     = ["vault"]
    approval_required             = false
    approval_message              = null
    dns_zone_names                = ["privatelink.vaultcore.azure.net"]
    dns_rg_name                   = null
    dns_zone_group_name           = "vault"
    private_connection_endpoint_id = "/subscriptions/[__subscription_id__]/resourceGroups/[__resource_group_name__]/providers/Microsoft.KeyVault/vaults/[__key_vault_name__]"
  },
  pe2 = {
    resource_name                 = "[__app_service_name__]"
    name                          = "[__app_service_name__]"
    subnet_id                     = "/subscriptions/[__subscription_id__]/resourceGroups/[__networking_resource_group_name__]/providers/Microsoft.Network/virtualNetworks/[__virtual_network_name__]/subnets/[__pe_snet_name__]"
    group_ids                     = ["sites"]
    approval_required             = false
    approval_message              = null
    dns_zone_names                = ["privatelink.azurewebsites.net"]
    dns_rg_name                   = null
    dns_zone_group_name           = "appsvdnszonerg"
    private_connection_endpoint_id = "/subscriptions/[__subscription_id__]/resourceGroups/[__resource_group_name__]/providers/Microsoft.Web/sites/[__app_service_name__]"
  },
  pe3 = {
    resource_name                 = "[__azsql_name__]"
    name                          = "[__azsql_name__]"
    subnet_id                     = "/subscriptions/[__subscription_id__]/resourceGroups/[__networking_resource_group_name__]/providers/Microsoft.Network/virtualNetworks/[__virtual_network_name__]/subnets/[__pe_snet_name__]"
    group_ids                     = ["SQLServer"]
    approval_required             = false
    approval_message              = null
    dns_zone_names                = ["privatelink.database.windows.net"]
    dns_rg_name                   = null
    dns_zone_group_name           = "sqlserver"
    private_connection_endpoint_id = "/subscriptions/[__subscription_id__]/resourceGroups/[__resource_group_name__]/providers/Microsoft.Sql/servers/[__azsql_name__]"
  },
  pe4 = {
    resource_name                 = "[__ampls_scope_name__]"
    name                          = "[__ampls_scope_name__]"
    subnet_id                     = "/subscriptions/[__subscription_id__]/resourceGroups/[__networking_resource_group_name__]/providers/Microsoft.Network/virtualNetworks/[__virtual_network_name__]/subnets/[__pe_snet_name__]"
    group_ids                     = ["azuremonitor"]
    approval_required             = false
    approval_message              = null
    dns_zone_names                = ["privatelink.monitor.azure.com", "privatelink.oms.opinsights.azure.com", "privatelink.ods.opinsights.azure.com", "privatelink.agentsvc.azure-automation.net"]
    dns_rg_name                   = null
    dns_zone_group_name           = "amplsdns"
    private_connection_endpoint_id = "/subscriptions/[__subscription_id__]/resourceGroups/[__resource_group_name__]/providers/Microsoft.insights/privateLinkScopes/[__ampls_scope_name__]"
  }
  pe5 = {
     resource_name                 = "[__acr_name__]"
     name                          = "[__acr_name__]-acr"
     subnet_id                     = "/subscriptions/[__subscription_id__]/resourceGroups/[__networking_resource_group_name__]/providers/Microsoft.Network/virtualNetworks/[__virtual_network_name__]/subnets/[__pe_snet_name__]"
     approval_required             = false
     approval_message              = null
     group_ids                     = ["registry"]
     dns_zone_names                = ["privatelink.azurecr.io"]
     dns_zone_group_name           = "registry"
     dns_rg_name                   = null
     private_connection_endpoint_id = "/subscriptions/[__subscription_id__]/resourceGroups/[__ado_resource_group_name__]/providers/Microsoft.ContainerRegistry/registries/[__acr_name__]"
   }
}

external_resource_ids = {}

app_service_additional_tags = {
  iac          = "Terraform"
  env          = "uat"
  automated_by = ""
}

////////////// ADO PE SHOULD BE IN ANOTHER LAYER EXECUTION OF THE SAME TYPE (IE: ADOPRIVATEENDPOINTS) /////////////////////

ado_resource_group_name = "[__ado_resource_group_name__]"
ado_vnet_name           = "[__ado_vnet_name__]"
ado_subnet_name         = "[__ado_pe_subnet_name__]"
ado_subscription_id     = "[__ado_subscription_id__]"

ado_private_endpoints = {}

ado_pe_additional_tags = {}
