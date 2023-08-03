resource_group_name = "[__resource_group_name__]"

application_insights_name = "[__appinsights_name__]"
ado_resource_group_name   = "[__ado_resource_group_name__]" # set this to null if you don't want to use key vault secret in app settings
ado_key_vault_name        = "[__ado_key_vault_name__]"      # set this to null if you don't want to use key vault secret in app settings
key_vault_id              = "/subscriptions/[__ado_subscription_id__]/resourceGroups/[__ado_resource_group_name__]/providers/Microsoft.KeyVault/vaults/[__ado_key_vault_name__]"
key_vault_secret_name     = null # set this to null if you don't want to use key vault secret in app settings
ado_subscription_id       = null
acr_secret_name           = null

app_services = {
  as1 = {
    name                 = "[__app_service_name__]"
    app_service_plan_key = "asp1"
    app_settings = {
      "WEBSITE_DNS_SERVER"                  = "168.63.129.16"
      "WEBSITE_PORT"                        = "80"
      "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
      #"DOCKER_REGISTRY_SERVER_URL"      = "https://appsvtest2020.azurecr.io"
      #"DOCKER_REGISTRY_SERVER_USERNAME" = "appsvtest2020"
    }
    client_affinity_enabled = null
    client_cert_enabled     = null
    enabled                 = null
    https_only              = null
    assign_identity         = true
    enable_monitoring       = true
    add_key_vault_secret    = false
    auth_settings           = null
    storage_accounts        = null
    connection_strings      = null
    site_config = {
      always_on                            = null
      app_command_line                     = null
      default_documents                    = null
      dotnet_framework_version             = null
      ftps_state                           = null
      http2_enabled                        = null
      java_version                         = null
      java_container                       = null
      java_container_version               = null
      local_mysql_enabled                  = null
      linux_fx_version                     = null
      linux_fx_version_local_file_path     = null
      windows_fx_version                   = null
      managed_pipeline_mode                = null
      min_tls_version                      = null
      php_version                          = null
      python_version                       = null
      remote_debugging_enabled             = null
      remote_debugging_version             = null
      scm_type                             = null
      scm_use_main_ip_restriction          = false
      use_32_bit_worker_process            = null
      websockets_enabled                   = null
      cors                                 = null
      ip_restriction                       = null
      acr_use_managed_identity_credentials = true
      vnet_route_all_enabled               = true
    }
    logs = null
    backup = {
      name                 = "appservicebackup"
      enabled              = true
      storage_account_name = "[__storage_account_name__]"
      container_name       = "backupcontainer"
      schedule = {
        frequency_interval       = 1
        frequency_unit           = "Day"
        keep_at_least_one_backup = true
        retention_period_in_days = 30
        start_time               = null
      }
    }
    logs = {
      application_logs = {
        azure_blob_storage = {
          level                = "Information"
          storage_account_name = "[__storage_account_name__]"
          container_name       = "logs"
          retention_in_days    = 5
        }
      }
      http_logs = {
        file_system = null
        azure_blob_storage = {
          storage_account_name = "[__storage_account_name__]"
          container_name       = "logs"
          retention_in_days    = 5
        }
      }
    }
  }
}

app_service_plans = {
  asp1 = {
    name                         = "jstartapps080321asp"
    kind                         = "Linux"
    reserved                     = true
    per_site_scaling             = false
    maximum_elastic_worker_count = 2
    sku_tier                     = "Premium"
    sku_size                     = "P1V2"
    sku_capacity                 = 1
    zone_redundant               = false
  }
}

app_service_additional_tags = {
  iac          = "Terraform"
  env          = "uat"
  automated_by = ""
  pe_enable    = true
}

vnet_swift_connection = {
  connection1 = {
    app_service_key = "as1"
    subnet_id       = "/subscriptions/[__subscription_id__]/resourceGroups/[__networking_resource_group_name__]/providers/Microsoft.Network/virtualNetworks/[__virtual_network_name__]/subnets/appservice"
  }
}

app_service_slot = {
  slot1 = {
    name                 = "appsvcslot-080321"
    app_service_plan_key = "asp1"
    app_service_key      = "as1"
  }
}

appsvc_slot_vnet_integration = {
  integration1 = {
    appsvc_slot_key = "slot1"
    app_service_key = "as1"
    subnet_id       = "/subscriptions/[__subscription_id__]/resourceGroups/[__networking_resource_group_name__]/providers/Microsoft.Network/virtualNetworks/[__virtual_network_name__]/subnets/appservice"
  }
}

app_service_certificate = {
  # cert1 = {
  #  key_vault_secret_name = "appgwclientcert"
  #  certificate_name      = "appgwclientcert"
  #  app_service_key       = "as1" 
  # }
}

app_service_acr_pull = {
  acr1 = {
    acr_id          = "/subscriptions/[__ado_subscription_id__]/resourceGroups/[__ado_resource_group_name__]/providers/Microsoft.ContainerRegistry/registries/[__acr_name__]"
    app_service_key = "as1"
  }
}

custom_hostname_bindings = {
  # binding2 = {
  #  kv_cert_name = "appgwclientcert"
  #  hostname     = "testnew.azurewebsites.net"
  #  app_service_key = "as1"
  #  ssl_state       = "SniEnabled"
  # }
}

