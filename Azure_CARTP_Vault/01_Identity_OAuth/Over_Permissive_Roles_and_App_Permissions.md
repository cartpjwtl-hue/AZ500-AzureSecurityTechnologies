# Over-Permissive Roles and App Permissions

## What it is
Attackers exploit users, groups, or apps with excessive privileges in Entra ID or Azure RBAC.

## Why attackers use it
- Easy privilege escalation
- Often unnoticed by defenders
- Enables lateral movement across cloud services
- Allows creation of new backdoors

## How it works
1. Attacker compromises a moderately privileged identity.
2. Enumerates directory roles, app roles, and RBAC assignments.
3. Identifies over-permissive principals.
4. Escalates privileges or creates persistence.

## Why it’s dangerous
- Can lead to Global Admin
- Can modify OAuth apps
- Can assign roles to attacker accounts
- Can create new service principals

## Stealth & obfuscation
- Assign roles to dormant accounts
- Add permissions incrementally
- Use app roles instead of user roles

## Detection
- Role assignments to unusual principals
- Apps gaining high-privilege scopes
- Users suddenly gaining admin roles

## Mitigation
- Least privilege
- Privileged Identity Management (PIM)
- Role assignment reviews

## Related
- [[App_Backdooring_Existing_Enterprise_Apps]]
- [[Consent_Injection_OAuth2PermissionGrants]]
