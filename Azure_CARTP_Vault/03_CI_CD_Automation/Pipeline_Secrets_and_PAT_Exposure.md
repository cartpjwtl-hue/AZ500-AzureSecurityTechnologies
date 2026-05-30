# Pipeline Secrets & PAT Exposure

## What it is
Attackers extract secrets, Personal Access Tokens (PATs), or service connections from CI/CD systems such as Azure DevOps, GitHub Actions, or GitLab.

## Why attackers use it
- PATs often have broad, long-lived permissions
- Pipeline secrets frequently include cloud credentials
- CI/CD agents run with elevated privileges
- Easy pivot into Azure subscriptions

## How it works
1. Attacker compromises developer workstation or CI/CD agent.
2. Extracts PATs, OAuth tokens, or service connection secrets.
3. Uses tokens to access Azure DevOps or GitHub.
4. Modifies pipelines or deploys malicious artifacts.
5. Uses service connections to pivot into Azure.

## Why it’s dangerous
- Full control of pipelines
- Ability to deploy malicious code
- Direct access to Azure resources
- Often undetected for long periods

## Stealth & obfuscation
- Use PATs during normal working hours
- Modify pipelines incrementally
- Blend with legitimate build traffic

## Detection
- PAT usage from new IPs
- Pipeline modifications by unusual identities
- Service connection usage anomalies

## Mitigation
- Use short-lived tokens
- Enforce MFA for PAT creation
- Rotate secrets regularly
- Restrict service connection scopes

## Related
- [[Deployment_History_Secret_Mining]]
- [[Azure_DevOps_Pipeline_Abuse]]
