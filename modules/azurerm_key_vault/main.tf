data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  name                       = var.vault_name
  location                   = var.location
  resource_group_name        = var.rg_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7
  purge_protection_enabled   = true
  
}

#resource "azurerm_role_assignment" "kv_rbac" {
#  scope                = azurerm_key_vault.kv.id
#  role_definition_name = "Key Vault Administrator"
#  principal_id         = data.azurerm_client_config.current.object_id
#}


resource "azurerm_key_vault_secret" "vm_user" {
#  depends_on   = [azurerm_role_assignment.kv_rbac]
  name         = "vmadminusername"
  value        = var.vm_username
  key_vault_id = azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "vm_pass" {

#  depends_on   = [azurerm_role_assignment.kv_rbac]
  name         = "vmadminpassword"
  value        = var.vm_password
  key_vault_id = azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "sql_user" {

#  depends_on   = [azurerm_role_assignment.kv_rbac]
  name         = "sqlusername"
  value        = var.sql_username
  key_vault_id = azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "sql_pass" {

#  depends_on   = [azurerm_role_assignment.kv_rbac]
  name         = "sqlpassword"
  value        = var.sql_password
  key_vault_id = azurerm_key_vault.kv.id
}

output "id" {
  value = azurerm_key_vault.kv.id
}