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

variable "resource_group" {
  default = "AZ500LAB131415"
}

variable "location" {
  default = "East US"
}

resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

# Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "law" {
  name                = "az500-sentinel-law-${random_string.suffix.result}"
  location            = var.location
  resource_group_name = var.resource_group
  sku                 = "PerGB2018"
}

# Microsoft Sentinel Solution
resource "azurerm_log_analytics_solution" "sentinel" {
  solution_name         = "SecurityInsights"
  location              = var.location
  resource_group_name   = var.resource_group
  workspace_resource_id = azurerm_log_analytics_workspace.law.id
  workspace_name        = azurerm_log_analytics_workspace.law.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/SecurityInsights"
  }
}

# Azure Activity Data Connector
resource "azurerm_sentinel_data_connector_azure_activity" "activity" {
  name                       = "activity-connector"
  log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id
}

# Sentinel Scheduled Alert Rule
resource "azurerm_sentinel_alert_rule_scheduled" "suspicious_deployments" {
  name                       = "Suspicious-Resource-Creation"
  log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id
  display_name               = "Suspicious Resource Creation"
  severity                   = "Medium"
  query                      = <<QUERY
AzureActivity
| where OperationNameValue == "Microsoft.Resources/deployments/write"
| where ActivityStatusValue == "Succeeded"
| summarize count() by Caller
| where count > 10
QUERY
  query_frequency            = "PT5M"
  query_period               = "PT5M"
  trigger_operator           = "GreaterThan"
  trigger_threshold          = 0
}
