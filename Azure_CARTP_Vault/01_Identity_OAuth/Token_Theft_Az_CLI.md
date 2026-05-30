# Token Theft (Azure CLI)

## What it is
Attackers steal tokens from the Azure CLI token cache (~/.azure/accessTokens.json).

## Why attackers use it
- Easy access to ARM + Graph
- No MFA required
- Works cross-platform

## How it works
1. Compromise workstation.
2. Extract accessTokens.json.
3. Replay tokens via CLI or REST.
4. Enumerate and modify Azure resources.

## Why it’s dangerous
- Full subscription access
- Looks like legitimate CLI usage

## Stealth & obfuscation
- Replay tokens with same user-agent
- Use Azure regions close to victim

## Detection
- CLI sign-ins from new devices
- ARM calls from unusual IPs

## Mitigation
- Short token lifetimes
- Device compliance
- Revoke refresh tokens

## Related
- [[Token_Theft_Az_PowerShell]]
- [[Refresh_Token_Theft]]
