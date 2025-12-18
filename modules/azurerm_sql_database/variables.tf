variable "sql_database_name" {
  description = "The name of the SQL database."
  type        = string

}

variable "sql_server_name" {
  description = "The name of the SQL server."
  type        = string

}
variable "rg_name" {
  description = "The name of the resource group where the SQL database will be created."
  type        = string

}