# JWT Theft and Manipulation

## What it is
Attackers steal or manipulate JSON Web Tokens to impersonate users or apps.

## Why attackers use it
- MFA bypass
- Direct API access
- Works with many Azure services

## How it works
1. Steal JWT from memory, logs, or proxies.
2. Modify claims (if signing key compromised).
3. Replay token to Graph/ARM.

## Why it’s dangerous
- Full impersonation
- Hard to detect
- Works across cloud services

## Stealth & obfuscation
- Replay with same user-agent
- Align timestamps

## Detection
- Token replay
- Invalid signature attempts
- Unusual claim patterns

## Mitigation
- Protect signing keys
- Short token lifetimes
- Conditional Access

## Related
- [[PRT_Abuse_and_Lantern]]
- [[Service_Principal_Certificate_Theft]]
