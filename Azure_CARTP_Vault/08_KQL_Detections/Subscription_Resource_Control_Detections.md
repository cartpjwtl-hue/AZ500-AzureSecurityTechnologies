# Subscription & Resource Control — KQL Detection Pack

## 1. VM Extension Deployment
```kql
AzureActivity
| where OperationNameValue == "Microsoft.Compute/virtualMachines/extensions/write"
| project TimeGenerated, Caller, ResourceGroup, ResourceId
```

## 2. Backup Vault Soft Delete Disabled
```kql
AzureActivity
| where OperationNameValue contains "backupVaults" and ActivityStatusValue == "Success"
| where Properties has "softDelete" and Properties has "false"
| project TimeGenerated, Caller, ResourceId
```

## 3. Role Assignment Abuse
```kql
AzureActivity
| where OperationNameValue == "Microsoft.Authorization/roleAssignments/write"
| project TimeGenerated, Caller, Claims, ResourceId
```
