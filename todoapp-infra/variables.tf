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

variable "vms" {}

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