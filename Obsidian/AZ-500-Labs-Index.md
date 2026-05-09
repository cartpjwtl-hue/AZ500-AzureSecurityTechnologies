# AZ-500: Microsoft Azure Security Technologies - Lab Notes

This vault contains comprehensive study notes and Terraform configurations for the AZ-500 certification labs.

## Modules Overview

### [Module 1: Protect Identity and Access](./Module-1-Identity-and-Access/Lab-01-RBAC.md)
- **Lab 01**: Role-Based Access Control (RBAC)
- Focus: Managing users, groups, and role assignments in Microsoft Entra ID.

### [Module 2: Protect Network Infrastructure](./Module-2-Network-Infrastructure/Lab-02-NSGs-and-ASGs.md)
- **Lab 02**: Network Security Groups (NSGs) and Application Security Groups (ASGs)
- Focus: Virtual network security, traffic filtering, and network isolation.

### [Module 3: Protect Compute, Storage, and Databases](./Module-3-Compute-Storage-Databases/Lab-05-Securing-Azure-SQL-Database.md)
- **Lab 05**: Securing Azure SQL Database
- Focus: Data classification, auditing, and advanced threat protection for SQL databases.

### [Module 4: Strengthen Security Posture](./Module-4-Defender-and-Sentinel/Lab-11-Microsoft-Sentinel.md)
- **Lab 11**: Microsoft Sentinel
- Focus: SIEM/SOAR implementation, data connectors, analytics rules, and playbooks.

## Lab Infrastructure (Terraform)
Each module includes a `Terraform` directory with configurations to automate the setup of the lab environments.

- [Module 1 Terraform](../Terraform/Module-1/main.tf)
- [Module 2 Terraform](../Terraform/Module-2/main.tf)
- [Module 3 Terraform](../Terraform/Module-3/main.tf)
- [Module 4 Terraform](../Terraform/Module-4/main.tf)

## Study Resources
- [Official AZ-500 Study Guide](https://learn.microsoft.com/en-us/credentials/certifications/resources/study-guides/az-500)
- [Microsoft Learning Lab Repository](https://github.com/MicrosoftLearning/AZ500-AzureSecurityTechnologies)
