# Seamless SSO (AZUREADSSOACC) Abuse

## What it is
Attackers abuse the AZUREADSSOACC computer account used for Seamless SSO to impersonate users or forge Kerberos tickets.

## Why attackers use it
- AZUREADSSOACC holds a high-value Kerberos key
- Enables cloud authentication impersonation
- Often poorly protected

## How it works
1. Attacker compromises on-prem AD.
2. Extracts AZUREADSSOACC Kerberos key.
3. Crafts Kerberos tickets for cloud authentication.
4. Authenticates to Entra ID as victim users.

## Why it’s dangerous
- MFA bypass in some flows
- Full user impersonation
- Hard to detect forged tickets

## Stealth & obfuscation
- Use realistic ticket lifetimes
- Replay from expected IP ranges

## Detection
- Kerberos anomalies on AZUREADSSOACC
- Unusual Seamless SSO authentication patterns

## Mitigation
- Rotate AZUREADSSOACC key
- Harden on-prem AD
- Enforce modern auth

## Related
- [[Pass_Through_Authentication_Agent_Abuse]]
- [[Hybrid_Identity_Backdoors]]
