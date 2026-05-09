# Lab 01: Role-Based Access Control (RBAC)

## Overview
This lab demonstrates how to manage Azure users and groups and how to use role-based access control (RBAC) to assign roles to groups.

## Key Concepts
- **Microsoft Entra ID (formerly Azure AD)**: The identity and access management service.
- **RBAC Roles**: Permissions assigned to users, groups, or service principals.
- **Scope**: The level at which the role is applied (Management Group, Subscription, Resource Group, or Resource).

## Lab Steps Summary
1. **Create Users**: Create user accounts for Joseph Price, Isabel Garcia, and Dylan Williams.
2. **Create Groups**: Create security groups named "Senior Admins", "Junior Admins", and "Service Desk".
3. **Assign Members**: Add the created users to their respective groups.
4. **Assign Roles**: Assign the "Virtual Machine Contributor" role to the "Service Desk" group.

## Terraform Implementation
The following Terraform configuration can be used to automate the creation of these Entra ID resources.

```hcl
# Configure the Azure AD Provider
provider "azuread" {}

# Create Users
resource "azuread_user" "joseph" {
  user_principal_name = "joseph@${var.domain_name}"
  display_name        = "Joseph Price"
  password            = "Pa55w.rd1234"
}

resource "azuread_user" "isabel" {
  user_principal_name = "isabel@${var.domain_name}"
  display_name        = "Isabel Garcia"
  password            = "Pa55w.rd1234"
}

resource "azuread_user" "dylan" {
  user_principal_name = "dylan@${var.domain_name}"
  display_name        = "Dylan Williams"
  password            = "Pa55w.rd1234"
}

# Create Groups
resource "azuread_group" "senior_admins" {
  display_name     = "Senior Admins"
  security_enabled = true
  members          = [azuread_user.joseph.object_id]
}

resource "azuread_group" "junior_admins" {
  display_name     = "Junior Admins"
  security_enabled = true
  members          = [azuread_user.isabel.object_id]
}

resource "azuread_group" "service_desk" {
  display_name     = "Service Desk"
  security_enabled = true
  members          = [azuread_user.dylan.object_id]
}

# Role Assignment (Example at Subscription Level)
resource "azurerm_role_assignment" "service_desk_vm_contributor" {
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = "Virtual Machine Contributor"
  principal_id         = azuread_group.service_desk.object_id
}
```

## Reference
- [Official Lab Instructions](https://github.com/MicrosoftLearning/AZ500-AzureSecurityTechnologies/blob/master/Instructions/Labs/LAB_01_RBAC.md)
