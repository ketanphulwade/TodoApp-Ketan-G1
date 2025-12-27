

# variable "location" {
#   description = "Location for the resources"
#   type        = string
# }

# variable "rg_name" {
#   description = "Name of the resource group"
#   type        = string
# }

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

    # =================
    # NETWORK LOOKUPS
    # =================
    vnet_name   = string
    subnet_name = string
    pip_name    = string
    kv_name     = string
    script_name = optional(string)
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
