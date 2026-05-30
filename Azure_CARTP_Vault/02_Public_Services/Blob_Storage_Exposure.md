# Blob Storage Exposure

## What it is
Misconfigured Azure Blob Storage containers expose sensitive data publicly or to overly broad identities.

## Why attackers use it
- Zero authentication required
- High chance of sensitive data exposure
- Easy to automate scanning
- Often overlooked by defenders

## How it works
1. Attacker enumerates storage accounts via DNS or subscription access.
2. Checks container ACLs (blob, container, anonymous).
3. Downloads exposed data (keys, logs, backups, code, secrets).
4. Uses exposed secrets to pivot deeper into Azure.

## Why it’s dangerous
- Credential leakage
- Source code exposure
- Data exfiltration
- Enables further compromise (SAS tokens, connection strings)

## Stealth & obfuscation
- Enumerate via public DNS only
- Slow, distributed scanning
- Use common user-agents

## Detection
- Storage analytics logs
- Anonymous access events
- Sudden spikes in blob reads

## Mitigation
- Disable anonymous access
- Use private endpoints
- Rotate exposed keys

## Related
- [[Storage_SAS_Misuse]]
- [[App_Service_SSRF_MSI_Abuse]]
