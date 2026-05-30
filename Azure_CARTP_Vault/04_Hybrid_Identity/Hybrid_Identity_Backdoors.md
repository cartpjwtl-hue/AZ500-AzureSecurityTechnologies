# Hybrid Identity Backdoors

## What it is
Attackers create persistence by modifying hybrid identity components such as sync rules, PTA agents, federation settings, or Kerberos keys.

## Why attackers use it
- Extremely durable persistence
- Hard to detect
- Survives password resets and MFA resets

## How it works
1. Compromise hybrid identity infrastructure.
2. Modify sync rules, federation settings, or PTA agents.
3. Create hidden privilege escalation paths.
4. Maintain long-term access.

## Why it’s dangerous
- Full control over identity lifecycle
- Cloud and on-prem compromise
- Very difficult to eradicate

## Stealth & obfuscation
- Modify existing rules instead of adding new ones
- Use legitimate admin tools

## Detection
- Federation metadata changes
- Sync rule anomalies
- PTA agent tampering

## Mitigation
- Harden hybrid identity servers
- Monitor federation and sync configuration
- Regular audits of hybrid identity components

## Related
- [[AAD_Connect_Compromise]]
- [[Seamless_SSO_AZUREADSSOACC_Abuse]]
