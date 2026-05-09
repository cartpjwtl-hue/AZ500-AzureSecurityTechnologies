# Lab 04: Configuring and Securing Azure Container Registry (ACR) and Azure Kubernetes Service (AKS)

## Overview
This lab demonstrates how to deploy a proof of concept using Azure Container Registry (ACR) for image storage and Azure Kubernetes Service (AKS) for container orchestration. It covers building Docker images, pushing them to ACR, creating an AKS cluster, and deploying both external and internal services.

## Key Concepts
- **Azure Container Registry (ACR)**: A managed, private Docker registry service in Azure for storing and managing container images.
- **Azure Kubernetes Service (AKS)**: A managed Kubernetes service that simplifies deploying, managing, and scaling containerized applications.
- **Dockerfile**: A text file that contains all the commands a user could call on the command line to assemble an image.
- **Kubectl**: The command-line tool for running commands against Kubernetes clusters.
- **Service Principal**: An identity created for use with applications, hosted services, and automated tools to access Azure resources.

## Lab Steps Summary
1. **Create ACR**: Provision an Azure Container Registry instance.
2. **Build and Push Image**: Create a Dockerfile, build an Nginx image, and push it to the ACR.
3. **Create AKS Cluster**: Deploy an Azure Kubernetes Service cluster.
4. **Grant AKS Permissions**: Configure the AKS cluster to access the ACR and manage its virtual network.
5. **Deploy External Service**: Deploy a containerized application as an external service to AKS.
6. **Verify External Access**: Confirm that the external AKS-hosted service is accessible.
7. **Deploy Internal Service**: Deploy a containerized application as an internal service to AKS.
8. **Verify Internal Access**: Confirm that the internal AKS-hosted service is accessible.

## Terraform Implementation

```hcl
# Resource Group (assuming it's already created or defined elsewhere)
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Azure Container Registry
resource "azurerm_container_registry" "acr" {
  name                = "az500acr${random_string.suffix.result}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = true
}

# Azure Kubernetes Service Cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "MyKubernetesCluster"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "myakscluster"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin     = "azure"
    load_balancer_sku  = "Standard"
    dns_service_ip     = "10.0.0.10"
    docker_bridge_cidr = "172.17.0.1/16"
    service_cidr       = "10.0.0.0/16"
  }

  tags = {
    Environment = "Production"
  }
}

# Grant AKS access to ACR
resource "azurerm_role_assignment" "acr_pull" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}

# Random string for unique naming
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  default     = "AZ500LAB09"
}

variable "location" {
  description = "The Azure region where resources will be deployed."
  type        = string
  default     = "East US"
}
```

## Reference
- [Official Lab Instructions](https://github.com/MicrosoftLearning/AZ500-AzureSecurityTechnologies/blob/master/Instructions/Labs/LAB_04_ConfiguringandSecuringACRandAKS.MD)
