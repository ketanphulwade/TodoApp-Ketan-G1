data "azurerm_key_vault" "kv" {
  name                = var.vault_name
  resource_group_name = var.rg_name

}

data "azurerm_key_vault_secret" "sql_user" {
  name         = "sqlusername"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "sql_pass" {
  name         = "sqlpassword"
  key_vault_id = data.azurerm_key_vault.kv.id
}

