# Persistence — KQL Detection Pack

## 1. New SPN Credential Added
```kql
AuditLogs
| where OperationName == "Add service principal credentials"
| project TimeGenerated, InitiatedBy, TargetResources
```

## 2. OAuth2PermissionGrant Modification
```kql
AuditLogs
| where OperationName == "Update OAuth2PermissionGrant"
| project TimeGenerated, InitiatedBy, TargetResources
```

## 3. Automation Account Runbook Creation
```kql
AzureActivity
| where OperationNameValue == "Microsoft.Automation/automationAccounts/runbooks/write"
| project TimeGenerated, Caller, ResourceId
```
