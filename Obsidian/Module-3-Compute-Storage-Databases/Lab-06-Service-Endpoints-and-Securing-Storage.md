# Lab 06: Service Endpoints and Securing Storage

## Overview
This lab demonstrates how to secure Azure file shares using service endpoints and network security groups. The goal is to restrict access to storage accounts from specific subnets and verify that resources outside these subnets cannot access the storage.

## Key Concepts
- **Service Endpoints**: Extend your virtual network private address space and identity to Azure services over a direct connection. This allows you to secure your critical Azure service resources to only your virtual networks.
- **Network Security Group (NSG)**: Filters network traffic to and from Azure resources in an Azure virtual network.
- **Storage Account**: A unique namespace in Azure for storing your data objects.
- **Subnets**: Logical subdivisions of a virtual network.

## Lab Steps Summary
1. **Create Virtual Network**: Set up a virtual network (`myVirtualNetwork`) with an initial subnet (`Public`).
2. **Add Private Subnet with Service Endpoint**: Create a `Private` subnet and enable a service endpoint for Azure Storage on it.
3. **Configure NSG for Private Subnet**: Create `myNsgPrivate` with rules to:
   - Allow outbound traffic to Azure Storage (Service Tag: `Storage`).
   - Deny outbound traffic to the Internet (Service Tag: `Internet`).
   - Allow inbound RDP (3389) from any source.
   - Associate `myNsgPrivate` with the `Private` subnet.
4. **Configure NSG for Public Subnet**: Create `myNsgPublic` with a rule to allow inbound RDP (3389) from any source, and associate it with the `Public` subnet.
5. **Create Storage Account**: Provision an Azure Storage Account with a file share.
6. **Deploy Virtual Machines**: Deploy VMs into both the `Public` and `Private` subnets.
7. **Test Storage Connection**: Verify that the VM in the `Private` subnet can access the storage account, and the VM in the `Public` subnet cannot.

## Terraform Implementation

```hcl
# Resource Group (assuming it's already created or defined elsewhere)
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "myVirtualNetwork"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Public Subnet
resource "azurerm_subnet" "public_subnet" {
  name                 = "Public"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}

# Private Subnet with Service Endpoint for Storage
resource "azurerm_subnet" "private_subnet" {
  name                 = "Private"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
  service_endpoints    = ["Microsoft.Storage"]
}

# NSG for Private Subnet
resource "azurerm_network_security_group" "nsg_private" {
  name                = "myNsgPrivate"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "Allow-Storage-All"
    priority                   = 1000
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "Storage"
  }

  security_rule {
    name                       = "Deny-Internet-All"
    priority                   = 1100
    direction                  = "Outbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "Internet"
  }

  security_rule {
    name                       = "Allow-RDP-Private"
    priority                   = 1200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "VirtualNetwork"
  }
}

# NSG for Public Subnet
resource "azurerm_network_security_group" "nsg_public" {
  name                = "myNsgPublic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "Allow-RDP-Public"
    priority                   = 1200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "VirtualNetwork"
  }
}

# Associate NSG to Private Subnet
resource "azurerm_subnet_network_security_group_association" "private_nsg_assoc" {
  subnet_id                 = azurerm_subnet.private_subnet.id
  network_security_group_id = azurerm_network_security_group.nsg_private.id
}

# Associate NSG to Public Subnet
resource "azurerm_subnet_network_security_group_association" "public_nsg_assoc" {
  subnet_id                 = azurerm_subnet.public_subnet.id
  network_security_group_id = azurerm_network_security_group.nsg_public.id
}

# Storage Account
resource "azurerm_storage_account" "storage_account" {
  name                     = "az500storage${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  network_rules {
    default_action             = "Deny"
    virtual_network_subnet_ids = [azurerm_subnet.private_subnet.id]
    ip_rules                   = []
  }
}

# Random string for unique naming
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  default     = "AZ500LAB12"
}

variable "location" {
  description = "The Azure region where resources will be deployed."
  type        = string
  default     = "East US"
}
```

## Reference
- [Official Lab Instructions](https://github.com/MicrosoftLearning/AZ500-AzureSecurityTechnologies/blob/master/Instructions/Labs/LAB_06_SecuringAzureStorage.MD)
