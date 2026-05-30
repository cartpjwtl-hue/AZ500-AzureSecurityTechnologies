# Management Group Takeover

## What it is
Attackers escalate privileges by compromising Management Group (MG) roles, gaining control over multiple subscriptions.

## Why attackers use it
- MG roles override subscription RBAC
- Enables large-scale cloud takeover
- Often poorly monitored

## How it works
1. Attacker compromises MG Contributor/Owner.
2. Modifies MG RBAC assignments.
3. Gains control over all child subscriptions.
4. Deploys resources or exfiltrates data at scale.

## Why it’s dangerous
- Organization-wide compromise
- Ability to deploy malicious infrastructure globally
- Hard to detect without MG-level monitoring

## Stealth & obfuscation
- Modify MG roles incrementally
- Use dormant identities for persistence

## Detection
- MG role assignment changes
- New MG-level identities gaining privilege

## Mitigation
- Restrict MG role assignment
- Use PIM for MG roles
- Monitor MG RBAC changes

## Related
- [[Role_Assignment_Abuse]]
- [[VM_Extensions_and_RunCommand_Abuse]]
