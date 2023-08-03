ado_resource_group_name = "[__ado_resource_group_name__]"
ado_vnet_name           = "[__ado_vnet_name__]"
ado_subnet_name         = "[__ado_pe_subnet_name__]"
ado_subscription_id     = "[__ado_subscription_id__]"

ado_private_endpoints = {
  ape1 = {
    resource_name                 = "[__app_service_name__]"
    name                          = "[__app_service_name__]"
    subnet_id                     = "/subscriptions/[__ado_subscription_id__]/resourceGroups/[__ado_resource_group_name__]/providers/Microsoft.Network/virtualNetworks/[__ado_vnet_name__]/subnets/[__ado_pe_subnet_name__]"
    group_ids                     = ["sites"]
    approval_required             = false
    approval_message              = null
    dns_zone_names                = ["privatelink.azurewebsites.net"]
    dns_rg_name                   = null
    dns_zone_group_name           = "adodnszonerg"
    private_connection_endpoint_id = "/subscriptions/[__subscription_id__]/resourceGroups/[__resource_group_name__]/providers/Microsoft.Web/sites/[__app_service_name__]"
  }
}

ado_pe_additional_tags = {
  iac          = "Terraform"
  env          = "[__env__]"
  automated_by = "[__automated_by__]"
}

////////////// NON ADO PE CAN BE CREATED HERE BUT SHOULD PROBABLY BE RUN IN A SEPARATE LAYER RUN IE: NAMED PRIVATEENDPOINTS INSTEAD OF ADOPRIVATEENDPOINTS/////////////////////

resource_group_name = "[__resource_group_name__]"

private_endpoints = {}

external_resource_ids = {}

pe_additional_tags = {}