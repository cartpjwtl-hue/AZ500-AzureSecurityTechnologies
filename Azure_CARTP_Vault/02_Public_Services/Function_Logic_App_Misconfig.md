# Function & Logic App Misconfiguration

## What it is
Misconfigured Azure Functions or Logic Apps expose secrets, workflows, or internal APIs.

## Why attackers use it
- Easy access to secrets
- Workflow manipulation
- Privilege escalation via managed identities

## How it works
1. Attacker enumerates Function/Logic App endpoints.
2. Finds open HTTP triggers or leaked keys.
3. Invokes workflows to extract secrets or run actions.
4. Uses managed identity to pivot.

## Why it’s dangerous
- Key Vault access
- Data exfiltration
- Workflow tampering

## Stealth & obfuscation
- Invoke functions with normal user-agents
- Use expected regions

## Detection
- Function invocation logs
- Logic App run history anomalies

## Mitigation
- Use Function Keys + Azure AD auth
- Restrict IPs
- Rotate secrets

## Related
- [[App_Service_SSRF_MSI_Abuse]]
- [[Data_Factory_and_Linked_Services]]
