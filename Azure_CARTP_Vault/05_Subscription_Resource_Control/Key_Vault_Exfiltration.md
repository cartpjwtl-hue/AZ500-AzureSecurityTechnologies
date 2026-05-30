# Key Vault Exfiltration

## What it is
Attackers extract secrets, certificates, and keys from Azure Key Vault using compromised identities or managed identities.

## Why attackers use it
- Key Vault stores high-value secrets
- MSI access is common and often over-permissive
- Secrets enable further pivots

## How it works
1. Attacker compromises identity with Key Vault access.
2. Enumerates secrets, keys, and certificates.
3. Extracts values via Key Vault API.
4. Uses secrets to access downstream services.

## Why it’s dangerous
- Full compromise of application secrets
- Cascading pivots into SQL, Storage, APIs
- Hard to detect secret reads

## Stealth & obfuscation
- Read secrets slowly
- Use expected user-agents
- Replay from Azure IP ranges

## Detection
- Sudden spike in secret reads
- Access from unexpected identities
- Key Vault firewall bypass attempts

## Mitigation
- Restrict Key Vault access
- Use private endpoints
- Rotate secrets regularly

## Related
- [[App_Service_to_Key_Vault_Pivot]]
- [[Storage_Account_Takeover]]
