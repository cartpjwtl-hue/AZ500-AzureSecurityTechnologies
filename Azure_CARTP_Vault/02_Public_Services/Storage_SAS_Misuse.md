# Storage SAS Misuse

## What it is
Attackers abuse Shared Access Signatures (SAS tokens) to access or exfiltrate data.

## Why attackers use it
- SAS tokens bypass RBAC
- Often long-lived
- Hard to revoke
- Frequently embedded in logs, URLs, code

## How it works
1. Attacker finds SAS token (logs, code, GitHub, exposed URLs).
2. Uses token to read/write/delete blobs.
3. Exfiltrates data or overwrites backups.

## Why it’s dangerous
- Full data access without authentication
- No identity logs
- Hard to detect

## Stealth & obfuscation
- Use SAS token from expected regions
- Low-volume reads

## Detection
- Storage logs with SAS authentication
- Unusual IPs using SAS tokens

## Mitigation
- Use short-lived SAS
- Prefer Azure AD auth
- Rotate tokens regularly

## Related
- [[Blob_Storage_Exposure]]
- [[Azure_Backup_and_Soft_Delete_Abuse]]
