# CI/CD — KQL Detection Pack

## 1. Azure DevOps — Suspicious Pipeline Modification
```kql
AzureDevOpsAuditing
| where OperationName == "PipelineModified"
| project TimeGenerated, ActorUPN, PipelineName, IPAddress
```

## 2. GitHub Actions — OIDC Token Abuse
```kql
AADNonInteractiveUserSignInLogs
| where AppDisplayName contains "GitHub"
| where AuthenticationRequirement == "none"
| project TimeGenerated, UserPrincipalName, IPAddress, AppDisplayName
```

## 3. PAT Abuse — New IP Usage
```kql
AzureDevOpsAuditing
| where OperationName == "TokenAuthentication"
| summarize IPs=make_set(IPAddress) by ActorUPN
| where array_length(IPs) > 1
```
