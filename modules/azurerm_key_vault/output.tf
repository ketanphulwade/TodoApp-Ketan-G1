output "vm_admin_username" {
  value     = azurerm_key_vault_secret.vm_user.value
  sensitive = true
}

output "vm_admin_password" {
  value     = azurerm_key_vault_secret.vm_pass.value
  sensitive = true
}
output "kv_id" {
  value = azurerm_key_vault.kv.id
}
