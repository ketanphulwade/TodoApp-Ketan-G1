
resource "azurerm_subnet" "subnet" {
  for_each             = var.subnet
  name                 = each.value.name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  address_prefixes     = each.value.address_prefixes
  resource_group_name  = var.rg_name
}

