rg_name           = "rg-frc-dev-todoapp-ketan-01"
location          = "francecentral"
vault_name        = "kv-frc-dev-todoapp-001"
vm_username       = "#{vm_username}#"
vm_password       = "#{vm_password}#"
sql_username      = "#{sql_username}#"
sql_password      = "#{sql_password}#"
sql_server_name   = "sql-frc-dev-todoapp-01"
sql_database_name = "sqldb-frc-dev-todoapp-01"
nsg_name          = "nsg-frc-dev-todoapp-01"
vnet_name         = "vnet-frc-dev-todoapp-01"
address_space     = ["10.0.0.0/16"]
subnet = {
  frontend = {
    name             = "subnet-frontend-frc-dev-todoapp-01"
    address_prefixes = ["10.0.1.0/24"]
  }

  backend = {
    name             = "subnet-backend-frc-dev-todoapp-01"
    address_prefixes = ["10.0.2.0/24"]
  }

}

public_ip = {
  frontend = {
    name              = "pip-frontend-frc-dev-todoapp-01"
    allocation_method = "Static"
  }
  backend = {
    name              = "pip-backend-frc-dev-todoapp-01"
    allocation_method = "Static"
  }
}

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

vms = {

  frontend = {
    vm_name     = "vm-frontend-frc-dev-todoapp-01"
    nic_name    = "nic-frontend-frc-dev-todoapp-01"
    rg_name     = "rg-frc-dev-todoapp-ketan-01"
    pip_name    = "pip-frontend-frc-dev-todoapp-01"
    kv_name     = "kv-frc-dev-todoapp-001"
    script_name = "install_nginx.sh"
    vnet_name   = "vnet-frc-dev-todoapp-01"
    vm_size     = "Standard_D2s_v3"
    subnet_name = "subnet-frontend-frc-dev-todoapp-01"
    location    = "francecentral"
    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-focal"
      sku       = "20_04-lts"
      version   = "latest"

    }

  }
  backend = {
    vm_name     = "vm-backend-frc-dev-todoapp-01"
    nic_name    = "nic-backend-frc-dev-todoapp-01"
    rg_name     = "rg-frc-dev-todoapp-ketan-01"
    pip_name    = "pip-backend-frc-dev-todoapp-01"
    kv_name     = "kv-frc-dev-todoapp-001"
    vnet_name   = "vnet-frc-dev-todoapp-01"
    vm_size     = "Standard_D2s_v3"
    subnet_name = "subnet-backend-frc-dev-todoapp-01"
    script_name = "install_python.sh"
    location    = "francecentral"
    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-focal"
      sku       = "20_04-lts"
      version   = "latest"

    }
  }

}



sku_name       = "BC_Gen5_2"
max_size_gb    = 50
zone_redundant = true

short_term_retention_policy = {
  retention_days = 14
}

long_term_retention_policy = {
  weekly_retention  = "P4W"
  monthly_retention = "P12M"
  yearly_retention  = "P5Y"
  week_of_year      = 16
}

network_acls = {
  bypass         = "AzureServices"
  default_action = "Deny"
  ip_rules       = ["103.134.167.84/32"]
}
