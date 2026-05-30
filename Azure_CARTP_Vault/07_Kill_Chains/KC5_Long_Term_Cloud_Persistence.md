# KC5: Long-Term Cloud Persistence

## Summary
Attacker establishes durable, stealthy persistence across identity, compute, and automation layers.

## Phase 1: Identity Persistence
- Create hidden SPNs
- Add long-lived secrets
- Modify OAuth2PermissionGrants

## Phase 2: Compute Persistence
- Install RATs on Azure VMs
- Deploy VM extensions for remote execution

## Phase 3: Automation Persistence
- Create scheduled jobs or Runbooks
- Use Automation Account MSI for privilege operations

## Phase 4: Hybrid Persistence
- Modify sync rules or PTA agents
- Backdoor federation settings

## Phase 5: Cloud-Wide Resilience
- Deploy multiple redundant persistence mechanisms
- Use dormant identities to avoid detection

## Impact
- Extremely durable cloud foothold
- Survives IR cleanup unless hybrid identity is remediated

## Related
- [[Hidden_SPNs_and_App_Registrations]]
- [[Scheduled_Jobs_and_Watcher_Tasks]]
- [[Remote_Access_Tools_on_Azure_VMs_ScreenConnect]]
