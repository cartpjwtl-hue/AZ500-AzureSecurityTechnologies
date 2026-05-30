# AAD Connect Compromise

## What it is
Attackers compromise Azure AD Connect servers to extract credentials, manipulate sync rules, or pivot from on-prem AD into Entra ID.

## Why attackers use it
- AD Connect holds high-value secrets
- Sync engine can be abused for privilege escalation
- Direct bridge between on-prem and cloud
- Often under-monitored

## How it works
1. Attacker compromises AD Connect server.
2. Extracts sync credentials or MSOL account password.
3. Modifies sync rules to escalate privileges.
4. Forces sync to push malicious changes to Entra ID.

## Why it’s dangerous
- Full control over hybrid identity
- Ability to create cloud admins from on-prem
- Hard to detect malicious sync rule changes

## Stealth & obfuscation
- Modify existing sync rules instead of creating new ones
- Use scheduled sync windows

## Detection
- AD Connect sync rule modifications
- MSOL account usage anomalies
- Unexpected directory writes from sync engine

## Mitigation
- Harden AD Connect servers
- Monitor sync rule changes
- Rotate MSOL credentials

## Related
- [[Pass_Through_Authentication_Agent_Abuse]]
- [[Hybrid_Identity_Backdoors]]
