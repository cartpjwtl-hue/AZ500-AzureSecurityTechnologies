# Pass-Through Authentication (PTA) Agent Abuse

## What it is
Attackers compromise PTA agents to intercept authentication requests or impersonate users.

## Why attackers use it
- PTA agents run with high privilege
- Can capture password hashes or replay auth
- Direct path into cloud authentication flow

## How it works
1. Attacker compromises PTA server.
2. Hooks into PTA agent or steals certificates.
3. Intercepts or replays authentication requests.
4. Authenticates to Entra ID as victim users.

## Why it’s dangerous
- Full credential theft potential
- MFA bypass in some misconfigurations
- Hard to detect tampering on PTA servers

## Stealth & obfuscation
- Modify agent binaries subtly
- Replay only during normal login hours

## Detection
- PTA agent heartbeat anomalies
- Unexpected authentication patterns
- Certificate usage anomalies

## Mitigation
- Harden PTA servers
- Monitor agent health
- Use cloud-only MFA enforcement

## Related
- [[AAD_Connect_Compromise]]
- [[Seamless_SSO_AZUREADSSOACC_Abuse]]
