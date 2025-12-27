
# resource "azurerm_subnet" "subnet" {
#   for_each             = var.subnet
#   name                 = each.value.name
#   virtual_network_name = var.vnet_name
#   address_prefixes     = each.value.address_prefixes
#   resource_group_name  = var.rg_name
# }
resource "azurerm_subnet" "subnet" {
  for_each = var.subnet

  name                 = each.value.name
  resource_group_name  = var.rg_name
  virtual_network_name = var.vnet_name

  # Exactly one of these
  address_prefixes = each.value.address_prefixes

  # dynamic "ip_address_pool" {
  #   for_each = lookup(each.value, "ip_address_pool", null) == null ? [] : [each.value.ip_address_pool]
  #   content {
  #     id                    = ip_address_pool.value.id
  #     number_of_ip_addresses = ip_address_pool.value.number_of_ip_addresses
  #   }
  # }

  # -------- OPTIONAL --------
  service_endpoints = lookup(each.value, "service_endpoints", null)

  service_endpoint_policy_ids = lookup(each.value, "service_endpoint_policy_ids", null)

  default_outbound_access_enabled = lookup(each.value, "default_outbound_access_enabled", null)

  private_endpoint_network_policies = lookup(each.value, "private_endpoint_network_policies", null)

  private_link_service_network_policies_enabled = lookup(each.value, "private_link_service_network_policies_enabled", null)



  # -------- DELEGATION --------
  dynamic "delegation" {
    for_each = each.value.delegation == null ? [] : each.value.delegation
    content {
      name = delegation.value.name

      service_delegation {
        name    = delegation.value.service_delegation.name
        actions = lookup(delegation.value.service_delegation, "actions", null)
      }
    }
  }
}

