# Module 3: Protect Compute, Storage, and Databases - Teaching Template

## Module Overview
This module focuses on securing various Azure compute, storage, and database services. Students will learn how to implement security best practices for virtual machines, containers, storage accounts, and SQL databases, including encryption, access control, and threat protection.

## Learning Objectives
Upon completion of this module, students will be able to:
- Secure Azure Virtual Machines (VMs) and their associated resources.
- Implement security for Azure Container Registry (ACR) and Azure Kubernetes Service (AKS).
- Configure and secure Azure Storage accounts using service endpoints and network rules.
- Implement security features for Azure SQL Database, including Always Encrypted and Key Vault integration.

## Key Concepts to Cover
- **Virtual Machine Security**: Network isolation, patching, anti-malware, and disk encryption.
- **Container Security**: Image scanning, registry security, and AKS cluster hardening.
- **Azure Storage Security**: Access keys, Shared Access Signatures (SAS), service endpoints, private endpoints, and encryption.
- **Azure SQL Database Security**: Transparent Data Encryption (TDE), Always Encrypted, Azure Key Vault integration, and SQL auditing.
- **Azure Key Vault**: Centralized management of cryptographic keys, secrets, and certificates.

## Lab Activities

### Lab Title: Lab 04: Configuring and Securing ACR and AKS

### Scenario
Students will deploy and secure a containerized application using Azure Container Registry (ACR) and Azure Kubernetes Service (AKS). This involves building Docker images, pushing them to a private registry, deploying an AKS cluster, and configuring access between AKS and ACR.

### Step-by-Step Teaching Guide
1.  **Introduction to Container Security**: Discuss the security challenges and best practices for containerized applications.
2.  **ACR Overview**: Explain the role of ACR in a secure container pipeline.
3.  **AKS Overview**: Introduce AKS and its security features.
4.  **Lab Setup (Terraform)**:
    - Guide students through deploying the basic lab environment using the provided Terraform script (`Module-3/acr-aks.tf`).
    - Explain each resource in the Terraform script (ACR, AKS, role assignments).
5.  **Task 1: Create an Azure Container Registry**.
6.  **Task 2: Build and Push a Docker Image**: Demonstrate creating a simple Dockerfile and pushing the image to ACR.
7.  **Task 3: Create an Azure Kubernetes Service Cluster**.
8.  **Task 4: Grant AKS Access to ACR**: Explain how to configure permissions for AKS to pull images from ACR.
9.  **Task 5: Deploy and Test Services**: Deploy sample applications to AKS and verify internal/external access.

### Lab Title: Lab 05: Securing Azure SQL Database

### Scenario
Students will implement various security features for an Azure SQL Database, including Transparent Data Encryption (TDE), auditing, and threat detection. This lab emphasizes protecting sensitive data within the database.

### Step-by-Step Teaching Guide
1.  **Introduction to SQL Database Security**: Discuss common database vulnerabilities and Azure SQL security features.
2.  **Lab Setup (Terraform)**:
    - Guide students through deploying the basic lab environment using the provided Terraform script (`Module-3/sql-database.tf`).
    - Explain each resource in the Terraform script (SQL Server, SQL Database).
3.  **Task 1: Configure Firewall Rules**: Secure access to the SQL Server.
4.  **Task 2: Enable Transparent Data Encryption (TDE)**: Demonstrate enabling TDE for data at rest.
5.  **Task 3: Configure Auditing**: Set up auditing to track database events.
6.  **Task 4: Implement Advanced Threat Protection**: Enable ATP for anomaly detection.
7.  **Task 5: Data Masking**: Show how to mask sensitive data in query results.

### Lab Title: Lab 06: Service Endpoints and Securing Storage

### Scenario
Students will secure an Azure Storage account by restricting network access using service endpoints and Network Security Groups (NSGs). This ensures that only authorized virtual networks and subnets can access the storage account.

### Step-by-Step Teaching Guide
1.  **Introduction to Storage Security**: Discuss different ways to secure Azure Storage.
2.  **Service Endpoints Explained**: Detail how service endpoints work and their benefits.
3.  **Lab Setup (Terraform)**:
    - Guide students through deploying the basic lab environment using the provided Terraform script (`Module-3/storage-endpoints.tf`).
    - Explain each resource in the Terraform script (VNet, subnets, NSGs, Storage Account, service endpoint configuration).
4.  **Task 1: Create Virtual Network and Subnets**.
5.  **Task 2: Configure Service Endpoint for Storage**: Enable the service endpoint on a specific subnet.
6.  **Task 3: Configure NSGs**: Create NSG rules to allow/deny traffic to the storage account from different subnets.
7.  **Task 4: Create Storage Account with Network Rules**: Configure the storage account to only allow traffic from the service endpoint enabled subnet.
8.  **Task 5: Test Access**: Verify that access is granted from the authorized subnet and denied from others.

### Lab Title: Lab 07: Key Vault (Implementing Secure Data by setting up Always Encrypted)

### Scenario
Students will integrate Azure Key Vault with Azure SQL Database to implement Always Encrypted, protecting sensitive data within the database. This involves managing encryption keys in Key Vault and configuring the database for client-side encryption.

### Step-by-Step Teaching Guide
1.  **Introduction to Always Encrypted**: Explain the concept of client-side encryption and its benefits.
2.  **Key Vault Integration**: Discuss how Key Vault secures the Column Master Keys.
3.  **Lab Setup (Terraform)**:
    - Guide students through deploying the basic lab environment using the provided Terraform script (`Module-3/key-vault-always-encrypted.tf`).
    - Explain each resource in the Terraform script (Key Vault, SQL Server, SQL Database, key/secret creation).
4.  **Task 1: Deploy Base Infrastructure**: Set up the VM and SQL Database.
5.  **Task 2: Configure Key Vault**: Create Key Vault, add keys and secrets, and set access policies.
6.  **Task 3: Implement Always Encrypted**: Configure CMK and CEK in SQL Database.
7.  **Task 4: Demonstrate Data Encryption**: Show how data is encrypted/decrypted from an application.

## Additional Resources
- [Azure Security Best Practices for Compute](https://learn.microsoft.com/en-us/azure/security/fundamentals/compute-best-practices)
- [Azure Storage Security Guide](https://learn.microsoft.com/en-us/azure/storage/blobs/security-recommendations)
- [Azure SQL Database Security Capabilities](https://learn.microsoft.com/en-us/azure/azure-sql/database/security-overview)
- [Azure Key Vault Documentation](https://learn.microsoft.com/en-us/azure/key-vault/general/overview)
