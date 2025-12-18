variable "sql_server_name" {
  description = "The name of the SQL server"
  type        = string

}
variable "rg_name" {
  description = "The name of the resource group where the SQL server will be created"
  type        = string

}


variable "location" {
  description = "The location of the SQL server"
  type        = string

}
variable "sql_username" {

}
#variable "vault_name"{}

variable "vault_name"{}