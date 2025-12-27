

# resource "azurerm_mssql_database" "sqldatabase" {
#   name         = var.sql_database_name
#   server_id    = data.azurerm_mssql_server.sql_database.id
#   collation    = "SQL_Latin1_General_CP1_CI_AS"
#   license_type = "LicenseIncluded"
#   max_size_gb  = 2
#   sku_name     = "S0"
#   enclave_type = "VBS"


# }

resource "azurerm_mssql_database" "sqldb" {
  name      = var.sql_database_name
  server_id = var.sql_server_id

  collation    = var.collation
  sku_name     = var.sku_name
  max_size_gb  = var.max_size_gb
  license_type = var.license_type
  enclave_type = var.enclave_type

  zone_redundant     = var.zone_redundant
  read_scale         = var.read_scale
  read_replica_count = var.read_replica_count
  ledger_enabled     = var.ledger_enabled

  maintenance_configuration_name      = var.maintenance_configuration_name
  transparent_data_encryption_enabled = var.transparent_data_encryption_enabled
  storage_account_type                = var.storage_account_type

  tags = var.tags

  # -----------------------
  # SHORT TERM RETENTION
  # -----------------------
  dynamic "short_term_retention_policy" {
    for_each = var.short_term_retention_policy == null ? [] : [var.short_term_retention_policy]
    content {
      retention_days           = short_term_retention_policy.value.retention_days
      backup_interval_in_hours = lookup(short_term_retention_policy.value, "backup_interval_in_hours", null)
    }
  }

  # -----------------------
  # LONG TERM RETENTION
  # -----------------------
  dynamic "long_term_retention_policy" {
    for_each = var.long_term_retention_policy == null ? [] : [var.long_term_retention_policy]
    content {
      weekly_retention  = lookup(long_term_retention_policy.value, "weekly_retention", null)
      monthly_retention = lookup(long_term_retention_policy.value, "monthly_retention", null)
      yearly_retention  = lookup(long_term_retention_policy.value, "yearly_retention", null)
      week_of_year      = lookup(long_term_retention_policy.value, "week_of_year", null)
    }
  }
}
