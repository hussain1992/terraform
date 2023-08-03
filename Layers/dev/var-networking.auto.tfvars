resource_group_name = "[__resource_group_name__]"
net_location        = null

virtual_networks = {
  virtualnetwork1 = {
    name                 = "[__virtual_network_name__]"
    address_space        = ["10.0.0.0/16"]
    dns_servers          = null
    ddos_protection_plan = null
  }
}

vnet_peering = {}

subnets = {
  subnet1 = {
    vnet_key          = "virtualnetwork1"
    vnet_name         = "[__virtual_network_name__]"
    name              = "appservice"
    address_prefixes  = ["10.0.5.0/24"]
    service_endpoints = ["Microsoft.AzureCosmosDB"]
    pe_enable         = false
    delegation = [
      {
        name = "appservice-delegation"
        service_delegation = [
          {
            name    = "Microsoft.Web/serverFarms"
            actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
          }
        ]
      }
    ]
  },
  subnet2 = {
    vnet_key          = "virtualnetwork1"
    vnet_name         = "[__virtual_network_name__]"
    name              = "[__pe_snet_name__]"
    address_prefixes  = ["10.0.6.0/24"]
    pe_enable         = true
    service_endpoints = null
    delegation        = []
  }
}

net_additional_tags = {
  iac          = "Terraform"
  env          = "uat"
  automated_by = ""
}