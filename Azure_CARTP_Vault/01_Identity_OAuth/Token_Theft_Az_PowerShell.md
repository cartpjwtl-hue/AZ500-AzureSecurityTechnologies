# Token Theft (Az PowerShell)

## What it is
Attackers steal tokens from Az PowerShell token caches.

## Why attackers use it
- Access to ARM + Graph
- Often overlooked
- Easy replay

## How it works
1. Compromise endpoint.
2. Extract token cache.
3. Replay tokens.

## Why it’s dangerous
- Full Azure access
- Blends with admin activity

## Stealth & obfuscation
- Use same PowerShell user-agent
- Replay during business hours

## Detection
- New device IDs
- Unusual PowerShell automation

## Mitigation
- Token hardening
- Device compliance
- Revoke refresh tokens

## Related
- [[Token_Theft_Az_CLI]]
- [[PRT_Abuse_and_Lantern]]
