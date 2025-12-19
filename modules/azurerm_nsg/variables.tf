variable "location" {
  type = string
}

variable "rg_name" {
  type = string
}

/*variable "vnet_name" {
  type = string
}

variable "subnet_name" {
  description = "Map of subnets"
  type = map(object({
    name = string
  }))
}*/
variable "subnet_ids" {
  description = "Map of subnet IDs to associate NSG"
  type        = map(string)
}


/*variable "vm" {
  description = "VM map for NSG association"
  type        = map(any)
}*/

variable "nsg_name" {
  type    = string
  default = "todoapp-nsg"
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
