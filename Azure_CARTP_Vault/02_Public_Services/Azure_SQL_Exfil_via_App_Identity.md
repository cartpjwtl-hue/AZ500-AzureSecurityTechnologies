# Azure SQL Exfiltration via App Identity

## What it is
Attackers use a compromised app’s managed identity to access Azure SQL and exfiltrate data.

## Why attackers use it
- SQL often contains sensitive data
- MSI access is common
- SQL logs are often under-monitored

## How it works
1. Attacker compromises App Service or Function.
2. Extracts MSI token.
3. Authenticates to SQL using AAD auth.
4. Runs SELECT queries to extract data.

## Why it’s dangerous
- Full database exfiltration
- No SQL credentials needed
- Looks like app traffic

## Stealth & obfuscation
- Query slowly
- Use expected query patterns

## Detection
- SQL audit logs
- Unusual query patterns
- MSI identity accessing new tables

## Mitigation
- Restrict MSI SQL roles
- Use row-level security
- Monitor SQL AAD auth

## Related
- [[App_Service_to_Key_Vault_Pivot]]
- [[M365_File_Hosting_Exfil]]
