# Hybrid Identity — KQL Detection Pack

## 1. AAD Connect Sync Rule Modification
```kql
AuditLogs
| where OperationName == "Update synchronization rule"
| project TimeGenerated, InitiatedBy, TargetResources
```

## 2. PTA Agent Tampering
```kql
AADPTALogs
| where Status != "Healthy"
| project TimeGenerated, AgentId, Status, ErrorCode
```

## 3. Seamless SSO Kerberos Key Abuse
```kql
SecurityEvent
| where Account contains "AZUREADSSOACC"
| where EventID in (4769, 4770)
| project TimeGenerated, Account, IpAddress, TicketOptions
```
