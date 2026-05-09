# Module 1: Protect Identity and Access in Azure - Teaching Template

## Module Overview
This module focuses on the fundamental principles and practical implementation of identity and access management within Azure. Students will learn how to secure access to Azure resources by managing users, groups, and roles, and by implementing advanced identity protection features.

## Learning Objectives
Upon completion of this module, students will be able to:
- Understand the core concepts of Microsoft Entra ID (formerly Azure Active Directory).
- Implement and manage Role-Based Access Control (RBAC) in Azure.
- Configure and manage Microsoft Entra ID identities and groups.
- Implement multi-factor authentication (MFA) and conditional access policies.
- Secure privileged access using Privileged Identity Management (PIM).

## Key Concepts to Cover
- **Microsoft Entra ID**: The cloud-based identity and access management service.
- **Users and Groups**: Creation, management, and synchronization.
- **Role-Based Access Control (RBAC)**: Assigning permissions at different scopes (management group, subscription, resource group, resource).
- **Custom Roles**: Defining granular permissions beyond built-in roles.
- **Conditional Access**: Implementing policies based on user, device, location, and application conditions.
- **Multi-Factor Authentication (MFA)**: Enhancing security with multiple verification methods.
- **Privileged Identity Management (PIM)**: Just-in-time and just-enough access for privileged roles.
- **Managed Identities**: Securing service-to-service communication.

## Lab Activities (Lab 01: RBAC)

### Lab Title: Lab 01: Role-Based Access Control (RBAC)

### Scenario
Students will be presented with a scenario requiring them to implement RBAC to grant specific permissions to users or groups for Azure resources. This will involve creating a resource group, a virtual machine, and then assigning a custom role or a built-in role with least privilege principles.

### Step-by-Step Teaching Guide
1.  **Introduction to RBAC**: Explain what RBAC is, why it's important, and its core components (security principal, role definition, scope).
2.  **Demonstrate Built-in Roles**: Show examples of common built-in roles (Owner, Contributor, Reader) and their permissions.
3.  **Lab Setup (Terraform)**:
    - Guide students through deploying the basic lab environment using the provided Terraform script (`Module-1/rbac.tf`).
    - Explain each resource in the Terraform script (resource group, virtual machine).
4.  **Task 1: Create a Resource Group and a Virtual Machine** (if not done by Terraform).
5.  **Task 2: Assign a Built-in Role**:
    - Walk through assigning the 
