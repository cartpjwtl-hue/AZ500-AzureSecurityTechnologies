# Lab 10: Enable Just-in-Time (JIT) Access on VMs

## Overview
This lab demonstrates how to implement Just-in-Time (JIT) VM access using Microsoft Defender for Cloud to reduce the attack surface of Azure Virtual Machines. JIT access ensures that network access to VMs is only granted when needed, for a limited time, and from approved source IP addresses.

## Key Concepts
- **Just-in-Time (JIT) VM Access**: A feature of Microsoft Defender for Cloud that locks down inbound traffic to your Azure VMs, reducing exposure to network attacks. It provides controlled access to VMs only when required.
- **Microsoft Defender for Cloud**: Provides cloud security posture management (CSPM) and cloud workload protection (CWP) for your Azure resources.
- **Network Security Group (NSG)**: JIT access works by configuring NSG rules to restrict inbound traffic to management ports (e.g., RDP, SSH) and only opening them for a short, approved period when access is requested.

## Lab Steps Summary
1.  **Enable JIT on VMs**: Configure JIT access for a virtual machine through the Azure portal or Microsoft Defender for Cloud.
2.  **Review JIT Settings**: Examine the default and configurable settings for JIT, including RDP/SSH ports, maximum access duration, and allowed source IP addresses.
3.  **Request Access**: Simulate requesting access to a JIT-enabled VM from the Azure portal, demonstrating the process of gaining temporary, controlled access.

## Terraform Implementation

```hcl
# Resource Group (assuming it's already created or defined elsewhere)
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Virtual Network (simplified for JIT context)
resource "azurerm_virtual_network" "vnet" {
  name                = "myVnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "mySubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}

# Network Security Group (for the VM)
resource "azurerm_network_security_group" "nsg" {
  name                = "myNetworkSecurityGroup"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# Public IP Address for the VM
resource "azurerm_public_ip" "public_ip" {
  name                = "myPublicIpAddress"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Network Interface for the VM
resource "azurerm_network_interface" "nic" {
  name                = "myVM-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

# Virtual Machine (Windows Server 2019 Datacenter)
resource "azurerm_windows_virtual_machine" "vm" {
  name                = "myVM"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_D2s_v3"
  admin_username      = "localadmin"
  admin_password      = var.vm_admin_password
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

# Enable JIT Network Access Policy for the VM
resource "azurerm_security_center_jit_network_access_policy" "jit_policy" {
  virtual_machine_id = azurerm_windows_virtual_machine.vm.id
  location           = azurerm_resource_group.rg.location

  port {
    number                   = 3389 # RDP port
    protocol                 = "*"
    duration_in_minutes      = 180 # 3 hours
    allowed_source_address_prefixes = ["*"]
  }

  port {
    number                   = 22 # SSH port (if applicable for Linux VMs)
    protocol                 = "*"
    duration_in_minutes      = 180
    allowed_source_address_prefixes = ["*"]
  }
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  default     = "AZ500LAB131415"
}

variable "location" {
  description = "The Azure region where resources will be deployed."
  type        = string
  default     = "East US"
}

variable "vm_admin_password" {
  description = "The admin password for the VM."
  type        = string
  sensitive   = true
}
```

## Reference
- [Official Lab Instructions](https://github.com/MicrosoftLearning/AZ500-AzureSecurityTechnologies/blob/master/Instructions/Labs/LAB_10_Enable%20just-in-time%20access%20on%20VMs.md)
