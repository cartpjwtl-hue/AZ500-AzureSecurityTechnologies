# Malicious App Registration

## What it is
An attacker registers an app in their own tenant, then uses OAuth consent phishing or consent injection to plant a service principal in the victim tenant.

## Why attackers use it
- Multi-tenant reuse across many orgs
- Privilege escalation via app roles
- MFA bypass by operating at the app layer
- Stealthy persistence via app objects

## How it works
1. Attacker registers an app with desired scopes and redirect URIs.
2. Crafts consent URLs for target tenants.
3. Phishes users/admins or uses consent injection.
4. Victim tenant creates a service principal and stores consent.
5. Attacker uses the app’s identity to access Graph and ARM.

## Why it’s dangerous
- Directory manipulation (users, groups, apps)
- Mail/file access via Graph
- Ability to create new backdoor apps
- Survives user account cleanup

## Stealth & obfuscation
- Homoglyph names and generic publishers
- Low-frequency usage patterns
- Redirect URIs pointing to plausible domains

## Detection
- New service principals with high-privilege roles
- Suspicious redirect URIs
- Apps with Directory.* or AppRoleAssignment.* scopes

## Mitigation
- Restrict who can register apps and grant admin consent
- App governance reviews for new apps
- Periodic SPN/app inventory and cleanup

## Real-world examples
- Nation-state campaigns using malicious apps to deploy Azure resources and exfiltrate data

## Related techniques
- [[Illicit_Consent_Grant]]
- [[Hidden_SPNs_and_App_Registrations]]
- [[App_Backdooring_Existing_Enterprise_Apps]]
