# PRT Abuse and Lantern

## What it is
Attackers steal Primary Refresh Tokens (PRTs) and use tools like Lantern to mint new tokens.

## Why attackers use it
- Full cloud access
- MFA bypass
- Long-term persistence

## How it works
1. Compromise Windows device.
2. Extract PRT + session key.
3. Use Lantern to mint tokens.
4. Access Graph/ARM as user.

## Why it’s dangerous
- Full identity takeover
- Hard to detect
- Works across apps

## Stealth & obfuscation
- Replay from similar device fingerprint
- Use same OS version + user-agent

## Detection
- New device IDs
- Impossible travel
- Token replay anomalies

## Mitigation
- Device compliance
- PRT revocation
- Conditional Access

## Related
- [[Refresh_Token_Theft]]
- [[JWT_Theft_and_Manipulation]]
