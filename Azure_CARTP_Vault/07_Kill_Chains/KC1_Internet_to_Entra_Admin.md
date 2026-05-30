# KC1: Internet → Entra Admin

## Summary
A full kill chain where an attacker starts with zero access and escalates to Entra ID administrative control using OAuth abuse, token theft, and privilege escalation.

## Phase 1: Initial Access
- Phishing user with malicious OAuth consent URL
- Victim grants high-privilege scopes (Mail.ReadWrite, Directory.Read.All)
- Service principal created silently in tenant

## Phase 2: Establish Foothold
- Attacker uses refresh tokens to mint new access tokens
- Enumerates directory objects via Graph
- Identifies privileged users and roles

## Phase 3: Privilege Escalation
- Abuses over-permissive roles
- Modifies oauth2PermissionGrants to add Directory.ReadWrite.All
- Gains ability to modify users and groups

## Phase 4: Admin Takeover
- Assigns Privileged Role Administrator to attacker-controlled identity
- Elevates to Global Administrator

## Phase 5: Persistence
- Creates hidden SPN with long-lived secret
- Adds high-privilege Graph scopes
- Backdoors existing enterprise apps

## Phase 6: Impact
- Full control of Entra ID
- Ability to modify Conditional Access, MFA, and roles

## Related
- [[Illicit_Consent_Grant]]
- [[Over_Permissive_Roles_and_App_Permissions]]
- [[OAuth2PermissionGrant_Persistence]]
