# Role Assignment Abuse

## What it is
Attackers escalate privileges by assigning themselves or their backdoor identities high-privilege Azure RBAC roles.

## Why attackers use it
- Direct path to Owner/Contributor
- Enables full subscription takeover
- Often missed in large environments

## How it works
1. Attacker compromises identity with role assignment rights.
2. Assigns high-privilege roles to attacker-controlled identities.
3. Uses elevated access to deploy resources or exfiltrate data.

## Why it’s dangerous
- Full subscription compromise
- Ability to create persistent backdoors
- Hard to detect without RBAC monitoring

## Stealth & obfuscation
- Assign roles to dormant identities
- Use custom roles with hidden privileges

## Detection
- New role assignments to unusual principals
- Custom role modifications

## Mitigation
- Restrict role assignment permissions
- Use PIM for privileged roles
- Monitor RBAC changes

## Related
- [[Management_Group_Takeover]]
- [[VM_Extensions_and_RunCommand_Abuse]]
