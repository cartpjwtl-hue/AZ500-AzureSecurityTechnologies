# Public Services — KQL Detection Pack

## 1. App Service SSRF → MSI Token Access
```kql
AppServiceHTTPLogs
| where csUriStem contains "127.0.0.1" and csUriStem contains "msi/token"
| project TimeGenerated, csUriStem, UserAgent, sIP
```

## 2. Storage SAS Token Abuse
```kql
StorageBlobLogs
| where AuthenticationType == "SAS"
| summarize Count=count(), IPs=make_set(cIP) by AccountName, Uri, TimeGenerated
| where Count > 100
```

## 3. Key Vault Secret Exfiltration via MSI
```kql
AzureDiagnostics
| where Category == "AuditEvent"
| where OperationName == "SecretGet"
| summarize Count=count(), Identities=make_set(Identity) by ResourceId, bin(TimeGenerated, 1h)
| where Count > 50
```

## 4. AKS Pod Token Abuse
```kql
AzureDiagnostics
| where Category == "kube-audit"
| where verb == "create" and objectRef.kind == "TokenRequest"
| project TimeGenerated, userAgent, sourceIPs, objectRef
```
