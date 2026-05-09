# Lab 09: Configuring Microsoft Defender for Cloud Enhanced Security Features for Servers

## Overview
This lab focuses on enabling and configuring Microsoft Defender for Servers within Microsoft Defender for Cloud to provide advanced threat protection and security monitoring for Azure VMs and hybrid servers. It addresses the need for enhanced security measures against cyber threats, vulnerabilities, and misconfigurations in cloud infrastructure.

## Key Concepts
- **Microsoft Defender for Cloud**: A unified infrastructure security management system that strengthens the security posture of your cloud resources.
- **Microsoft Defender for Servers**: A plan within Defender for Cloud that provides comprehensive protection for Windows and Linux machines, whether they are in Azure, on-premises, or in other clouds.
- **Enhanced Security Features**: Includes capabilities like vulnerability assessment, just-in-time VM access, adaptive application controls, file integrity monitoring, and more.
- **Cloud Workload Protection (CWPP)**: A category of security solutions that protect cloud-based workloads (VMs, containers, databases, etc.) from various threats.

## Lab Steps Summary
1.  **Navigate to Microsoft Defender for Cloud**: Access the Defender for Cloud portal.
2.  **Enable Defender for Servers Plan**: In the Environment settings, enable the Defender for Servers plan for the relevant subscription.
3.  **Review Enhanced Features**: Examine the details of Microsoft Defender for Servers Plan 2 to understand the included security capabilities.

## Terraform Implementation

```hcl
# Resource Group (assuming it's already created or defined elsewhere)
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Enable Microsoft Defender for Servers Plan 2 for the subscription
resource "azurerm_security_center_subscription_pricing" "defender_for_servers" {
  tier          = "Standard"
  resource_type = "VirtualMachines"
}

# Note: The lab explicitly mentions enabling Defender for Servers Plan 2.
# The `azurerm_security_center_subscription_pricing` resource with `resource_type = "VirtualMachines"`
# corresponds to enabling the Defender for Servers plan.

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
```

## Reference
- [Official Lab Instructions](https://github.com/MicrosoftLearning/AZ500-AzureSecurityTechnologies/blob/master/Instructions/Labs/LAB_09_ConfiguringMicrosoftDefenderforCloudEnhancedSecurityFeaturesforServers.md)
