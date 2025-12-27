variable "sql_server_name" {
  description = "The name of the SQL server"
  type        = string

}
variable "rg_name" {
  description = "The name of the resource group where the SQL server will be created"
  type        = string

}


variable "location" {
  description = "The location of the SQL server"
  type        = string

}
variable "sql_username" {

}

variable "vault_name" {}

# variable "collation" {
#   type    = string
#   default = null
# }

# variable "sku_name" {
#   type    = string
#   default = null
# }

# variable "max_size_gb" {
#   type    = number
#   default = null
# }

# variable "license_type" {
#   type    = string
#   default = null
# }

# variable "enclave_type" {
#   type    = string
#   default = null
# }

# variable "zone_redundant" {
#   type    = bool
#   default = null
# }

# variable "read_scale" {
#   type    = bool
#   default = null
# }

# variable "read_replica_count" {
#   type    = number
#   default = null
# }

# variable "ledger_enabled" {
#   type    = bool
#   default = null
# }

# variable "maintenance_configuration_name" {
#   type    = string
#   default = null
# }

# variable "transparent_data_encryption_enabled" {
#   type    = bool
#   default = true
# }

# variable "storage_account_type" {
#   type    = string
#   default = null
# }

# variable "tags" {
#   type    = map(string)
#   default = {}
# }

# # -----------------------
# # SHORT TERM RETENTION
# # -----------------------
# variable "short_term_retention_policy" {
#   type = object({
#     retention_days            = number
#     backup_interval_in_hours  = optional(number)
#   })
#   default = null
# }

# # -----------------------
# # LONG TERM RETENTION
# # -----------------------
# variable "long_term_retention_policy" {
#   type = object({
#     weekly_retention  = optional(string)
#     monthly_retention = optional(string)
#     yearly_retention  = optional(string)
#     week_of_year      = optional(number)
#   })
#   default = null
# }

# variable "version" {
#   type    = string
#   default = "12.0"
# }
# variable "sql_server_version" {
#   type    = string
#   default = "12.0"
# }


# --------------------
# SECURITY / NETWORK
# --------------------
variable "minimum_tls_version" {
  type    = string
  default = "1.2"
}
variable "public_network_access_enabled" {
  type    = bool
  default = true
}

variable "outbound_network_restriction_enabled" {
  type    = bool
  default = false
}

# --------------------
# FIREWALL RULES
# --------------------
variable "firewall_rules" {
  description = "List of firewall rules"
  type = list(object({
    name             = string
    start_ip_address = string
    end_ip_address   = string
  }))
  default = []
}

# --------------------
# MANAGED IDENTITY
# --------------------
variable "identity" {
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  default = null
}

# --------------------
# AZURE AD ADMIN
# --------------------
variable "azuread_administrator" {
  type = object({
    login_username              = string
    object_id                   = string
    tenant_id                   = optional(string)
    azuread_authentication_only = optional(bool, false)
  })
  default = null
}

# variable "firewall_rules" {
#   description = "List of SQL Server firewall rules"
#   type = list(object({
#     name             = string
#     start_ip_address = string
#     end_ip_address   = string
#   }))
#   default = []
# }
variable "sql_server_version" {
  type    = string
  default = "12.0"
}
variable "key_vault_id" {
  description = "Key Vault ID where SQL secrets are stored"
  type        = string
}
