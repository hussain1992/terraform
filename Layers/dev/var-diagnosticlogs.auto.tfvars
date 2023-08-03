enable_kv_logs_to_log_analytics = true
enable_kv_logs_to_storage       = true
kv_logs                         = null # List of log categories
kv_metrics                      = null # List of metric categories

enable_aks_logs_to_log_analytics = false
enable_aks_logs_to_storage       = false
aks_logs                         = null # List of log categories
aks_metrics                      = null # List of metric categories

enable_appgw_logs_to_log_analytics = false
enable_appgw_logs_to_storage       = false
appgw_logs                         = null # List of log categories
appgw_metrics                      = null # List of metric categories

enable_cosmosdb_logs_to_log_analytics = false
enable_cosmosdb_logs_to_storage       = false
cosmosdb_logs                         = null # List of log categories
cosmosdb_metrics                      = null # List of metric categories

enable_mysql_logs_to_log_analytics = false
enable_mysql_logs_to_storage       = false
mysql_logs                         = null # List of log categories
mysql_metrics                      = null # List of metric categories

enable_appservice_logs_to_log_analytics = true
enable_appservice_logs_to_storage       = true
appservice_logs                         = [ "AppServiceAntivirusScanAuditLogs", "AppServiceAppLogs", "AppServiceAuditLogs", "AppServiceConsoleLogs", "AppServiceFileAuditLogs", "AppServiceHTTPLogs", "AppServiceIPSecAuditLogs", "AppServicePlatformLogs" ] # List of log categories
appservice_metrics                      = ["AllMetrics"] #null # List of metric categories

enable_azsql_logs_to_log_analytics = false
enable_azsql_logs_to_storage       = false
azsql_logs                         = null # List of log categories
azsql_metrics                      = null # List of metric categories

enable_postgresql_logs_to_log_analytics = false
enable_postgresql_logs_to_storage       = false
postgresql_logs                         = null # List of log categories
postgresql_metrics                      = null # List of metric categories

key_vault_id                     = "/subscriptions/[__subscription_id__]/resourceGroups/[__resource_group_name__]/providers/Microsoft.KeyVault/vaults/[__key_vault_name__]"
diagnostics_storage_account_name = "/subscriptions/[__subscription_id__]/resourceGroups/[__resource_group_name__]/providers/Microsoft.Storage/storageAccounts/[__storage_account_name__]"
log_analytics_workspace_id       = "/subscriptions/[__subscription_id__]/resourcegroups/[__resource_group_name__]/providers/microsoft.operationalinsights/workspaces/[__log_analytics_workspace__]"
aks_cluster_id                   = {}
app_gateway_id                   = null #{app_gateway_id = "/subscriptions/[__subscription_id__]/resourceGroups/[__resource_group_name__]/providers/Microsoft.Network/applicationGateways/[__application_gateway_name__]"}
cosmosdb_id                      = null
mysql_server_id                  = null
app_service_id                   = {app_service_id1="/subscriptions/[__subscription_id__]/resourceGroups/[__resource_group_name__]/providers/Microsoft.Web/sites/[__app_service_name__]"}
azuresql_databases_id            = null #{azuresql_databases_id = "/subscriptions/[__subscription_id__]/resourceGroups/[__resource_group_name__]/providers/Microsoft.Sql/servers/[__azql_server_name__]/databases/azuresqldba"}
postgresql_id                    = {}
mariadb_server_id                = null
# custom_diagnostic_settings = {
#   log1 = {
#     name           = "customkvlog"
#     resource_id    = "/subscriptions/[__subscription_id__]/resourceGroups/[__resource_group_name__]/providers/Microsoft.KeyVault/vaults/[__key_vault_name__]"
#     enabled        = true
#     retention_days = 0
#     logs           = null
#     metrics        = null
#   }
# }
