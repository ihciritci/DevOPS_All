# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  address_space       = var.address_space
}

# Subnet
resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = [var.subnet_address_prefix]
}

# Network Interface    bir ağ arayüzü oluşturuldu.
resource "azurerm_network_interface" "interfc" {
  name                = var.network_interface_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location

  ip_configuration {
    name                          = var.ip_configuration_name
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = var.private_ip_allocation
    private_ip_address_version    = var.private_ip_version
  }
}

# Load Balancer  bir yük dengeleyici eklendi
resource "azurerm_lb" "lb" {
  name                = var.load_balancer_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location

  frontend_ip_configuration {
    name                 = var.frontend_ip_configuration_name
    subnet_id            = azurerm_subnet.example.id
    private_ip_address   = var.frontend_ip_address
    private_ip_address_allocation = var.frontend_ip_allocation
  }

  backend_address_pool {
    name = var.backend_address_pool_name
  }

  probe {
    name                      = var.probe_name
    protocol                  = var.probe_protocol
    port                      = var.probe_port
    interval                  = var.probe_interval
    number_of_probes          = var.probe_number_of_probes
  }
}