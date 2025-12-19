/*data "azurerm_virtual_network" "vnet" {
  name                = "todo-vnet"
  resource_group_name = var.rg_name
}

output "name" {
  value = azurerm_virtual_network.vnet.name
}

output "id" {
  value = azurerm_virtual_network.vnet.id
}*/
output "subnet_ids" {
  description = "Map of subnet IDs"
  value = {
    for k, v in azurerm_subnet.subnet :
    k => v.id
  }
}
