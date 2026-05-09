# Lab 07: Key Vault (Implementing Secure Data by setting up Always Encrypted)

## Overview
This lab demonstrates how to use Azure Key Vault to secure cryptographic keys and secrets, and how to implement Always Encrypted for Azure SQL Database to protect sensitive data at rest and in transit. The lab also involves integrating an application with Key Vault and SQL Database.

## Key Concepts
- **Azure Key Vault**: A cloud service for securely storing and accessing secrets, keys, and certificates. It helps in protecting cryptographic keys and other secrets used by cloud applications and services.
- **Always Encrypted**: A feature in Azure SQL Database that protects sensitive data, enabling clients to encrypt sensitive data inside client applications and never reveal the encryption keys to the database engine.
- **Column Master Key (CMK)**: A data encryption key that encrypts other data encryption keys. Stored in Key Vault.
- **Column Encryption Key (CEK)**: Encrypts the actual data in the database columns. Encrypted by the CMK.

## Lab Steps Summary
1.  **Deploy Base Infrastructure**: Deploy an Azure VM (with Visual Studio and SQL Server Management Studio) and an Azure SQL Database using ARM templates.
2.  **Configure Key Vault**: Create an Azure Key Vault, define access policies, and add a software-protected key (`MyLabKey`) and a secret (`SQLPassword`).
3.  **Configure Azure SQL Database**: Set up the SQL Database for Always Encrypted, which involves creating Column Master Keys (CMK) and Column Encryption Keys (CEK).
4.  **Demonstrate Always Encrypted**: Use the deployed VM and tools to demonstrate how Always Encrypted works, including encrypting database columns and accessing encrypted data from an application.

## Terraform Implementation

```hcl
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

# Random string for unique naming
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
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
```

## Reference
- [Official Lab Instructions](https://github.com/MicrosoftLearning/AZ500-AzureSecurityTechnologies/blob/master/Instructions/Labs/LAB_07_KeyVaultImplementingSecureDatabysettingupAlwaysEncrypted.md)
