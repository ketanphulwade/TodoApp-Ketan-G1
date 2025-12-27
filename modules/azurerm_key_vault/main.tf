data "azurerm_client_config" "current" {}

# resource "azurerm_key_vault" "kv" {
#   name                       = var.vault_name
#   location                   = var.location
#   resource_group_name        = var.rg_name
#   tenant_id                  = data.azurerm_client_config.current.tenant_id
#   sku_name                   = "standard"
#   soft_delete_retention_days = 7
#   purge_protection_enabled   = true
#   enable_rbac_authorization = false

# }

resource "azurerm_key_vault" "kv" {
  name                = var.vault_name
  location            = var.location
  resource_group_name = var.rg_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = var.sku_name

  soft_delete_retention_days = var.soft_delete_retention_days
  purge_protection_enabled   = var.purge_protection_enabled
  enable_rbac_authorization  = var.enable_rbac_authorization

  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment
  public_network_access_enabled   = var.public_network_access_enabled

  dynamic "network_acls" {
    for_each = var.network_acls == null ? [] : [var.network_acls]
    content {
      bypass                     = network_acls.value.bypass
      default_action             = network_acls.value.default_action
      ip_rules                   = lookup(network_acls.value, "ip_rules", null)
      virtual_network_subnet_ids = lookup(network_acls.value, "virtual_network_subnet_ids", null)
    }
  }
}


/*resource "azurerm_role_assignment" "kv_rbac" {
  scope                = azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = data.azurerm_client_config.current.object_id
}*/


resource "azurerm_key_vault_access_policy" "kv_access" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  secret_permissions = [
    "Get",
    "List",
    "Set",
    "Delete",
    "Recover",
    "Purge"
  ]
}

resource "azurerm_key_vault_secret" "vm_user" {
  depends_on   = [azurerm_key_vault_access_policy.kv_access]
  name         = "vmadminusername"
  value        = var.vm_username
  key_vault_id = azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "vm_pass" {

  depends_on   = [azurerm_key_vault_access_policy.kv_access]
  name         = "vmadminpassword"
  value        = var.vm_password
  key_vault_id = azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "sql_user" {

  depends_on   = [azurerm_key_vault_access_policy.kv_access]
  name         = "sqlusername"
  value        = var.sql_username
  key_vault_id = azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "sql_pass" {

  depends_on   = [azurerm_key_vault_access_policy.kv_access]
  name         = "sqlpassword"
  value        = var.sql_password
  key_vault_id = azurerm_key_vault.kv.id
}

# output "id" {
#   value = azurerm_key_vault.kv.id
# }