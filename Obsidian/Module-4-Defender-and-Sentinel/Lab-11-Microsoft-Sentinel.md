# Lab 11: Microsoft Sentinel

## Overview
This lab covers the onboarding of Microsoft Sentinel, connecting data sources, creating analytics rules, and automating responses using playbooks.

## Key Concepts
- **Microsoft Sentinel**: A cloud-native SIEM (Security Information and Event Management) and SOAR (Security Orchestration, Automation, and Response) solution.
- **Data Connectors**: Used to ingest data from various sources like Azure Activity, Microsoft Defender for Cloud, etc.
- **Analytics Rules**: Scheduled queries that search for specific events and create incidents.
- **Playbooks**: Logic Apps that automate response tasks when an alert is triggered.

## Lab Steps Summary
1. **On-board Microsoft Sentinel**: Add Sentinel to a Log Analytics workspace.
2. **Connect Data Sources**: Install and configure the "Azure Activity" data connector.
3. **Create Analytics Rules**:
   - Use built-in templates (e.g., "Suspicious number of resource creation").
   - Create a custom scheduled query rule.
4. **Create a Playbook**: Deploy a Logic App (e.g., `Change-Incident-Severity`) from a template.
5. **Configure Automated Response**: Link the playbook to an analytics rule.
6. **Test Incident**: Trigger an event that matches the rule and verify the playbook execution.

## Terraform Implementation

```hcl
# Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "law" {
  name                = "az500-sentinel-law-${random_string.suffix.result}"
  location            = var.location
  resource_group_name = var.resource_group
  sku                 = "PerGB2018"
}

# Microsoft Sentinel
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

# Sentinel Scheduled Alert Rule (Example)
resource "azurerm_sentinel_alert_rule_scheduled" "example" {
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
```

## Reference
- [Official Lab Instructions](https://github.com/MicrosoftLearning/AZ500-AzureSecurityTechnologies/blob/master/Instructions/Labs/LAB_11_Microsoft%20Sentinel.md)
