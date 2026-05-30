# Azure Backup & Soft Delete Abuse

## What it is
Attackers disable or manipulate Azure Backup and Soft Delete to destroy recovery points and enable ransomware-style attacks.

## Why attackers use it
- Eliminates recovery options
- Enables destructive operations
- Often overlooked in cloud IR

## How it works
1. Attacker gains subscription-level access.
2. Disables Soft Delete or Backup Vault protections.
3. Deletes backup items and recovery points.
4. Performs destructive actions on resources.

## Why it’s dangerous
- Permanent data loss
- Enables ransomware in cloud environments
- Hard to recover without offline backups

## Stealth & obfuscation
- Disable protections gradually
- Delete backups during maintenance windows

## Detection
- Backup policy modifications
- Soft Delete disable events
- Sudden loss of recovery points

## Mitigation
- Lock Backup Vaults
- Enable immutable backups
- Monitor backup configuration changes

## Related
- [[Storage_Account_Takeover]]
- [[Role_Assignment_Abuse]]
