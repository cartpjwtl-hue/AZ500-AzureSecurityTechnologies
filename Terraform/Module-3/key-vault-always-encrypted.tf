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
  default     = "AZ500Lab10"
}

variable "location" {
  description = "The Azure region where resources will be deployed."
  type        = string
  default     = "East US"
}

variable "sql_admin_password" {
  description = "The password for the SQL Server administrator."
  type        = string
  sensitive   = true
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

# Azure Key Vault
resource "azurerm_key_vault" "key_vault" {
  name                        = "az500kv-${random_string.suffix.result}"
  location                    = azurerm_resource_group.rg.location
  resource_group_name         = azurerm_resource_group.rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id # Current user/service principal

    key_permissions = [
      "Get", "List", "Create", "Delete", "Recover", "Backup", "Restore", "Purge", "Sign", "Verify", "Encrypt", "Decrypt", "WrapKey", "UnwrapKey"
    ]

    secret_permissions = [
      "Get", "List", "Set", "Delete", "Recover", "Backup", "Restore", "Purge"
    ]

    certificate_permissions = [
      "Get", "List", "Create", "Delete", "Recover", "Update", "Import", "ManageContacts", "ManageIssuers", "GetIssuers", "ListIssuers", "SetIssuers", "DeleteIssuers", "Purge"
    ]
  }
}

# Add a key to Key Vault
resource "azurerm_key_vault_key" "my_lab_key" {
  name         = "MyLabKey"
  key_vault_id = azurerm_key_vault.key_vault.id
  key_type     = "RSA"
  key_size     = 2048
  key_opts     = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]
}

# Add a secret to Key Vault
resource "azurerm_key_vault_secret" "sql_password" {
  name         = "SQLPassword"
  value        = var.sql_admin_password # Sensitive value, use variable
  key_vault_id = azurerm_key_vault.key_vault.id
}

# Azure SQL Server (simplified, assumes variables for admin login/password)
resource "azurerm_mssql_server" "sql_server" {
  name                         = "az500sqlserver-${random_string.suffix.result}"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = var.sql_admin_password
}

# Azure SQL Database
resource "azurerm_mssql_database" "sql_db" {
  name      = "AZ500LabDb"
  server_id = azurerm_mssql_server.sql_server.id
  sku_name  = "S0"
}

# Data source for current client configuration (for tenant_id and object_id)
data "azurerm_client_config" "current" {}
