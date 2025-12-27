#variable "public_ip" {}

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
variable "rg_name" {
  description = "The name of the resource group where the public IP address will be created"
  type        = string

}
variable "location" {
  description = "The location of the public IP address"
  type        = string

}

