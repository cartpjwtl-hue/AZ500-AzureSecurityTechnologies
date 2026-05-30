# KC4: Subscription Control → Data Exfiltration

## Summary
Attacker with subscription-level access exfiltrates data from SQL, Storage, and M365 using cloud-native paths.

## Phase 1: Initial Access
- Attacker gains Contributor/Owner role
- Enumerates resources across subscription

## Phase 2: Identify Data Stores
- Locate SQL, Storage Accounts, Key Vaults
- Extract secrets from Key Vault

## Phase 3: Data Access
- Use SQL credentials to run SELECT queries
- Use Storage keys or SAS tokens to download blobs
- Use Graph to access SharePoint/OneDrive

## Phase 4: Exfiltration
- Exfiltrate data via HTTPS or attacker-controlled Storage
- Use batch Graph requests to blend with normal traffic

## Phase 5: Cover Tracks
- Delete logs or rotate keys
- Disable backup protections

## Impact
- Large-scale data theft
- Destruction of recovery points

## Related
- [[Azure_SQL_Exfil_via_App_Identity]]
- [[Storage_Account_Takeover]]
- [[M365_File_Hosting_Exfil]]
