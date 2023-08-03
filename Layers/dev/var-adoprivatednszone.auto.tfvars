resource_group_name = "[__resource_group_name__]"

ado_resource_group_name = "[__ado_resource_group_name__]"
ado_vnet_name           = "[__ado_vnet_name__]"
ado_subnet_name         = "[__ado_agent_subnet_name__]"
ado_subscription_id     = "[__ado_subscription_id__]"

ado_private_dns_zones = {
  # adozone1 = {
  #   dns_zone_name = "privatelink.vaultcore.azure.net"
  # }
}

ado_private_dns_zone_links = {
  # adovnetlink1 = {
  #   link_name            = "first-vnet-link"
  #   dns_zone_key         = "adozone1"
  #   vnet_id              = "/subscriptions/[__ado_subscription_id__]/resourceGroups/[__ado_resource_group_name__]/providers/Microsoft.Network/virtualNetworks/[__ado_vnet_name__]"
  #   registration_enabled = false
  # }
}

////////////// NON ADO PDNS CAN BE CREATED HERE BUT SHOULD PROBABLY BE RUN IN A SEPARATE LAYER RUN IE: NAMED PRIVATEDNSZONE INSTEAD OF ADOPRIVATEDNSZONE/////////////////////

private_dns_zones = {}

dns_zone_additional_tags = {}
