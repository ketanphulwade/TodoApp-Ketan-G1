resource "azurerm_public_ip" "pip" {

  for_each            = var.public_ip
  name                = each.value.name
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = each.value.allocation_method

}

