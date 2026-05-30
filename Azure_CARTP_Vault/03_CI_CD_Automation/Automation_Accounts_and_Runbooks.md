# Automation Accounts & Runbooks

## What it is
Attackers abuse Azure Automation Accounts and Runbooks to execute code, escalate privileges, or persist in a subscription.

## Why attackers use it
- Runbooks execute with high privilege
- Often overlooked by defenders
- Great for persistence
- Supports PowerShell and Python

## How it works
1. Attacker compromises subscription or identity.
2. Creates or modifies a Runbook.
3. Executes code using system-assigned identity.
4. Accesses Azure resources via MSI.

## Why it’s dangerous
- Full subscription control
- Ability to deploy malware or backdoors
- Hard to detect malicious Runbooks

## Stealth & obfuscation
- Name Runbooks after legitimate tasks
- Schedule execution during maintenance windows
- Use minimal logging

## Detection
- New Runbooks created by unusual identities
- Automation job executions at odd times
- MSI access anomalies

## Mitigation
- Restrict Automation Account permissions
- Review Runbooks regularly
- Enable logging and alerts

## Related
- [[VM_Extensions_and_RunCommand_Abuse]]
- [[Data_Factory_and_Linked_Services]]
