# Lab 05: Securing Azure SQL Database

## Overview
This lab focuses on implementing security features for Azure SQL Database, including Advanced Data Protection, Data Classification, and Auditing.

## Key Concepts
- **Microsoft Defender for SQL**: Provides advanced threat protection and vulnerability assessments.
- **Data Discovery & Classification**: Helps in identifying and labeling sensitive data for compliance (e.g., GDPR).
- **SQL Auditing**: Tracks database events and writes them to an audit log in an Azure storage account, Log Analytics workspace, or Event Hub.

## Lab Steps Summary
1. **Deploy SQL Database**: Use a template to provision an Azure SQL Server and Database.
2. **Enable Microsoft Defender for SQL**: Turn on advanced security features at the server level.
3. **Configure Data Classification**: Run the classification engine to discover sensitive columns and apply labels.
4. **Configure Auditing**:
   - Enable server-level auditing to a storage account.
   - Configure database-level auditing.
   - View audit logs in the Azure portal.

## Terraform Implementation

```hcl
# SQL Server
resource "azurerm_mssql_server" "sql_server" {
  name                         = "az500-sql-server-${random_string.suffix.result}"
  resource_group_name          = var.resource_group
  location                     = var.location
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = var.sql_password
}

# SQL Database
resource "azurerm_mssql_database" "sql_db" {
  name           = "AZ500LabDb"
  server_id      = azurerm_mssql_server.sql_server.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "BasePrice"
  max_size_gb    = 2
  sku_name       = "S0"
}

# Storage Account for Auditing
resource "azurerm_storage_account" "audit_storage" {
  name                     = "az500audit${random_string.suffix.result}"
  resource_group_name      = var.resource_group
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# SQL Server Auditing Policy
resource "azurerm_mssql_server_extended_auditing_policy" "sql_audit" {
  server_id               = azurerm_mssql_server.sql_server.id
  storage_endpoint        = azurerm_storage_account.audit_storage.primary_blob_endpoint
  storage_account_access_key = azurerm_storage_account.audit_storage.primary_access_key
  retention_in_days       = 5
}

# Microsoft Defender for Cloud (SQL)
resource "azurerm_mssql_server_security_alert_policy" "sql_alert" {
  resource_group_name = var.resource_group
  server_name         = azurerm_mssql_server.sql_server.name
  state               = "Enabled"
}
```

## Reference
- [Official Lab Instructions](https://github.com/MicrosoftLearning/AZ500-AzureSecurityTechnologies/blob/master/Instructions/Labs/LAB_05_SecuringAzureSQLDatabase.MD)
