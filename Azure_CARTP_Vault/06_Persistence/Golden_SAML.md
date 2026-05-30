# Golden SAML

## What it is
Golden SAML is a persistence technique where attackers forge SAML tokens by compromising the signing certificate of an identity provider (IdP), allowing them to impersonate any user — including admins — without needing credentials or MFA.

## Why attackers use it
- Total bypass of MFA and passwords
- Works even after password resets
- Long-term persistence if signing cert is not rotated
- Grants access to cloud apps that trust SAML

## How it works
1. Attacker compromises on-prem AD FS or another SAML IdP.
2. Extracts the token-signing certificate.
3. Crafts forged SAML tokens for privileged users.
4. Authenticates to cloud apps (Azure, M365, etc.).

## Why it’s dangerous
- Full impersonation of any user
- Survives account cleanup
- Hard to detect forged SAML tokens

## Stealth & obfuscation
- Use realistic token lifetimes
- Replay from expected IP ranges
- Forge tokens only during business hours

## Detection
- AD FS event anomalies
- Unusual SAML token issuance patterns
- Cloud sign-ins without corresponding IdP logs

## Mitigation
- Rotate token-signing certificates
- Harden AD FS servers
- Move to modern authentication

## Related
- [[Hybrid_Identity_Backdoors]]
- [[Seamless_SSO_AZUREADSSOACC_Abuse]]
