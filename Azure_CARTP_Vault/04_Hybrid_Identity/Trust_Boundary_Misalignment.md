# Trust Boundary Misalignment

## What it is
Attackers exploit mismatches between on-prem AD trust boundaries and Entra ID permissions.

## Why attackers use it
- On-prem compromise often leads to cloud compromise
- Hybrid identity expands attack surface
- Misaligned trust boundaries create privilege escalation paths

## How it works
1. Attacker compromises on-prem AD.
2. Identifies cloud-linked objects with elevated permissions.
3. Exploits sync or federation trust to escalate.
4. Gains cloud admin privileges.

## Why it’s dangerous
- On-prem breach becomes cloud breach
- Hard to detect cross-boundary escalation
- Often overlooked in IR

## Stealth & obfuscation
- Modify low-visibility AD objects
- Use existing sync cycles

## Detection
- Unexpected cloud role assignments from synced identities
- Hybrid identity anomalies

## Mitigation
- Align on-prem and cloud privilege models
- Harden hybrid identity components

## Related
- [[AAD_Connect_Compromise]]
- [[Hybrid_Identity_Backdoors]]
