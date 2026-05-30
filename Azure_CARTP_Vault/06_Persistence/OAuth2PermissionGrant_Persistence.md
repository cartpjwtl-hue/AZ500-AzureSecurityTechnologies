# OAuth2PermissionGrant Persistence

## What it is
Attackers modify OAuth2PermissionGrants to silently grant apps high-privilege scopes, creating long-term persistence.

## Why attackers use it
- No user interaction required
- Survives password resets
- Hard to detect without Graph monitoring

## How it works
1. Attacker compromises admin or app with Graph permissions.
2. Adds high-privilege scopes to existing grants.
3. Uses app identity to access cloud resources.

## Why it’s dangerous
- Silent privilege escalation
- Persistent cloud backdoor
- No consent prompts

## Stealth & obfuscation
- Modify existing grants
- Add scopes incrementally

## Detection
- Changes to oauth2PermissionGrants
- Apps gaining new scopes unexpectedly

## Mitigation
- Restrict who can modify grants
- Monitor Graph API changes

## Related
- [[Consent_Injection_OAuth2PermissionGrants]]
- [[Hidden_SPNs_and_App_Registrations]]
