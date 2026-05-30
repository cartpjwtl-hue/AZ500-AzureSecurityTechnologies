# Refresh Token Theft

## What it is
Attackers steal refresh tokens or Primary Refresh Tokens (PRTs) from endpoints, browsers, or token caches, then silently mint new access tokens.

## Why attackers use it
- Bypasses MFA
- Session hijack without password
- Cross-app access (Graph, Exchange, SharePoint, Teams)
- Long-term persistence

## How it works
1. Endpoint compromise (malware, RCE, physical access).
2. Dump browser/OS token stores or PRTs.
3. Replay tokens from attacker infrastructure.
4. Request new access tokens via OAuth.
5. Access cloud resources as the user.

## Why it’s dangerous
- Full user impersonation
- Access to all Microsoft 365 data
- Activity looks like normal sign-ins

## Stealth & obfuscation
- Match victim device user-agent
- Use VPN exit nodes near victim region
- Align activity with user working hours

## Detection
- New device IDs for the same user
- Impossible travel combined with token replay
- Sign-ins shortly after endpoint compromise alerts

## Mitigation
- Shorter token lifetimes
- Device compliance enforcement
- Revoke refresh tokens after endpoint compromise

## Real-world examples
- APTs pivoting from on-prem to cloud via PRT and refresh token theft

## Related techniques
- [[Legacy_Authentication_Abuse]]
- [[Token_Theft_Az_CLI]]
- [[PRT_Abuse_and_Lantern]]
