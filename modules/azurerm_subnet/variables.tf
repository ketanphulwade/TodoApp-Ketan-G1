# variable "subnet" {
#   description = "The name of the subnet"

# }

variable "rg_name" {
  description = "The name of the resource group where the subnet will be created"
  type        = string

}
variable "vnet_name" {

}

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

