# Consent Injection (OAuth2PermissionGrants)

## What it is
Attackers directly modify oauth2PermissionGrants to silently grant apps high-privilege scopes without user interaction.

## Why attackers use it
- No phishing required
- Silent privilege escalation
- Long-term persistence
- Hard to detect

## How it works
1. Compromise an admin or app with Graph permissions.
2. Enumerate existing apps and grants.
3. Add new high-privilege scopes.
4. Use the app identity to access data.

## Why it’s dangerous
- No consent prompt
- No user involvement
- Survives password/MFA resets

## Stealth & obfuscation
- Modify existing grants
- Add scopes slowly
- Target apps already in use

## Detection
- Changes to oauth2PermissionGrants
- Apps gaining new scopes unexpectedly
- Admins modifying app permissions

## Mitigation
- Restrict who can modify grants
- Review app permissions regularly
- Alert on high-privilege scope changes

## Related
- [[Illicit_Consent_Grant]]
- [[App_Backdooring_Existing_Enterprise_Apps]]
