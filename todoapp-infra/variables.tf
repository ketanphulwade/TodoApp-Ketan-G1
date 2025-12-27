# variable "rg_name" {
#   description = "The name of the resource group"
#   type        = string

# }

# variable "location" {
#   description = "The location of the resource group"
#   type        = string
#   default     = "West Europe"
# }
variable "sql_server_name" {}
variable "sql_database_name" {}

# }
# variable "vault_name" {
#   description = "The name of key vault"
#   type        = string

# }

# variable "vm_username" {

# }
# variable "vm_password" {

# }
# variable "sql_username" {

# }
# variable "sql_password" {

# }

variable "vnet_name" {
  description = "Name of the VNet"
  default     = "todo-vnet"
}

variable "address_space" {

}

variable "vms" {
  description = "Map of VM and NIC configuration"
  type = map(object({

    # =================
    # VM BASICS
    # =================
    vm_name  = string
    nic_name = string
    rg_name  = string
    location = string
    vm_size  = string
    script_name = optional(string)
    # =================
    # NETWORK LOOKUPS
    # =================
    vnet_name   = string
    subnet_name = string
    pip_name    = string
    kv_name     = string

    # =================
    # VM IMAGE
    # =================
    source_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })

    # =================
    # NIC OPTIONAL SETTINGS
    # =================
    accelerated_networking_enabled = optional(bool, false)
    ip_forwarding_enabled          = optional(bool, false)
    dns_servers                    = optional(list(string))
    internal_dns_name_label        = optional(string)
    tags                           = optional(map(string))

    # =================
    # IP CONFIGURATION (OPTIONAL FIELDS)
    # =================
    ip_configuration = optional(object({
      private_ip_address_allocation = string           # Dynamic / Static
      private_ip_address            = optional(string) # only if Static
      private_ip_address_version    = optional(string, "IPv4")
      primary                       = optional(bool, true)
      }), {
      private_ip_address_allocation = "Dynamic"
    })

  }))
}

variable "public_ip" {
  description = "Map of Public IP configurations"
  type = map(object({
    name              = string
    allocation_method = string # Static / Dynamic

    # ---------- OPTIONAL ----------
    sku                     = optional(string, "Standard")
    sku_tier                = optional(string, "Regional")
    zones                   = optional(list(string))
    ip_version              = optional(string, "IPv4")
    idle_timeout_in_minutes = optional(number)
    domain_name_label       = optional(string)
    domain_name_label_scope = optional(string)
    reverse_fqdn            = optional(string)
    public_ip_prefix_id     = optional(string)

    ddos_protection_mode    = optional(string, "VirtualNetworkInherited")
    ddos_protection_plan_id = optional(string)

    ip_tags = optional(map(string))
    tags    = optional(map(string))
  }))
}

# variable "public_ip" {
#   description = "Map of public IPs for VMs"
#   # type = map(object({
#   #   name = string
#   # }))
# }

# variable "subnet" {
#   description = "Map of subnet names for VMs"
#   # type = map(object({
#   #   name = string
#   # }))
# }

variable "subnet" {
  type = map(object({
    name             = string
    address_prefixes = list(string)

    service_endpoints                             = optional(list(string))
    default_outbound_access_enabled               = optional(bool)
    private_endpoint_network_policies             = optional(string)
    private_link_service_network_policies_enabled = optional(bool)

    delegation = optional(list(object({
      name = string
      service_delegation = object({
        name    = string
        actions = optional(list(string))
      })
    })))
  }))
}



# }
variable "nsg_name" {
  type = string
  #default = "todoapp-nsg"
}


variable "security_rules" {
  description = "List of NSG security rules"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
}


variable "vault_name" {
  type = string
}

variable "location" {
  type = string
}

variable "rg_name" {
  type = string
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


# variable "version" {
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
# variable "public_network_access_enabled" {
#   type    = bool
#   default = true
# }

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


# OPTIONALS
variable "dns_servers" {
  type    = list(string)
  default = null
}

variable "edge_zone" {
  type    = string
  default = null
}

variable "flow_timeout_in_minutes" {
  type    = number
  default = null
}

variable "private_endpoint_vnet_policies" {
  type    = string
  default = null
}

# variable "tags" {
#   type    = map(string)
#   default = {}
# }

variable "ddos_protection_plan" {
  type = object({
    id     = string
    enable = bool
  })
  default = null
}

variable "encryption" {
  type = object({
    enforcement = string
  })
  default = null
}