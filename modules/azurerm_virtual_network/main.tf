
# resource "azurerm_virtual_network" "vnet" {
#   for_each            = var.vnet
#   name                = each.value.name
#   location            = var.location
#   resource_group_name = var.rg_name
#   address_space       = each.value.address_space

# }

# resource "azurerm_virtual_network" "vnet" {
#   name                = var.vnet_name
#   location            = var.location
#   resource_group_name = var.rg_name
#   address_space       = var.address_space
# }

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.rg_name

  # REQUIRED (exactly one of address_space / ip_address_pool)
  address_space = var.address_space

  # OPTIONALS
  dns_servers                    = var.dns_servers
  edge_zone                      = var.edge_zone
  flow_timeout_in_minutes        = var.flow_timeout_in_minutes
  private_endpoint_vnet_policies = var.private_endpoint_vnet_policies


  # OPTIONAL: DDOS
  dynamic "ddos_protection_plan" {
    for_each = var.ddos_protection_plan == null ? [] : [var.ddos_protection_plan]
    content {
      id     = ddos_protection_plan.value.id
      enable = ddos_protection_plan.value.enable
    }
  }

  # OPTIONAL: ENCRYPTION
  dynamic "encryption" {
    for_each = var.encryption == null ? [] : [var.encryption]
    content {
      enforcement = encryption.value.enforcement
    }
  }
}
