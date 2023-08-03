resource_group_name = "[__resource_group_name__]"

private_link_scoped_services = {
  ampls1 = {
    ampls_name          = "[__ampls_scope_name__]"    # user desired name for the ampls
    resource_group_name = "[__resource_group_name__]" # resource group in which this ampls is/will-be deployed
    linked_resources = {                              # list of monitoring resources that will be scoped/serviced by the ampls
      linked_resource1 = {
        linked_resource_name = "[__log_analytics_workspace__]"                                                                                                                                  # user desired name for the monitoring resource which will be linked to this ampls
        linked_resource_id   = "/subscriptions/[__subscription_id__]/resourceGroups/[__resource_group_name__]/providers/microsoft.operationalinsights/workspaces/[__log_analytics_workspace__]" # a monitoring resource ID such as the LAW or AapplicatonInsights resources
      }
    }
  }
}

private_link_scope_additional_tags = {}

