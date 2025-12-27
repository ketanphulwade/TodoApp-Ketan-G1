variable "sql_database_name" {
  description = "The name of the SQL database."
  type        = string

}

variable "sql_server_name" {
  description = "The name of the SQL server."
  type        = string

}
variable "rg_name" {
  description = "The name of the resource group where the SQL database will be created."
  type        = string

}
variable "collation" {
  type    = string
  default = null
}

variable "sku_name" {
  type    = string
  default = null
}

variable "max_size_gb" {
  type    = number
  default = null
}

variable "license_type" {
  type    = string
  default = null
}

variable "enclave_type" {
  type    = string
  default = null
}

variable "zone_redundant" {
  type    = bool
  default = null
}

variable "read_scale" {
  type    = bool
  default = null
}

variable "read_replica_count" {
  type    = number
  default = null
}

variable "ledger_enabled" {
  type    = bool
  default = null
}

variable "maintenance_configuration_name" {
  type    = string
  default = null
}

variable "transparent_data_encryption_enabled" {
  type    = bool
  default = true
}

variable "storage_account_type" {
  type    = string
  default = null
}

variable "tags" {
  type    = map(string)
  default = {}
}

# -----------------------
# SHORT TERM RETENTION
# -----------------------
variable "short_term_retention_policy" {
  type = object({
    retention_days           = number
    backup_interval_in_hours = optional(number)
  })
  default = null
}

# -----------------------
# LONG TERM RETENTION
# -----------------------
variable "long_term_retention_policy" {
  type = object({
    weekly_retention  = optional(string)
    monthly_retention = optional(string)
    yearly_retention  = optional(string)
    week_of_year      = optional(number)
  })
  default = null
}


variable "sql_server_id" {
  type = string
}
