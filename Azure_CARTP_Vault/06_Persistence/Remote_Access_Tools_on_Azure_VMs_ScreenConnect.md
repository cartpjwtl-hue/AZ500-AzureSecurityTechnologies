# Remote Access Tools on Azure VMs (ScreenConnect, etc.)

## What it is
Attackers install remote access tools (RATs) such as ScreenConnect, AnyDesk, or custom implants on Azure VMs to maintain persistent access.

## Why attackers use it
- Full interactive access to VMs
- Survives credential resets
- Works even if cloud identity is remediated

## How it works
1. Attacker compromises VM via RCE, extension abuse, or RunCommand.
2. Installs remote access software.
3. Configures persistence mechanisms.
4. Uses VM as a long-term foothold.

## Why it’s dangerous
- Full control of VM
- Ability to pivot into networks
- Hard to detect if disguised as legitimate software

## Stealth & obfuscation
- Rename executables
- Install as legitimate services
- Use encrypted tunnels

## Detection
- New services installed on VMs
- Outbound connections to RAT servers
- VM extension anomalies

## Mitigation
- Harden VMs
- Monitor for unauthorized software
- Restrict VM extension usage

## Related
- [[VM_Extensions_and_RunCommand_Abuse]]
- [[Scheduled_Jobs_and_Watcher_Tasks]]
