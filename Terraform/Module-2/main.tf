terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

variable "resource_group" {
  default = "AZ500LAB07"
}

variable "location" {
  default = "East US"
}

# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "myVirtualNetwork"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group
}

resource "azurerm_subnet" "subnet" {
  name                 = "default"
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}

# Application Security Groups
resource "azurerm_application_security_group" "asg_web" {
  name                = "myAsgWebServers"
  location            = var.location
  resource_group_name = var.resource_group
}

resource "azurerm_application_security_group" "asg_mgmt" {
  name                = "myAsgMgmtServers"
  location            = var.location
  resource_group_name = var.resource_group
}

# Network Security Group
resource "azurerm_network_security_group" "nsg" {
  name                = "myNsg"
  location            = var.location
  resource_group_name = var.resource_group

  security_rule {
    name                       = "Allow-Web-All"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["80", "443"]
    source_address_prefix      = "*"
    destination_application_security_group_ids = [azurerm_application_security_group.asg_web.id]
  }

  security_rule {
    name                       = "Allow-RDP-All"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_application_security_group_ids = [azurerm_application_security_group.asg_mgmt.id]
  }
}

# Associate NSG to Subnet
resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
