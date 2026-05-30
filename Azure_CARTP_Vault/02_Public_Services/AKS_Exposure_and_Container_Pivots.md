# AKS Exposure & Container Pivots

## What it is
Attackers exploit exposed Kubernetes components or weak RBAC in Azure Kubernetes Service (AKS).

## Why attackers use it
- Container → node → subscription pivots
- Access to secrets, images, workloads
- MSI tokens inside pods

## How it works
1. Attacker finds exposed Kube API or dashboard.
2. Gains pod exec or cluster-admin.
3. Extracts MSI tokens from pod metadata.
4. Uses tokens to access Azure resources.

## Why it’s dangerous
- Full cluster compromise
- Subscription-level access
- Key Vault/Storage pivots

## Stealth & obfuscation
- Use kubectl with common user-agents
- Blend with normal pod exec patterns

## Detection
- Kube API audit logs
- Unexpected pod exec events
- MSI token requests from pods

## Mitigation
- Disable public API
- Use Azure AD RBAC
- Restrict pod MSI access

## Related
- [[App_Service_SSRF_MSI_Abuse]]
- [[App_Service_to_Key_Vault_Pivot]]
