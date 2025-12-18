variable "public_ip" {

}
variable "rg_name" {
  description = "The name of the resource group where the public IP address will be created"
  type        = string

}
variable "location" {
  description = "The location of the public IP address"
  type        = string

}

