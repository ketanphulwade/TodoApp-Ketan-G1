variable "rg_name" {
  description = "The name of the resource group"
  type        = string

}

variable "location" {
  description = "The location of the resource group"
  type        = string
  default     = "West Europe"
}
variable "sql_server_name" {}
variable "sql_database_name" {

}
variable "vault_name" {
  description = "The name of key vault"
  type        = string

}

# variable "rbac_principal_id" {
# }

variable "vm_username" {

}
variable "vm_password" {

}
variable "sql_username" {

}
variable "sql_password" {

}

# variable "vnet" {

# }
variable "vnet_name" {
  description = "Name of the VNet"
  default     = "todo-vnet"
}

variable "address_space" {

}

variable "vm" {

}

#variable "vms" {}

variable "public_ip" {
  description = "Map of public IPs for VMs"
  # type = map(object({
  #   name = string
  # }))
}

variable "subnet" {
  description = "Map of subnet names for VMs"
  # type = map(object({
  #   name = string
  # }))
}
# variable "subnet_ids" {

# }

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
/*variable "ip_configuration" {
  description = "Map of IP configurations per VM"
  type = map(object({
    name = string

    #subnet_id                     = string
    private_ip_address_allocation = string
    #public_ip_address_id = string
    }
  ))
}*/
