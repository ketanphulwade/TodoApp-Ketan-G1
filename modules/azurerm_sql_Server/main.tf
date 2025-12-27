

# resource "azurerm_mssql_server" "sqlserver" {
#   name                         = var.sql_server_name
#   resource_group_name          = var.rg_name
#   location                     = var.location
#   version                      = "12.0"
#   administrator_login          = data.azurerm_key_vault_secret.sql_user.value
#   administrator_login_password = data.azurerm_key_vault_secret.sql_pass.value
# }

# resource "azurerm_mssql_firewall_rule" "allow_all_ips" {
#   name             = "AllowAllIPs"
#   server_id        = azurerm_mssql_server.sqlserver.id
#   start_ip_address = "0.0.0.0"
#   end_ip_address   = "255.255.255.255"
# }

resource "azurerm_mssql_server" "sqlserver" {
  name                = var.sql_server_name
  resource_group_name = var.rg_name
  location            = var.location
  version             = var.sql_server_version

  administrator_login          = data.azurerm_key_vault_secret.sql_user.value
  administrator_login_password = data.azurerm_key_vault_secret.sql_pass.value

  minimum_tls_version                  = var.minimum_tls_version
  public_network_access_enabled        = var.public_network_access_enabled
  outbound_network_restriction_enabled = var.outbound_network_restriction_enabled


  # --------------------
  # MANAGED IDENTITY
  # --------------------
  dynamic "identity" {
    for_each = var.identity == null ? [] : [var.identity]
    content {
      type         = identity.value.type
      identity_ids = lookup(identity.value, "identity_ids", null)
    }
  }

  # --------------------
  # AZURE AD ADMIN
  # --------------------
  dynamic "azuread_administrator" {
    for_each = var.azuread_administrator == null ? [] : [var.azuread_administrator]
    content {
      login_username              = azuread_administrator.value.login_username
      object_id                   = azuread_administrator.value.object_id
      tenant_id                   = lookup(azuread_administrator.value, "tenant_id", null)
      azuread_authentication_only = lookup(azuread_administrator.value, "azuread_authentication_only", false)
    }
  }
}
resource "azurerm_mssql_firewall_rule" "rules" {
  for_each = {
    for r in var.firewall_rules : r.name => r
  }

  name             = each.value.name
  server_id        = azurerm_mssql_server.sqlserver.id
  start_ip_address = each.value.start_ip_address
  end_ip_address   = each.value.end_ip_address
}
