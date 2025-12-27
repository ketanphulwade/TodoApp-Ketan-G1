
output "subnet_ids" {
  description = "Map of subnet IDs"
  value = {
    for k, v in azurerm_subnet.subnet :
    k => v.id
  }
}
