variable "pip_id" {
  description = "ID of the public IP address to associate with the NIC"
  type        = string
  default     = null

}

variable "location" {
  description = "Location for the resources"
  type        = string
}

variable "rg_name" {
  description = "Name of the resource group"
  type        = string
}

variable "image_publisher" {
  description = "Publisher of the OS image"
  type        = string
  default     = "Canonical"
}
variable "image_offer" {
  description = "Offer of the OS image"
  type        = string
  default     = "0001-com-ubuntu-server-jammy"


}
variable "image_sku" {
  description = "SKU of the OS image"
  type        = string
  default     = "22_04-lts"

}
variable "image_version" {
  description = "Version of the OS image"
  type        = string
  default     = "latest"


}

variable "subnet_name" {
  description = "Name of the subnet"

  default = "default"

}
variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
  default     = "todo-vnet"

}

variable "pip_name" {
  description = "Name of the public IP address"
  type        = string
  default     = "todo-pip"

}

variable "vm" {

}
variable "vms" {

}
variable vault_name{}

variable "public_ips" {
  description = "Map of public IPs per VM"
  type = map(object({
    name = string
  }))
}


