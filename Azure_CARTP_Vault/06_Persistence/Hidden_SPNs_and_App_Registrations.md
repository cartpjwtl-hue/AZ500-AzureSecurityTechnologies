# Hidden SPNs & App Registrations

## What it is
Attackers create or modify service principals (SPNs) or app registrations to establish stealthy, long-term persistence in Entra ID.

## Why attackers use it
- SPNs are rarely reviewed
- App credentials can last years
- Easy to hide among legitimate enterprise apps

## How it works
1. Attacker compromises an admin or app owner.
2. Creates a new SPN or modifies an existing one.
3. Adds client secrets or certificates.
4. Grants high-privilege Graph or ARM permissions.

## Why it’s dangerous
- Persistent cloud backdoor
- Survives user cleanup
- Hard to detect without app governance

## Stealth & obfuscation
- Use generic app names
- Add long-lived secrets
- Avoid modifying display names

## Detection
- New SPNs with high-privilege roles
- App credential creation events
- OAuth app inventory anomalies

## Mitigation
- Restrict app registration
- Enforce app governance reviews
- Rotate app credentials

## Related
- [[App_Backdooring_Existing_Enterprise_Apps]]
- [[OAuth2PermissionGrant_Persistence]]
