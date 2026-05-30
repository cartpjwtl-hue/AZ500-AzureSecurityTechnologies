# App Service → Key Vault Pivot

## What it is
Attackers compromise an App Service and use its managed identity to access Key Vault.

## Why attackers use it
- Key Vault often contains secrets for SQL, Storage, Redis, APIs, service principals
- One of the most common real-world pivots

## How it works
1. Attacker compromises App Service (RCE, SSRF, code injection).
2. Extracts MSI token.
3. Calls Key Vault with MSI token.
4. Extracts secrets and connection strings.
5. Pivots into downstream services.

## Why it’s dangerous
- Full secret compromise
- Cascading pivots
- Hard to detect

## Stealth & obfuscation
- Replay MSI token from Azure IPs
- Use same user-agent as app

## Detection
- Key Vault access from unexpected identities
- Sudden spike in secret reads

## Mitigation
- Restrict Key Vault access
- Use Key Vault firewall + private endpoints
- Rotate secrets

## Related
- [[App_Service_SSRF_MSI_Abuse]]
- [[Azure_SQL_Exfil_via_App_Identity]]
