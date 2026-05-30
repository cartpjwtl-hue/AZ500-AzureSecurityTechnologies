# Dynamic Groups Abuse

## What it is
Attackers modify dynamic group rules to add themselves or backdoor identities into privileged groups.

## Why attackers use it
- Automated privilege escalation
- Hard to detect rule manipulation
- Survives password resets and MFA resets

## How it works
1. Attacker compromises identity with group management rights.
2. Modifies dynamic group membership rules.
3. Ensures attacker-controlled identities match rule conditions.
4. Gains privileged access automatically.

## Why it’s dangerous
- Privilege escalation without explicit role assignment
- Hidden persistence path
- Difficult to audit complex rules

## Stealth & obfuscation
- Modify existing rules instead of creating new ones
- Use subtle attribute conditions

## Detection
- Dynamic group rule changes
- Sudden membership changes in privileged groups

## Mitigation
- Restrict dynamic group management
- Review group rules regularly

## Related
- [[Role_Assignment_Abuse]]
- [[Hybrid_Identity_Backdoors]]
