# Identity & OAuth — KQL Detection Pack

## 1. Illicit Consent Grant — New OAuth App with High-Risk Scopes
```kql
AuditLogs
| where OperationName == "Add OAuth2PermissionGrant"
| extend Scope = tostring(TargetResources[0].modifiedProperties[?].newValue)
| where Scope has_any ("Mail.", "Files.", "Directory.", "offline_access")
| project TimeGenerated, InitiatedBy, Scope, TargetResources
```

## 2. Malicious App Registration — Suspicious Service Principal Creation
```kql
AuditLogs
| where OperationName == "Add service principal"
| where tostring(TargetResources[0].displayName) matches regex @"(?i)(microsoft|office|azure|sharepoint|teams)[^a-z0-9]"
| project TimeGenerated, InitiatedBy, TargetResources
```

## 3. Refresh Token Theft — Impossible Travel + Token Replay
```kql
SigninLogs
| where ResultType == 0
| summarize FirstSeen=min(TimeGenerated), LastSeen=max(TimeGenerated), Countries=make_set(LocationDetails.country) by UserPrincipalName, DeviceDetail
| where array_length(Countries) > 1
```

## 4. Legacy Auth Abuse — IMAP/POP/SMTP Sign-ins
```kql
SigninLogs
| where ClientAppUsed in ("IMAP", "POP", "SMTP")
| project TimeGenerated, UserPrincipalName, IPAddress, ClientAppUsed
```
