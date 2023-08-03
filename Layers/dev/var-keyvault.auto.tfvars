resource_group_name = "[__resource_group_name__]"
tenantId            = "[__tenant_id__]"

name                            = "[__key_vault_name__]"
enabled_for_deployment          = null
enabled_for_disk_encryption     = null
enabled_for_template_deployment = null
soft_delete_enabled             = true
purge_protection_enabled        = true
sku_name                        = "standard"
secrets                         = {}
access_policies = {
  "accp1" = {
    group_names             = []
    user_principal_names    = []
    object_ids              = ["[__msi_object_id__]"]
    certificate_permissions = ["managecontacts"]
    key_permissions         = []
    secret_permissions      = []
    storage_permissions     = []
  }
}

network_acls = {
  bypass                     = "AzureServices"
  default_action             = "Deny"
  ip_rules                   = []
  virtual_network_subnet_ids = ["/subscriptions/[__ado_subscription_id__]/resourceGroups/[__ado_resource_group_name__]/providers/Microsoft.Network/virtualNetworks/[__ado_vnet_name__]/subnets/[__ado_agent_subnet_name__]"]
}
contact_details = {
  "con1" = {
    email = "test30@att.com"
    name  = "Test30"
    phone = "0000000000"
  }
  "con2" = {
    email = "test31@att.com"
    name  = "Test31"
    phone = "11111111111"
  }
}

# The value below is REQUIRED when using MSI rather than SPN. 
msi_object_id = "[__msi_object_id__]"

kv_additional_tags = {
  iac          = "Terraform"
  env          = "[__env__]"
  automated_by = "[__automated_by__]"
}
