# Data Factory & Linked Services

## What it is
Attackers abuse Azure Data Factory (ADF) linked services to extract secrets or pivot into downstream data stores.

## Why attackers use it
- Linked services store credentials
- ADF can access SQL, Storage, Key Vault, APIs
- Often misconfigured with broad permissions

## How it works
1. Attacker gains access to ADF.
2. Enumerates linked services.
3. Extracts credentials or Key Vault references.
4. Uses credentials to access data stores.

## Why it’s dangerous
- Direct access to sensitive data
- ADF logs rarely monitored
- Can pivot into multiple services

## Stealth & obfuscation
- Trigger pipelines manually but infrequently
- Use existing linked services

## Detection
- Manual pipeline triggers
- Linked service modifications
- Unusual data movement patterns

## Mitigation
- Use Key Vault for secrets
- Restrict ADF permissions
- Monitor pipeline executions

## Related
- [[Function_Logic_App_Misconfig]]
- [[Azure_SQL_Exfil_via_App_Identity]]
