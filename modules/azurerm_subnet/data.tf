data "azurerm_virtual_network" "vnet" {
  name                = "todo-vnet"
  resource_group_name = var.rg_name
}