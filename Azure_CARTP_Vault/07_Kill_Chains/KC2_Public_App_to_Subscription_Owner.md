# KC2: Public App → Subscription Owner

## Summary
Attacker compromises a public-facing Azure App Service and pivots into the subscription using MSI tokens.

## Phase 1: Initial Access
- Exploit SSRF or RCE in App Service
- Access local MSI endpoint
- Extract access token

## Phase 2: Foothold
- Use MSI token to enumerate Key Vault
- Extract secrets for SQL, Storage, APIs

## Phase 3: Privilege Escalation
- Use secrets to access downstream services
- Identify over-permissive managed identities
- Pivot into Automation Accounts or ADF

## Phase 4: Subscription Takeover
- Use Automation Account MSI to assign RBAC roles
- Gain Contributor or Owner on subscription

## Phase 5: Persistence
- Deploy VM extensions to install RATs
- Create backdoor service principals

## Phase 6: Impact
- Full subscription control
- Ability to deploy malicious infrastructure

## Related
- [[App_Service_SSRF_MSI_Abuse]]
- [[App_Service_to_Key_Vault_Pivot]]
- [[Automation_Accounts_and_Runbooks]]
