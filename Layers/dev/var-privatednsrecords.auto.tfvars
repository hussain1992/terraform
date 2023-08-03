# Most dns records are created in the privateendpoints layer using dns zone groups
# A common use for this layer is to create a DNS record for a private link service attached to a PE

resource_group_name = "[__resource_group_name__]"

dns_a_records = {
  # arecord1 = {
  #   a_record_name         = "sample_record"            # <"dns_a_record_name">
  #   dns_zone_name         = "svc.local"                # <"dns_zone_name">
  #   ttl                   = 300                        # <time_to_live_of_the_dns_record_in_seconds>
  #   ip_addresses          = null                       # <list_of_ipv4_addresses>
  #   private_endpoint_name = "sample_pls"               # <"name of private endpoint for which DNSARecord to be created"
  # }
}

dns_records_additional_tags = {
  iac          = "Terraform"
  env          = "[__env__]"
  automated_by = "[__automated_by__]"
}