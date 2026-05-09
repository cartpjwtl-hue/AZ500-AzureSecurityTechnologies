terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
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

resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

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
}
