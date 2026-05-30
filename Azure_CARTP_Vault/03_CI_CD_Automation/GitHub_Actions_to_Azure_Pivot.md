# GitHub Actions → Azure Pivot

## What it is
Attackers compromise GitHub Actions workflows or secrets to pivot into Azure using service principals or federated credentials.

## Why attackers use it
- GitHub secrets often include Azure credentials
- OIDC federation allows passwordless Azure access
- Workflows run with high privilege

## How it works
1. Attacker compromises GitHub repo or workflow.
2. Extracts secrets or abuses OIDC federation.
3. Obtains Azure access token.
4. Deploys malicious resources or modifies infrastructure.

## Why it’s dangerous
- Full IaC compromise
- Ability to deploy malicious code
- Azure access without stored credentials

## Stealth & obfuscation
- Trigger workflows via PRs
- Use legitimate workflow names

## Detection
- Unusual workflow triggers
- OIDC token issuance anomalies
- Repo modifications by unexpected identities

## Mitigation
- Restrict GitHub secrets
- Use least-privilege service principals
- Monitor OIDC token issuance

## Related
- [[Azure_DevOps_Pipeline_Abuse]]
- [[Pipeline_Secrets_and_PAT_Exposure]]
