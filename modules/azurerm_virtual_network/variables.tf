
variable "location" {
  description = "The location of the virtual network"
  type        = string

}

variable "rg_name" {
  description = "The name of the resource group where the virtual network will be created"
  type        = string
}
variable "vnet_name" {

}
variable "address_space" {

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