# App Backdooring (Existing Enterprise Apps)

## What it is
Attackers modify existing trusted apps to add new credentials, redirect URIs, or permissions.

## Why attackers use it
- Leverages existing trust
- Hard to detect
- Excellent long-term persistence

## How it works
1. Compromise an app owner or admin.
2. Add new client secrets or certificates.
3. Add new redirect URIs.
4. Increase scopes or app roles.
5. Use the new credentials to authenticate.

## Why it’s dangerous
- Backdoor into a widely used app
- Survives user cleanup
- Hard to distinguish from legitimate changes

## Stealth & obfuscation
- Add secrets with generic names
- Long expiration dates
- Avoid modifying app display name

## Detection
- New secrets/certs on existing apps
- Redirect URI changes
- Scope increases

## Mitigation
- Strict change control
- App credential rotation
- App governance reviews

## Related
- [[Malicious_App_Registration]]
- [[Consent_Injection_OAuth2PermissionGrants]]
