# Lab 08: Create a Log Analytics Workspace, Azure Storage Account, and Data Collection Rule (DCR)

## Overview
This lab focuses on enhancing monitoring and security visibility for Azure Virtual Machines (VMs) by implementing Azure Monitor Agent (AMA) and Data Collection Rules (DCRs). The goal is to centralize log collection and performance monitoring from VMs into a Log Analytics Workspace, with an Azure Storage Account potentially used for archiving or other data operations.

## Key Concepts
- **Log Analytics Workspace**: A unique environment for Azure Monitor log data. It provides a geographic location for your data, data isolation, and scope for data retention, access control, and configurations.
- **Azure Monitor Agent (AMA)**: A unified agent that collects monitoring data from guest operating systems of Azure and non-Azure virtual machines and delivers it to Azure Monitor.
- **Data Collection Rule (DCR)**: Specifies what data to collect, how to transform it, and where to send it. DCRs are central to configuring data collection for AMA.
- **Azure Storage Account**: Used for storing various types of data, including logs, blobs, files, queues, and tables. In this lab, it's used in conjunction with DCRs for data collection.

## Lab Steps Summary
1.  **Deploy Azure Virtual Machine**: Provision an Azure VM to serve as the target for data collection.
2.  **Create Log Analytics Workspace**: Set up a Log Analytics Workspace (`lgawIgnite`) to store collected logs and metrics.
3.  **Create Azure Storage Account**: Create a storage account (`strgactignite`) for potential use with DCRs.
4.  **Create Data Collection Rule (DCR)**: Define a DCR (`DCR1`) to collect performance counters (CPU, Memory, Disk, Network) from the deployed VM and send them to the Log Analytics Workspace.

## Terraform Implementation

```hcl
# Resource Group (assuming it's already created or defined elsewhere)
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "law" {
  name                = "lgawIgnite-${random_string.suffix.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
}

# Azure Storage Account
resource "azurerm_storage_account" "storage_account" {
  name                     = "strgactignite${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Data Collection Rule
resource "azurerm_monitor_data_collection_rule" "dcr" {
  name                = "DCR1-${random_string.suffix.result}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  data_flow {
    streams      = ["Microsoft-Perf"]
    destinations = ["log_analytics_destination"]
  }

  destinations {
    log_analytics {
      name          = "log_analytics_destination"
      workspace_resource_id = azurerm_log_analytics_workspace.law.id
    }
  }

  data_sources {
    performance_counter {
      name                          = "cpu_memory_disk_network_perf_counters"
      streams                       = ["Microsoft-Perf"]
      sampling_frequency_in_seconds = 60
      counter_specifiers = [
        "\\Processor(_Total)\\ % Processor Time",
        "\\Memory\\ Available MBytes",
        "\\LogicalDisk(_Total)\\ % Free Space",
        "\\Network Interface(*)\\ Bytes Total/sec"
      ]
    }
  }

  # Note: The lab also deploys a VM. For a complete Terraform setup, 
  # you would also define the VM resource and associate the DCR with it.
  # Example association (requires VM resource definition):
  # resource "azurerm_monitor_data_collection_rule_association" "vm_dcr_association" {
  #   name                       = "vm-dcr-association"
  #   target_resource_id         = azurerm_windows_virtual_machine.vm.id
  #   data_collection_rule_id    = azurerm_monitor_data_collection_rule.dcr.id
  #   description                = "Association of DCR to VM"
  # }
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
  default     = "AZ500LAB131415"
}

variable "location" {
  description = "The Azure region where resources will be deployed."
  type        = string
  default     = "East US"
}
```

## Reference
- [Official Lab Instructions](https://github.com/MicrosoftLearning/AZ500-AzureSecurityTechnologies/blob/master/Instructions/Labs/LAB_08_CreateaLogAnalyticsworkspaceAzureStorageAccountDataCollectionRule(DCR).md)
