resource_group_name = "[__resource_group_name__]"

storage_accounts = {
  sa1 = {
    name                     = "[__storage_account_name__]"
    sku                      = "Standard_LRS"
    account_kind             = null
    access_tier              = null
    assign_identity          = true
    cmk_enable               = true
    min_tls_version          = "TLS1_2"
    large_file_share_enabled = true
    is_hns_enabled           = true
    network_rules = {
      bypass                     = ["None"]
      default_action             = "Deny"
      ip_rules                   = null
      virtual_network_subnet_ids = ["/subscriptions/[__ado_subscription_id__]/resourceGroups/[__ado_resource_group_name__]/providers/Microsoft.Network/virtualNetworks/[__ado_vnet_name__]/subnets/[__ado_agent_subnet_name__]"]
    }
  }
}

containers = {
  container1 = {
    name                  = "backupcontainer"
    storage_account_name  = "[__storage_account_name__]"
    container_access_type = null
  }
}


ado_resource_group_name = "[__ado_resource_group_name__]"
ado_vnet_name           = "[__ado_vnet_name__]"
ado_subnet_name         = "[__ado_agent_subnet_name__]"
ado_subscription_id     = "[__ado_subscription_id__]"
ado_subnet_id           = "/subscriptions/[__ado_subscription_id__]/resourceGroups/[__ado_resource_group_name__]/providers/Microsoft.Network/virtualNetworks/[__ado_vnet_name__]/subnets/[__ado_agent_subnet_name__]"
key_vault_name          = "[__key_vault_name__]"
key_vault_id            = "/subscriptions/[__subscription_id__]/resourceGroups/[__resource_group_name__]/providers/Microsoft.KeyVault/vaults/[__key_vault_name__]"

sa_additional_tags = {
  iac          = "Terraform"
  env          = "[__env__]"
  automated_by = "[__automated_by__]"
}
