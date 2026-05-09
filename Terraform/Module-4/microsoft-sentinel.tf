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

variable "user_email" {
  description = "Email address for playbook configuration."
  type        = string
  default     = "your_email@example.com"
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

# Log Analytics Workspace (reusing from Lab 08 or creating new)
resource "azurerm_log_analytics_workspace" "law" {
  name                = "lgawIgnite-${random_string.suffix.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
}

# Microsoft Sentinel Workspace Connection
resource "azurerm_sentinel_log_analytics_workspace_onboarding" "sentinel_onboarding" {
  workspace_id = azurerm_log_analytics_workspace.law.id
}

# Azure Activity Data Connector (via Azure Policy Assignment)
# Note: Direct Terraform resource for Azure Activity connector via Policy is complex.
# The lab uses Azure Policy Assignment wizard. For Terraform, this would involve:
# 1. Defining an Azure Policy Definition for streaming Activity Logs to LA Workspace.
# 2. Assigning this policy to the subscription/resource group.
# This is a simplified representation.

# Placeholder for Azure Activity Data Connector (conceptual)
# resource "azurerm_sentinel_data_connector_azure_activity_log" "azure_activity_connector" {
#   name               = "AzureActivityConnector"
#   log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id
#   # Additional properties for policy assignment if available
# }

# Scheduled Analytics Rule (Example: Suspicious number of resource creation)
resource "azurerm_sentinel_alert_rule_scheduled" "suspicious_resource_creation" {
  name                    = "Suspicious number of resource creation or deployment"
  log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id
  display_name            = "Suspicious number of resource creation or deployment"
  severity                = "Medium"
  query                   = <<EOT
AzureActivity
| where OperationNameValue == "Microsoft.Resources/deployments/write"
| summarize count() by Caller, bin(TimeGenerated, 1h)
| where count_ > 5 // Example threshold
EOT
  query_frequency         = "PT1H"
  query_period            = "PT1H"
  trigger_operator        = "GreaterThan"
  trigger_threshold       = 0
  suppression_duration    = "PT1H"
  suppression_enabled     = false
  enabled                 = true

  # Tactics are defined in the lab as "Initial Access"
  tactics = ["InitialAccess"]
}

# Playbook (Azure Logic App) - Simplified representation
# The lab deploys a Logic App via ARM template. Terraform would define the Logic App resource.
# resource "azurerm_logic_app_workflow" "change_incident_severity_playbook" {
#   name                = "Change-Incident-Severity"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#   workflow_parameters = {
#     "username" = var.user_email
#   }
#   # ... workflow definition ...
# }
