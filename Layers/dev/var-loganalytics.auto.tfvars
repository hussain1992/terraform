resource_group_name = "[__resource_group_name__]"

name              = "[__log_analytics_workspace__]"
sku               = "PerGB2018"
retention_in_days = 30
key_vault_name    = "[__key_vault_name__]"

log_analytics_additional_tags = {
  iac          = "Terraform"
  env          = "uat"
  automated_by = ""
}
