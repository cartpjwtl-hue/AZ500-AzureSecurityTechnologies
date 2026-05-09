# Module 4: Strengthen Security Posture using Microsoft Defender for Cloud and Microsoft Sentinel - Teaching Template

## Module Overview
This module focuses on leveraging Microsoft Defender for Cloud and Microsoft Sentinel to enhance the security posture of Azure environments. Students will learn how to implement threat protection, security monitoring, and incident response capabilities across their cloud resources.

## Learning Objectives
Upon completion of this module, students will be able to:
- Configure and manage Microsoft Defender for Cloud for various Azure resources.
- Implement Just-in-Time (JIT) VM access to reduce the attack surface of virtual machines.
- Deploy and configure Log Analytics Workspaces and Data Collection Rules (DCRs) for centralized logging.
- Understand the capabilities of Microsoft Sentinel for Security Information and Event Management (SIEM) and Security Orchestration, Automation, and Response (SOAR).
- Create analytics rules, playbooks, and workbooks in Microsoft Sentinel for threat detection and response.

## Key Concepts to Cover
- **Microsoft Defender for Cloud**: Unified security management and threat protection for hybrid cloud workloads.
- **Security Posture Management**: Continuous assessment and improvement of security configurations.
- **Cloud Workload Protection (CWP)**: Protecting various types of workloads (VMs, containers, databases) from threats.
- **Just-in-Time (JIT) VM Access**: Reducing VM exposure by opening management ports only when needed.
- **Log Analytics Workspace**: Centralized repository for log data from various Azure and on-premises sources.
- **Azure Monitor Agent (AMA)** and **Data Collection Rules (DCR)**: Flexible data collection for Azure Monitor.
- **Microsoft Sentinel**: A scalable, cloud-native, security information and event management (SIEM) and security orchestration, automation, and response (SOAR) solution.
- **Data Connectors**: Ingesting security data into Sentinel.
- **Analytics Rules**: Detecting threats and generating incidents in Sentinel.
- **Playbooks**: Automating responses to security incidents.
- **Workbooks**: Visualizing security data and incidents.

## Lab Activities

### Lab Title: Lab 08: Create a Log Analytics Workspace, Azure Storage Account, and Data Collection Rule (DCR)

### Scenario
Students will set up the foundational components for security monitoring by deploying a Log Analytics Workspace, an Azure Storage Account, and configuring a Data Collection Rule (DCR) to collect performance data from a virtual machine. This lab emphasizes data ingestion for security analysis.

### Step-by-Step Teaching Guide
1.  **Introduction to Azure Monitoring**: Discuss the importance of logging and monitoring for security.
2.  **Log Analytics Workspace**: Explain its role as a central log repository.
3.  **AMA and DCRs**: Detail how AMA collects data and DCRs define what and where to send it.
4.  **Lab Setup (Terraform)**:
    - Guide students through deploying the basic lab environment using the provided Terraform script (`Module-4/log-analytics-storage-dcr.tf`).
    - Explain each resource in the Terraform script (Log Analytics Workspace, Storage Account, DCR).
5.  **Task 1: Deploy an Azure Virtual Machine**: (Pre-requisite or deployed via Terraform).
6.  **Task 2: Create a Log Analytics Workspace**.
7.  **Task 3: Create an Azure Storage Account**.
8.  **Task 4: Create a Data Collection Rule (DCR)**: Configure the DCR to collect performance counters and link it to the Log Analytics Workspace.

### Lab Title: Lab 09: Configuring Microsoft Defender for Cloud Enhanced Security Features for Servers

### Scenario
Students will enable and configure Microsoft Defender for Servers within Microsoft Defender for Cloud to provide advanced threat protection and security monitoring for Azure VMs. This lab focuses on strengthening the security posture of compute resources.

### Step-by-Step Teaching Guide
1.  **Introduction to Microsoft Defender for Cloud**: Overview of its CSPM and CWP capabilities.
2.  **Defender for Servers**: Explain the benefits and features of this plan.
3.  **Lab Setup (Terraform)**:
    - Guide students through enabling the Defender for Servers plan using the provided Terraform script (`Module-4/defender-for-cloud-servers.tf`).
    - Explain the `azurerm_security_center_subscription_pricing` resource.
4.  **Task 1: Navigate to Microsoft Defender for Cloud**.
5.  **Task 2: Enable Defender for Servers Plan**: Walk through the steps to activate the plan for the subscription.
6.  **Task 3: Review Enhanced Features**: Discuss the security capabilities provided by Defender for Servers Plan 2.

### Lab Title: Lab 10: Enable Just-in-Time access on VMs

### Scenario
Students will implement Just-in-Time (JIT) VM access to reduce the attack surface of Azure Virtual Machines. This lab demonstrates how to control and limit network access to management ports, thereby mitigating brute-force attacks and unauthorized access.

### Step-by-Step Teaching Guide
1.  **Introduction to JIT VM Access**: Explain the concept, its security benefits, and how it works with NSGs.
2.  **Lab Setup (Terraform)**:
    - Guide students through deploying a VM and configuring JIT access using the provided Terraform script (`Module-4/jit-vm-access.tf`).
    - Explain the `azurerm_security_center_jit_network_access_policy` resource.
3.  **Task 1: Enable JIT on VMs**: Configure JIT access for a target VM.
4.  **Task 2: Review JIT Settings**: Examine the default and configurable parameters (ports, duration, source IPs).
5.  **Task 3: Request Access**: Demonstrate the process of requesting and gaining temporary access to a JIT-protected VM.

### Lab Title: Lab 11: Microsoft Sentinel

### Scenario
Students will deploy and configure Microsoft Sentinel as a cloud-native SIEM/SOAR solution. This lab will cover connecting data sources, creating analytics rules for threat detection, and exploring incident management capabilities.

### Step-by-Step Teaching Guide
1.  **Introduction to SIEM/SOAR**: Explain the role of SIEM and SOAR in modern security operations.
2.  **Microsoft Sentinel Overview**: Discuss its architecture, capabilities, and benefits.
3.  **Lab Setup (Terraform)**:
    - Guide students through deploying Microsoft Sentinel and connecting data sources using the provided Terraform script (`Module-4/microsoft-sentinel.tf`).
    - Explain resources like `azurerm_log_analytics_workspace`, `azurerm_sentinel_data_connector_azure_active_directory`, `azurerm_sentinel_alert_rule_scheduled`.
4.  **Task 1: Deploy Microsoft Sentinel**: Provision a Sentinel workspace.
5.  **Task 2: Connect Data Sources**: Configure data connectors (e.g., Azure Activity, Microsoft Entra ID, Microsoft 365).
6.  **Task 3: Create Analytics Rules**: Define custom rules to detect specific threats or anomalies.
7.  **Task 4: Investigate Incidents**: Explore incident management, playbooks, and workbooks for response.

## Additional Resources
- [Microsoft Defender for Cloud Documentation](https://learn.microsoft.com/en-us/azure/defender-for-cloud/)
- [Microsoft Sentinel Documentation](https://learn.microsoft.com/en-us/azure/sentinel/)
- [Azure Monitor Documentation](https://learn.microsoft.com/en-us/azure/azure-monitor/overview)
