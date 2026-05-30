# App Service SSRF → MSI Abuse

## What it is
Attackers exploit SSRF vulnerabilities in Azure App Service to steal Managed Identity (MSI) tokens.

## Why attackers use it
- MSI tokens grant access to Key Vault, Storage, SQL, etc.
- No credentials required
- High-privilege pivots possible

## How it works
1. Attacker finds SSRF in App Service app.
2. Targets MSI endpoint: http://127.0.0.1:41741/msi/token.
3. Extracts access token.
4. Uses token to access Azure resources.

## Why it’s dangerous
- Direct access to Key Vault
- Subscription-level pivots
- Full compromise of downstream services

## Stealth & obfuscation
- Use same user-agent as app
- Replay from Azure IP ranges

## Detection
- App Service logs showing unusual localhost calls
- MSI token requests from unexpected paths

## Mitigation
- Disable local MSI endpoint when not needed
- Validate outbound URLs
- Use App Service Access Restrictions

## Related
- [[App_Service_to_Key_Vault_Pivot]]
- [[Function_Logic_App_Misconfig]]
