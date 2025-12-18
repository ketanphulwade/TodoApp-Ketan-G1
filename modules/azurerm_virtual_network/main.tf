
# resource "azurerm_virtual_network" "vnet" {
#   for_each            = var.vnet
#   name                = each.value.name
#   location            = var.location
#   resource_group_name = var.rg_name
#   address_space       = each.value.address_space

# }

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = var.address_space
}