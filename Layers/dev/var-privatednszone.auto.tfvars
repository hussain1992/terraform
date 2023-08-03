resource_group_name = "[__resource_group_name__]"

private_dns_zones = {
  zone1 = {
    dns_zone_name = "privatelink.vaultcore.azure.net"
  }
  zone2 = {
    dns_zone_name = "privatelink.database.windows.net"
  }
  zone3 = {
    dns_zone_name = "privatelink.monitor.azure.com"
  }
  zone4 = {
    dns_zone_name = "privatelink.oms.opinsights.azure.com"
  }
  zone5 = {
    dns_zone_name = "privatelink.ods.opinsights.azure.com"
  }
  zone6 = {
    dns_zone_name = "privatelink.agentsvc.azure-automation.net"
  }
  zone7 = {
    dns_zone_name = "privatelink.azurecr.io"
  }
  zone8 = {
    dns_zone_name = "privatelink.azurewebsites.net"
  }
}

private_dns_zone_links = {
  vnetlink1 = {
    link_name            = "first-vnet-link"
    dns_zone_key         = "zone1"
    vnet_id              = "/subscriptions/[__subscription_id__]/resourceGroups/[__resource_group_name__]/providers/Microsoft.Network/virtualNetworks/[__virtual_network_name__]"
    registration_enabled = false
  }
  vnetlink2 = {
    link_name            = "first-vnet-link"
    dns_zone_key         = "zone2"
    vnet_id              = "/subscriptions/[__subscription_id__]/resourceGroups/[__resource_group_name__]/providers/Microsoft.Network/virtualNetworks/[__virtual_network_name__]"
    registration_enabled = false
  }
  vnetlink3 = {
    link_name            = "first-vnet-link"
    dns_zone_key         = "zone3"
    vnet_id              = "/subscriptions/[__subscription_id__]/resourceGroups/[__resource_group_name__]/providers/Microsoft.Network/virtualNetworks/[__virtual_network_name__]"
    registration_enabled = false
  }
  vnetlink4 = {
    link_name            = "first-vnet-link"
    dns_zone_key         = "zone4"
    vnet_id              = "/subscriptions/[__subscription_id__]/resourceGroups/[__resource_group_name__]/providers/Microsoft.Network/virtualNetworks/[__virtual_network_name__]"
    registration_enabled = false
  }
  vnetlink5 = {
    link_name            = "first-vnet-link"
    dns_zone_key         = "zone5"
    vnet_id              = "/subscriptions/[__subscription_id__]/resourceGroups/[__resource_group_name__]/providers/Microsoft.Network/virtualNetworks/[__virtual_network_name__]"
    registration_enabled = false
  }
  vnetlink6 = {
    link_name            = "first-vnet-link"
    dns_zone_key         = "zone6"
    vnet_id              = "/subscriptions/[__subscription_id__]/resourceGroups/[__resource_group_name__]/providers/Microsoft.Network/virtualNetworks/[__virtual_network_name__]"
    registration_enabled = false
  }
  vnetlink7 = {
    link_name            = "first-vnet-link"
    dns_zone_key         = "zone7"
    vnet_id              = "/subscriptions/[__subscription_id__]/resourceGroups/[__resource_group_name__]/providers/Microsoft.Network/virtualNetworks/[__virtual_network_name__]"
    registration_enabled = false
  }
  vnetlink8 = {
    link_name            = "first-vnet-link"
    dns_zone_key         = "zone8"
    vnet_id              = "/subscriptions/[__subscription_id__]/resourceGroups/[__resource_group_name__]/providers/Microsoft.Network/virtualNetworks/[__virtual_network_name__]"
    registration_enabled = false
  }
}

dns_zone_additional_tags = {
  iac          = "Terraform"
  env          = "uat"
  automated_by = ""
}

////////////// ADO PDNS CAN BE CREATED HERE BUT SHOULD PROBABLY BE RUN IN A SEPARATE LAYER RUN IE: NAMED ADOPRIVATEDNSZONE INSTEAD OF PRIVATEDNSZONE/////////////////////

ado_private_dns_zones = {}

ado_private_dns_zone_links = {}

ado_resource_group_name = "[__ado_resource_group_name__]"
ado_vnet_name           = "[__ado_vnet_name__]"
ado_subnet_name         = "[__ado_agent_subnet_name__]"
ado_subscription_id     = "[__ado_subscription_id__]"

ado_dns_zone_additional_tags = {
  iac = "Terraform"
  env = "[__env__]"
}
