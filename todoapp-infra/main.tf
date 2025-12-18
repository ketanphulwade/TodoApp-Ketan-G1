module "resource_group" {
  source   = "../modules/azurerm_resource_group"
  rg_name  = var.rg_name
  location = var.location

}

module "keyvault" {
  depends_on   = [module.resource_group]
  source       = "../modules/azurerm_key_vault"
  rg_name      = var.rg_name
  location     = var.location
  vault_name   = var.vault_name
  vm_username  = var.vm_username
  vm_password  = var.vm_password
  sql_username = var.sql_username
  sql_password = var.sql_password
}

module "virtual_network" {
  depends_on    = [module.resource_group]
  source        = "../modules/azurerm_virtual_network"
  vnet_name     = var.vnet_name
  location      = var.location
  rg_name       = var.rg_name
  address_space = var.address_space

}
module "subnet" {
  depends_on = [module.virtual_network]
  source     = "../modules/azurerm_subnet"
  subnet     = var.subnet
  rg_name    = var.rg_name
}


module "nsg" {
  depends_on  = [module.subnet]
  source      = "../modules/azurerm_nsg"
  rg_name     = var.rg_name
  subnet_name = var.subnet
  location    = var.location
  vms         = var.vms
  vnet_name   = module.virtual_network.name
}

module "public_ip" {
  depends_on = [module.subnet]
  source     = "../modules/azurerm_public_ip"
  public_ip  = var.public_ip
  rg_name    = var.rg_name
  location   = var.location
}

module "vm" {
  depends_on  = [module.subnet, module.public_ip, module.keyvault]
  source      = "../modules/azure_virtual_machine"
  vms         = var.vms
  vm          = var.vm
  rg_name     = var.rg_name
  location    = var.location
  public_ips  = var.public_ip # ✅ Pass entire map instead of one IP
  subnet_name = var.subnet    # ✅ Pass entire map instead of one subnet
  vnet_name   = var.vnet_name
  vault_name   = var.vault_name
 
}

module "sql_server" {
  depends_on      = [module.resource_group, module.keyvault]
  source          = "../modules/azurerm_sql_server"
  sql_server_name = var.sql_server_name
  rg_name         = var.rg_name
  location        = var.location
  sql_username = var.sql_username
  vault_name   = var.vault_name

}

module "sql_database" {
  depends_on        = [module.sql_server]
  source            = "../modules/azurerm_sql_database"
  sql_database_name = var.sql_database_name
  sql_server_name   = var.sql_server_name
  rg_name           = var.rg_name


}

