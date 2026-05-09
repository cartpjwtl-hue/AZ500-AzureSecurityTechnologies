# Module 2: Protect Network Infrastructure in Azure - Teaching Template

## Module Overview
This module focuses on securing Azure network infrastructure. Students will learn how to implement network security controls such as Network Security Groups (NSGs), Application Security Groups (ASGs), and Azure Firewall to protect virtual networks and subnets from unauthorized access and threats.

## Learning Objectives
Upon completion of this module, students will be able to:
- Understand Azure virtual networking concepts and security best practices.
- Configure and manage Network Security Groups (NSGs) and Application Security Groups (ASGs).
- Deploy and configure Azure Firewall for centralized network security.
- Implement User Defined Routes (UDRs) to control network traffic flow.
- Secure network connectivity to Azure resources.

## Key Concepts to Cover
- **Virtual Networks (VNets)**: Isolated networks in Azure.
- **Subnets**: Logical subdivisions within a VNet.
- **Network Security Groups (NSGs)**: Layer 4 firewall that filters traffic to and from Azure resources.
- **Application Security Groups (ASGs)**: Group VMs by application workload to simplify NSG rule management.
- **Azure Firewall**: A managed, cloud-based network security service that protects your Azure Virtual Network resources.
- **Firewall Rules**: Network rule collections, application rule collections, and NAT rule collections.
- **User Defined Routes (UDRs)**: Custom routes to override Azure's default routing.
- **Service Endpoints**: Securely connect to Azure services directly from your VNet over the Azure backbone network.

## Lab Activities

### Lab Title: Lab 02: Network Security Groups (NSGs) and Application Security Groups (ASGs)

### Scenario
Students will configure NSGs and ASGs to control traffic flow between different subnets and application tiers within a virtual network. This will involve creating VMs, subnets, and applying security rules to restrict communication based on ports, protocols, and application groups.

### Step-by-Step Teaching Guide
1.  **Introduction to NSGs and ASGs**: Explain their purpose, how they differ, and when to use each.
2.  **Lab Setup (Terraform)**:
    - Guide students through deploying the basic lab environment using the provided Terraform script (`Module-2/nsg-asg.tf`).
    - Explain each resource in the Terraform script (VNet, subnets, VMs, NSGs, ASGs).
3.  **Task 1: Create a Virtual Network and Subnets**.
4.  **Task 2: Create NSGs and ASGs**.
5.  **Task 3: Configure Inbound and Outbound Security Rules**: Demonstrate how to allow/deny traffic based on IP addresses, service tags, and ASGs.
6.  **Task 4: Associate NSGs with Subnets/NICs**.
7.  **Task 5: Test Network Connectivity**: Verify that the rules are enforced as expected.

### Lab Title: Lab 03: Azure Firewall

### Scenario
Students will deploy and configure Azure Firewall to centralize network security for a virtual network. This will involve routing all outbound traffic through the firewall and defining application and network rules to control access to external resources.

### Step-by-Step Teaching Guide
1.  **Introduction to Azure Firewall**: Explain its capabilities, deployment models, and how it enhances network security.
2.  **Lab Setup (Terraform)**:
    - Guide students through deploying the basic lab environment using the provided Terraform script (`Module-2/firewall.tf`).
    - Explain each resource in the Terraform script (VNet, subnets, Azure Firewall, Route Table).
3.  **Task 1: Deploy Azure Firewall**: Walk through the deployment process and key configurations.
4.  **Task 2: Create a Default Route (UDR)**: Explain how to force traffic through the firewall using a UDR.
5.  **Task 3: Configure Application Rules**: Demonstrate creating FQDN-based rules (e.g., allowing `www.bing.com`).
6.  **Task 4: Configure Network Rules**: Show how to create IP/port/protocol-based rules (e.g., allowing DNS traffic).
7.  **Task 5: Test Firewall Functionality**: Verify that the rules are correctly applied and traffic is filtered as intended.

## Additional Resources
- [Azure Network Security Best Practices](https://learn.microsoft.com/en-us/azure/security/fundamentals/network-best-practices)
- [Azure Firewall Documentation](https://learn.microsoft.com/en-us/azure/firewall/)
- [Network Security Groups Documentation](https://learn.microsoft.com/en-us/azure/virtual-network/network-security-groups-overview)
