

# resource "azurerm_network_security_group" "nsg" {
#   name                = var.nsg_name
#   location            = var.location
#   resource_group_name = var.rg_name

#   dynamic "security_rule" {
#     for_each = var.security_rules

#     content {
#       name                       = security_rule.value.name
#       priority                   = security_rule.value.priority
#       direction                  = security_rule.value.direction
#       access                     = security_rule.value.access
#       protocol                   = security_rule.value.protocol
#       source_port_range          = security_rule.value.source_port_range
#       destination_port_range     = security_rule.value.destination_port_range
#       source_address_prefix      = security_rule.value.source_address_prefix
#       destination_address_prefix = security_rule.value.destination_address_prefix
#     }
#   }
# }
resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.rg_name


  dynamic "security_rule" {
    for_each = var.security_rules

    content {
      name      = security_rule.value.name
      priority  = security_rule.value.priority
      direction = security_rule.value.direction
      access    = security_rule.value.access
      protocol  = security_rule.value.protocol

      description = lookup(security_rule.value, "description", null)

      source_port_range  = lookup(security_rule.value, "source_port_range", null)
      source_port_ranges = lookup(security_rule.value, "source_port_ranges", null)

      destination_port_range  = lookup(security_rule.value, "destination_port_range", null)
      destination_port_ranges = lookup(security_rule.value, "destination_port_ranges", null)

      source_address_prefix   = lookup(security_rule.value, "source_address_prefix", null)
      source_address_prefixes = lookup(security_rule.value, "source_address_prefixes", null)

      destination_address_prefix   = lookup(security_rule.value, "destination_address_prefix", null)
      destination_address_prefixes = lookup(security_rule.value, "destination_address_prefixes", null)

      source_application_security_group_ids      = lookup(security_rule.value, "source_application_security_group_ids", null)
      destination_application_security_group_ids = lookup(security_rule.value, "destination_application_security_group_ids", null)
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg_asso" {
  for_each = var.subnet_ids

  subnet_id                 = each.value
  network_security_group_id = azurerm_network_security_group.nsg.id
}
