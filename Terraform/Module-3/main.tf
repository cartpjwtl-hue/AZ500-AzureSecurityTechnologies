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
  default = "AZ500LAB11"
}

variable "location" {
  default = "East US"
}

variable "sql_password" {
  description = "The password for the SQL administrator"
  type        = string
  sensitive   = true
}

resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

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
  server_id                  = azurerm_mssql_server.sql_server.id
  storage_endpoint           = azurerm_storage_account.audit_storage.primary_blob_endpoint
  storage_account_access_key = azurerm_storage_account.audit_storage.primary_access_key
  retention_in_days          = 5
}

# Microsoft Defender for Cloud (SQL)
resource "azurerm_mssql_server_security_alert_policy" "sql_alert" {
  resource_group_name = var.resource_group
  server_name         = azurerm_mssql_server.sql_server.name
  state               = "Enabled"
}
