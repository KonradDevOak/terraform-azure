resource "azurerm_resource_group" "main" {
  name     = "rg-${var.application_name}-${var.environment_name}"
  location = var.primary_location
}

# https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing
resource "azurerm_virtual_network" "main" {
  name                = "vnet-${var.application_name}-${var.environment_name}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space       = [var.base_address_space]
}

locals {
  # alpha_address_space = cidrsubnet(var.base_address_space, 2, 0)
  bastion_address_space = cidrsubnet(var.base_address_space, 4, 0)
  beta_address_space    = cidrsubnet(var.base_address_space, 2, 1)
  gamma_address_space   = cidrsubnet(var.base_address_space, 2, 2)
  omega_address_space   = cidrsubnet(var.base_address_space, 2, 3)
}

# 10.7.0.0/24
# resource "azurerm_subnet" "alpha" {
#   name                 = "snet-alpha"
#   resource_group_name  = azurerm_resource_group.main.name
#   virtual_network_name = azurerm_virtual_network.main.name
#   address_prefixes     = [local.alpha_address_space]
# }

# Bastion
# 10.7.0.0/26
# Start at: 10.7.0.0
# End at: 10.7.0.63
resource "azurerm_subnet" "bastion" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [local.bastion_address_space]
}

# 10.7.0.1/24
resource "azurerm_subnet" "beta" {
  name                 = "snet-beta"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [local.beta_address_space]
}

# 10.7.0.2/24
resource "azurerm_subnet" "gamma" {
  name                 = "snet-gamma"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [local.gamma_address_space]
}

# 10.7.0.3/24
resource "azurerm_subnet" "omega" {
  name                 = "snet-omega"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [local.omega_address_space]
}

# resource "azurerm_network_security_group" "remote_access" {
#   name                = "nsg-${var.application_name}-${var.environment_name}-remote-access"
#   location            = azurerm_resource_group.main.location
#   resource_group_name = azurerm_resource_group.main.name

#   security_rule {
#     name                       = "ssh"
#     priority                   = 100
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "22"
#     source_address_prefix      = chomp(data.http.my_ip.response_body)
#     destination_address_prefix = "*"
#   }
# }

# resource "azurerm_subnet_network_security_group_association" "alpha_remote_access" {
#   subnet_id                 = azurerm_subnet.alpha.id
#   network_security_group_id = azurerm_network_security_group.remote_access.id
# }

data "http" "my_ip" {
  url = "https://ipinfo.io/ip"
}

resource "azurerm_public_ip" "bastion" {
  name                = "pip-${var.application_name}-${var.environment_name}-bastion"
  location            = azurerm_resource_group.main.location
    resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "main" {
  name                = "bas-${var.application_name}-${var.environment_name}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastion.id
    public_ip_address_id = azurerm_public_ip.bastion.id
  }
}