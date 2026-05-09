terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azuread" {}
provider "azurerm" {
  features {}
}

variable "domain_name" {
  description = "The primary domain of the Entra ID tenant"
  type        = string
}

data "azurerm_subscription" "primary" {}

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

# Role Assignment
resource "azurerm_role_assignment" "service_desk_vm_contributor" {
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = "Virtual Machine Contributor"
  principal_id         = azuread_group.service_desk.object_id
}
