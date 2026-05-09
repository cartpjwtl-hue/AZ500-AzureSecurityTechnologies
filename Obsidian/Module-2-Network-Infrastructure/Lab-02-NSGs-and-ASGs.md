# Lab 02: Network Security Groups (NSGs) and Application Security Groups (ASGs)

## Overview
This lab covers the implementation of network security controls using NSGs and ASGs to filter traffic between subnets and virtual machines.

## Key Concepts
- **Network Security Group (NSG)**: Contains security rules that allow or deny inbound/outbound network traffic.
- **Application Security Group (ASG)**: Allows you to group servers with similar functions and define network security policies based on those groups.
- **Inbound/Outbound Rules**: Rules defined by priority, source/destination, protocol, and port.

## Lab Steps Summary
1. **Create VNet**: Create a virtual network `myVirtualNetwork` with a default subnet.
2. **Create ASGs**: Create `myAsgWebServers` and `myAsgMgmtServers`.
3. **Create NSG**: Create `myNsg` and associate it with the VNet subnet.
4. **Define Rules**:
   - Allow HTTP/HTTPS (80, 443) to `myAsgWebServers`.
   - Allow RDP (3389) to `myAsgMgmtServers`.
5. **Deploy VMs**: Create `myVmWeb` and `myVMMgmt`.
6. **Associate NICs**: Assign each VM's network interface to the appropriate ASG.

## Terraform Implementation

```hcl
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
```

## Reference
- [Official Lab Instructions](https://github.com/MicrosoftLearning/AZ500-AzureSecurityTechnologies/blob/master/Instructions/Labs/LAB_02_NSGs.md)
