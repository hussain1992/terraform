resource_group_name = "[__resource_group_name__]"

server_name                              = "[__azsql_name__]"
database_names                           = ["[__azsql_db_name__]"]
administrator_login_name                 = "dbadmin"
sku_name                                 = "BC_Gen5_2"
azuresql_version                         = "12.0"
assign_identity                          = true
assign_azuread_admin_login               = false # Set this to true to allow an Azure AD account for login
azuread_admin_login_username             = null  #(Required for AzureAD Admin) The login username of the Azure AD Administrator of this SQL Server.
azuread_admin_object_id                  = null  #(Required for AzureAD Admin) The object id of the Azure AD Administrator of this SQL Server.
azuread_authentication_only              = false #(Optional) Specifies whether only AD Users and administrators (like azuread_administrator.0.login_username) can be used to login or also local database users (like administrator_login).
max_size_gb                              = 4
elastic_pool_id                          = null
create_mode                              = null
creation_source_database_id              = null
restore_point_in_time                    = null
private_endpoint_connection_enabled      = true
read_write_endpoint_failover_policy_mode = null
auditing_storage_account_name            = null #"[__storage_account_name__]"
auditing_retention_in_days               = "14"
cmk_enabled_transparent_data_encryption  = false
license_type                             = "BasePrice" #"Specifies the license typr applied to this database. Choose LicenseIncluded if you need a license, and BasePrice if you have a license and are eligible for Azure Hybrid Benefit"

enable_failover_server          = false
failover_location               = null #"southcentralus"
geo_secondary_key_vault_rg_name = null #"jstart-vm-dev-secondary"
geo_secondary_key_vault_name    = null #"[__key_vault_name__]s"

key_vault_name = "[__key_vault_name__]"
key_vault_id   = "/subscriptions/[__subscription_id__]/resourceGroups/[__resource_group_name__]/providers/Microsoft.KeyVault/vaults/[__key_vault_name__]"

allowed_networks = [{
  subnet_id = "/subscriptions/[__subscription_id__]/resourceGroups/[__networking_resource_group_name__]/providers/Microsoft.Network/virtualNetworks/[__virtual_network_name__]/subnets/[__pe_snet_name__]"
}]

firewall_rules = {
  rule1 = {
    name             = "azuresql-firewall-rule-default"
    start_ip_address = "0.0.0.0"
    end_ip_address   = "0.0.0.0"
  }
}

azuresql_additional_tags = {
  iac          = "Terraform"
  env          = "uat"
  automated_by = ""
  pe_enable    = true
}
