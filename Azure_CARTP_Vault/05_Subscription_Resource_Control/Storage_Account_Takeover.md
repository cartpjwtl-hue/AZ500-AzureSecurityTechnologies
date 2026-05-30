# Storage Account Takeover

## What it is
Attackers gain control of Azure Storage Accounts via RBAC misconfigurations, key extraction, or SAS token abuse.

## Why attackers use it
- Storage contains logs, backups, code, secrets
- Keys grant full control
- SAS tokens bypass RBAC

## How it works
1. Attacker gains Storage Account Contributor/Owner.
2. Extracts access keys or generates SAS tokens.
3. Reads, writes, or deletes blob/file/table data.
4. Uses stored secrets to pivot.

## Why it’s dangerous
- Full data exfiltration
- Backup destruction
- Malware distribution via public blobs

## Stealth & obfuscation
- Use SAS tokens with narrow scopes
- Access during normal hours

## Detection
- Key regeneration events
- SAS token usage from unusual IPs
- Blob access anomalies

## Mitigation
- Use Azure AD auth instead of keys
- Rotate keys frequently
- Restrict SAS token creation

## Related
- [[Storage_SAS_Misuse]]
- [[Azure_Backup_and_Soft_Delete_Abuse]]
