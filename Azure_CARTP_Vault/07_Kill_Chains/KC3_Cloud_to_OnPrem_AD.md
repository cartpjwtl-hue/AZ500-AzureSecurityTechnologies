# KC3: Cloud → On-Prem AD

## Summary
Attacker starts in Azure and pivots downward into on-prem Active Directory via hybrid identity components.

## Phase 1: Initial Cloud Access
- Compromise SPN or user with directory permissions
- Enumerate hybrid identity configuration

## Phase 2: Foothold in Hybrid Identity
- Access AAD Connect server credentials via Key Vault or logs
- Extract MSOL account password

## Phase 3: On-Prem Pivot
- Use MSOL account to authenticate to on-prem AD
- Escalate to Domain Admin via privilege misconfigurations

## Phase 4: On-Prem Control
- Dump AD secrets
- Modify hybrid identity sync rules

## Phase 5: Cloud Re-Compromise
- Push malicious changes to Entra ID via sync
- Create cloud admins from on-prem

## Phase 6: Persistence
- Modify PTA agents or federation settings
- Install backdoors on hybrid identity servers

## Impact
- Full control of cloud and on-prem identity

## Related
- [[AAD_Connect_Compromise]]
- [[Pass_Through_Authentication_Agent_Abuse]]
- [[Hybrid_Identity_Backdoors]]
