rg_name           = "rg-todoapp-ketan"
location          = "francecentral"
vault_name        = "todoapp-ketan-kv7"
vm_username       = "vmadmin"
vm_password       = "Rajvee@2019"
sql_username      = "sqladmin"
sql_password      = "Rajvee@2019"
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

/*vms = {
  frontend = ""
  backend  = ""
}*/

security_rules = [
  {
    name                       = "allow_ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "allow_http"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
}]

/*
ip_configuration = {
  frontend = {
    private_ip_address_allocation = "Dynamic"
    primary                       = true
    associate_public_ip           = true
  }

  backend = {
    private_ip_address_allocation = "Dynamic"
    primary                       = true
    associate_public_ip           = false
  }
}
*/