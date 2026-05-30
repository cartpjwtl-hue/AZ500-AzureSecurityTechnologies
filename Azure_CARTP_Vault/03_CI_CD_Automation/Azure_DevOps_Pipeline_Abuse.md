# Azure DevOps Pipeline Abuse

## What it is
Attackers modify Azure DevOps pipelines to execute malicious code, deploy backdoors, or pivot into Azure.

## Why attackers use it
- Pipelines run with high privilege
- Service connections grant Azure access
- Easy to hide malicious steps

## How it works
1. Attacker compromises Azure DevOps identity.
2. Modifies YAML pipelines or classic pipelines.
3. Injects malicious tasks.
4. Executes pipeline to deploy payloads.

## Why it’s dangerous
- Full control of build and release process
- Ability to deploy malicious infrastructure
- Hard to detect pipeline tampering

## Stealth & obfuscation
- Hide malicious steps in long YAML files
- Use legitimate task names
- Trigger pipelines during normal hours

## Detection
- Pipeline modifications by unusual identities
- New service connections created
- Unexpected pipeline executions

## Mitigation
- Require approvals for pipeline changes
- Restrict service connection permissions
- Monitor pipeline modifications

## Related
- [[GitHub_Actions_to_Azure_Pivot]]
- [[Pipeline_Secrets_and_PAT_Exposure]]
