# VM Extensions & RunCommand Abuse

## What it is
Attackers abuse Azure VM Extensions and RunCommand to execute arbitrary code on virtual machines.

## Why attackers use it
- Works even without direct RDP/SSH access
- Executes with SYSTEM/root privileges
- Great for persistence and lateral movement
- Common in real-world cloud breaches

## How it works
1. Attacker gains subscription or VM Contributor access.
2. Deploys Custom Script Extension or uses RunCommand.
3. Executes commands (PowerShell, Bash) on the VM.
4. Installs backdoors, extracts credentials, or pivots.

## Why it’s dangerous
- Full VM compromise
- Credential harvesting (LSASS, SSH keys)
- Ability to deploy malware or RATs
- Hard to detect if logs are not enabled

## Stealth & obfuscation
- Use existing extensions
- Execute during maintenance windows
- Remove extension after execution

## Detection
- New VM extensions deployed
- RunCommand executions
- VM agent anomalies

## Mitigation
- Restrict VM extension permissions
- Monitor extension deployments
- Use Just-In-Time VM access

## Related
- [[Automation_Accounts_and_Runbooks]]
- [[Management_Group_Takeover]]
