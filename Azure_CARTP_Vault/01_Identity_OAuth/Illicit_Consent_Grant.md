# Illicit Consent Grant

## What it is
Attackers trick users or admins into granting OAuth permissions to a malicious multi-tenant app. This gives the attacker long-term access to Microsoft Graph, Exchange Online, SharePoint, Teams, and Entra ID — without needing passwords or MFA.

## Why attackers use it
- Bypasses MFA because consent happens after authentication
- Long-term persistence via refresh tokens and stored consent
- No password theft required
- Silent access to mail, files, chats, directory data

## How it works
1. Attacker registers a multi-tenant app with high-value scopes (Mail.Read, Files.ReadWrite.All, offline_access).
2. Crafts a consent URL targeting the victim tenant.
3. Phishes the user/admin with a fake "Microsoft login" or "integration approval" prompt.
4. User clicks Accept; Entra creates a service principal and consent record.
5. Attacker uses refresh tokens to access Graph indefinitely.

## Why it’s dangerous
- Identity: full impersonation of the consenting user
- Data: mail, files, chats, SharePoint, Teams, directory
- IR: password resets and MFA resets do nothing to stop it

## Stealth & obfuscation
- Homoglyph app names (0ffice 365, Micros0ft Sign-in)
- Legit-looking branding
- Low-volume Graph calls that blend with normal app behavior

## Detection
- Entra ID audit logs: AppConsentGrant, ServicePrincipalCreated
- OAuth app inventory: new apps with offline_access
- Look for unverified publishers with high-privilege scopes

## Mitigation
- Disable user consent where possible
- Require admin approval for risky scopes
- Enforce publisher verification
- Regular OAuth app reviews and recertification

## Real-world examples
- OAuth phishing campaigns abusing fake Office 365 apps
- APTs using malicious apps for mailbox exfiltration

## Related techniques
- [[Malicious_App_Registration]]
- [[Consent_Injection_OAuth2PermissionGrants]]
- [[App_Backdooring_Existing_Enterprise_Apps]]
