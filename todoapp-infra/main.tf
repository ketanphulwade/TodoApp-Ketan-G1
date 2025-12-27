module "resource_group" {
  source   = "../modules/azurerm_resource_group"
  rg_name  = var.rg_name
  location = var.location

}

# module "keyvault" {
#   depends_on   = [module.resource_group]
#   source       = "../modules/azurerm_key_vault"
#   rg_name      = var.rg_name
#   location     = var.location
#   vault_name   = var.vault_name
#   vm_username  = var.vm_username
#   vm_password  = var.vm_password
#   sql_username = var.sql_username
#   sql_password = var.sql_password
# }

module "keyvault" {
  depends_on = [module.resource_group]
  source     = "../modules/azurerm_key_vault"
  rg_name    = var.rg_name
  location   = var.location
  vault_name = var.vault_name

  vm_username  = var.vm_username
  vm_password  = var.vm_password
  sql_username = var.sql_username
  sql_password = var.sql_password

  purge_protection_enabled   = true
  soft_delete_retention_days = 7

  enabled_for_deployment          = true
  enabled_for_template_deployment = true

  network_acls = var.network_acls
}

module "virtual_network" {
  depends_on = [module.resource_group]
  source     = "../modules/azurerm_virtual_network"

  vnet_name     = var.vnet_name
  rg_name       = var.rg_name
  location      = var.location
  address_space = var.address_space
}

# module "virtual_network" {
#   depends_on    = [module.resource_group]
#   source        = "../modules/azurerm_virtual_network"
#   vnet_name     = var.vnet_name
#   location      = var.location
#   rg_name       = var.rg_name
#   address_space = var.address_space

# }
module "subnet" {
  depends_on = [module.virtual_network]
  source     = "../modules/azurerm_subnet"
  subnet     = var.subnet
  rg_name    = var.rg_name
  vnet_name  = module.virtual_network.name
}

module "nsg" {
  depends_on     = [module.subnet]
  source         = "../modules/azurerm_nsg"
  nsg_name       = var.nsg_name
  rg_name        = var.rg_name
  location       = var.location
  subnet_ids     = module.subnet.subnet_ids # 🔥 THIS
  security_rules = var.security_rules
}


module "public_ip" {
  depends_on = [module.subnet]
  source     = "../modules/azurerm_public_ip"
  public_ip  = var.public_ip
  rg_name    = var.rg_name
  location   = var.location
}

module "vm" {
  depends_on = [module.subnet, module.public_ip, module.keyvault]
  source     = "../modules/azure_virtual_machine"
  vms        = var.vms

}
# module "sql_server" {
#   depends_on      = [module.resource_group, module.keyvault]
#   source          = "../modules/azurerm_sql_server"
#   sql_server_name = var.sql_server_name
#   rg_name         = var.rg_name
#   location        = var.location
#   sql_username    = var.sql_username
#   vault_name      = var.vault_name

# }
module "sql_server" {
  depends_on = [module.resource_group, module.keyvault]
  source     = "../modules/azurerm_sql_server"
  vault_name = var.vault_name

  sql_server_name = var.sql_server_name
  rg_name         = var.rg_name
  location        = var.location
  sql_username    = var.sql_username

  key_vault_id = module.keyvault.kv_id

  firewall_rules = [
    {
      name             = "AllowAzureServices"
      start_ip_address = "0.0.0.0"
      end_ip_address   = "0.0.0.0"
    }
  ]

}


# module "sql_database" {
#   depends_on        = [module.sql_server]
#   source            = "../modules/azurerm_sql_database"
#   sql_database_name = var.sql_database_name
#   sql_server_name   = var.sql_server_name
#   rg_name           = var.rg_name


# }
module "sql_database" {
  depends_on      = [module.sql_server]
  source          = "../modules/azurerm_sql_database"
  rg_name         = var.rg_name
  sql_server_name = var.sql_server_name

  sql_database_name = var.sql_database_name
  sql_server_id     = module.sql_server.id

  sku_name     = "S0"
  max_size_gb  = 2
  license_type = "LicenseIncluded"
  enclave_type = "VBS"


}

