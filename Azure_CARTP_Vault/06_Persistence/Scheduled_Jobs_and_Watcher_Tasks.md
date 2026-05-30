# Scheduled Jobs & Watcher Tasks

## What it is
Attackers create scheduled jobs, automation tasks, or watcher scripts to maintain persistence in Azure environments.

## Why attackers use it
- Executes code automatically
- Works even after identity cleanup
- Often overlooked by defenders

## How it works
1. Attacker compromises subscription or automation identity.
2. Creates scheduled jobs or watcher tasks.
3. Executes malicious code periodically.
4. Re-establishes access or deploys payloads.

## Why it’s dangerous
- Long-term persistence
- Hard to detect without automation logging
- Can deploy malware or backdoors

## Stealth & obfuscation
- Use legitimate job names
- Schedule during maintenance windows

## Detection
- New scheduled jobs created
- Automation job anomalies

## Mitigation
- Restrict automation permissions
- Review scheduled tasks regularly

## Related
- [[Automation_Accounts_and_Runbooks]]
- [[VM_Extensions_and_RunCommand_Abuse]]
