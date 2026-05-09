# Lab 03: Azure Firewall

## Overview
This lab focuses on deploying and configuring Azure Firewall to control inbound and outbound network access for Azure resources. It covers setting up virtual networks, routing traffic through the firewall, and defining application and network rules.

## Key Concepts
- **Azure Firewall**: A managed, cloud-based network security service that protects your Azure Virtual Network resources.
- **Firewall Policy**: A global resource that can be used to centrally manage firewall rules across multiple Azure Firewalls.
- **Application Rules**: Allow or deny FQDN-based network access (e.g., `www.bing.com`).
- **Network Rules**: Allow or deny IP address, port, and protocol-based network access (e.g., DNS lookups).
- **Route Table (UDR)**: Custom routes to direct traffic through the Azure Firewall.

## Lab Steps Summary
1. **Deploy Lab Environment**: Use an ARM template to deploy a virtual network with workload and jump host subnets, and a VM in each.
2. **Deploy Azure Firewall**: Deploy an Azure Firewall instance into the virtual network.
3. **Create Default Route**: Configure a User Defined Route (UDR) to force outbound traffic from the workload subnet through the firewall.
4. **Configure Application Rule**: Create an application rule to allow outbound access to `www.bing.com`.
5. **Configure Network Rule**: Create a network rule to allow outbound DNS lookups (port 53) to specific public DNS servers.
6. **Configure VM DNS Servers**: Update the DNS settings for the workload VM to use the specified DNS servers.
7. **Test Firewall**: Verify that the firewall rules are working as expected by testing access from the workload VM.

## Terraform Implementation

```hcl
# Resource Group (assuming it's already created or defined elsewhere)
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "Test-FW-VN"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Subnets
resource "azurerm_subnet" "workload_sn" {
  name                 = "Workload-SN"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "jump_sn" {
  name                 = "Jump-SN"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "azure_firewall_subnet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}

# Public IP for Azure Firewall
resource "azurerm_public_ip" "fw_pip" {
  name                = "TEST-FW-PIP"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Azure Firewall
resource "azurerm_firewall" "fw" {
  name                = "Test-FW01"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "Standard"
  sku_tier            = "Standard"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.azure_firewall_subnet.id
    public_ip_address_id = azurerm_public_ip.fw_pip.id
  }
}

# Route Table
resource "azurerm_route_table" "fw_route_table" {
  name                = "Firewall-route"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Route to Firewall
resource "azurerm_route" "fw_default_route" {
  name                   = "FW-DG"
  resource_group_name    = azurerm_resource_group.rg.name
  route_table_name       = azurerm_route_table.fw_route_table.name
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = azurerm_firewall.fw.ip_configuration[0].private_ip_address
}

# Associate Route Table to Workload Subnet
resource "azurerm_subnet_route_table_association" "workload_sn_rt_assoc" {
  subnet_id      = azurerm_subnet.workload_sn.id
  route_table_id = azurerm_route_table.fw_route_table.id
}

# Firewall Application Rule Collection
resource "azurerm_firewall_application_rule_collection" "app_rule_collection" {
  name                = "App-Coll01"
  azure_firewall_name = azurerm_firewall.fw.name
  resource_group_name = azurerm_resource_group.rg.name
  priority            = 200
  action              = "Allow"

  rule {
    name = "AllowGH"
    source_addresses = [azurerm_subnet.workload_sn.address_prefixes[0]]
    target_fqdns {
      port_numbers = ["80", "443"]
      fqdns        = ["www.bing.com"]
    }
    protocols {
      port_number = 80
      type        = "Http"
    }
    protocols {
      port_number = 443
      type        = "Https"
    }
  }
}

# Firewall Network Rule Collection
resource "azurerm_firewall_network_rule_collection" "net_rule_collection" {
  name                = "Net-Coll01"
  azure_firewall_name = azurerm_firewall.fw.name
  resource_group_name = azurerm_resource_group.rg.name
  priority            = 200
  action              = "Allow"

  rule {
    name = "AllowDNS"
    source_addresses = [azurerm_subnet.workload_sn.address_prefixes[0]]
    destination_addresses = ["209.244.0.3", "209.244.0.4"]
    destination_ports     = ["53"]
    protocols             = ["UDP"]
  }
}

# Virtual Machines (Simplified - actual VM creation would be more complex)
# For the purpose of this Terraform, we'll assume VMs are created separately or via ARM template as in the lab.
# The lab uses an ARM template for initial VM deployment, so we'll focus on the firewall and networking.

# Output the Firewall Private IP to be used in VM DNS configuration
output "azure_firewall_private_ip" {
  value = azurerm_firewall.fw.ip_configuration[0].private_ip_address
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  default     = "AZ500LAB08"
}

variable "location" {
  description = "The Azure region where resources will be deployed."
  type        = string
  default     = "East US"
}
```

## Reference
- [Official Lab Instructions](https://github.com/MicrosoftLearning/AZ500-AzureSecurityTechnologies/blob/master/Instructions/Labs/LAB_03_AzureFirewall.md)
