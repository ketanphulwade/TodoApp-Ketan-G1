rg_name           = "rg-todoapp-ketan"
location          = "Central India"
vault_name        = "todoapp-ketan-kv1"
vm_username       = "#{vm_username}#"
vm_password       = "#{vm_password}#"
sql_username      = "#{sql_username}#"
sql_password      = "#{sql_password}#"
sql_server_name   = "todoapp-sqlserver-ketan"
sql_database_name = "todoappdb"
# vnet = {
#   frontend = {
#     name          = "todo-vnet"
#     address_space = ["10.0.0.0/16"]
#   }
# }
vnet_name     = "todo-vnet"
address_space = ["10.0.0.0/16"]
subnet = {
  frontend = {
    name             = "frontend-subnet"
    address_prefixes = ["10.0.1.0/24"]
  }

  backend = {
    name             = "backend-subnet"
    address_prefixes = ["10.0.2.0/24"]
  }

}

public_ip = {
  frontend = {
    name              = "todoapp-frontend-pip"
    allocation_method = "Static"
  }
  backend = {
    name              = "todoapp-backend-pip"
    allocation_method = "Static"
  }
}

vm = {
  frontend = {
    name            = "frontend-vm"
    vm_size         = "Standard_D2s_v3"
    image_publisher = "Canonical"
    image_offer     = "0001-com-ubuntu-server-focal"
    image_sku       = "20_04-lts"
    image_version   = "latest"
  }
  backend = {
    name            = "backend-vm"
    vm_size         = "Standard_D2s_v3"
    image_publisher = "Canonical"
    image_offer     = "0001-com-ubuntu-server-focal"
    image_sku       = "20_04-lts"
    image_version   = "latest"
  }
}

vms = {
  frontend = ""
  backend  = ""
}

