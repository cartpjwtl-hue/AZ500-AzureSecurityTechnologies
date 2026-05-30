# Deployment History Secret Mining

## What it is
Attackers extract secrets from deployment logs, release pipelines, or IaC templates stored in CI/CD systems.

## Why attackers use it
- Secrets often leak into logs
- IaC templates contain connection strings and keys
- Deployment history is rarely monitored

## How it works
1. Attacker gains access to CI/CD system.
2. Searches logs, artifacts, and templates for secrets.
3. Extracts credentials for Azure services.
4. Uses secrets to pivot into cloud resources.

## Why it’s dangerous
- Secrets may grant direct access to Key Vault, Storage, SQL
- Logs often persist indefinitely
- Hard to detect secret scraping

## Stealth & obfuscation
- Query logs slowly
- Use built-in search tools
- Blend with normal developer activity

## Detection
- Unusual log downloads
- Access to old pipeline runs
- Secret scanning alerts

## Mitigation
- Mask secrets in logs
- Use secret scanning tools
- Rotate leaked credentials

## Related
- [[Pipeline_Secrets_and_PAT_Exposure]]
- [[Data_Factory_and_Linked_Services]]
