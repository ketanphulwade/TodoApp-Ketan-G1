# variable "rg_name" {
#   type = string
# }

# variable "location" {
#   type = string
# }

# variable "vault_name" {
#   type = string
# }

# variable "vm_username" {
#   type = string
# }

# variable "vm_password" {
#   type = string
# }

# variable "sql_username" {
#   type = string
# }

# variable "sql_password" {
# }

variable "vault_name" {
  type = string
}

variable "location" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "sku_name" {
  type    = string
  default = "standard"
}

variable "soft_delete_retention_days" {
  type    = number
  default = 7
}

variable "purge_protection_enabled" {
  type    = bool
  default = false
}

variable "enable_rbac_authorization" {
  type    = bool
  default = false
}

# -----------------------------
# OPTIONAL FLAGS
# -----------------------------
variable "enabled_for_deployment" {
  type    = bool
  default = false
}

variable "enabled_for_disk_encryption" {
  type    = bool
  default = false
}

variable "enabled_for_template_deployment" {
  type    = bool
  default = false
}

variable "public_network_access_enabled" {
  type    = bool
  default = true
}

# -----------------------------
# NETWORK ACLs (OPTIONAL)
# -----------------------------
variable "network_acls" {
  type = object({
    bypass                     = string
    default_action             = string
    ip_rules                   = optional(list(string))
    virtual_network_subnet_ids = optional(list(string))
  })
  default = null
}

# -----------------------------
# SECRETS
# -----------------------------
variable "vm_username" {
  type      = string
  sensitive = true
}

variable "vm_password" {
  type      = string
  sensitive = true
}

variable "sql_username" {
  type      = string
  sensitive = true
}

variable "sql_password" {
  type      = string
  sensitive = true
}
