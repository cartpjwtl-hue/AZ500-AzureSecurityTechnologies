# M365 File Hosting Exfiltration

## What it is
Attackers exfiltrate data from OneDrive/SharePoint using compromised identities or app permissions.

## Why attackers use it
- Massive data stores
- Easy to automate
- Hard to detect
- Common in real breaches (Storm-style campaigns)

## How it works
1. Attacker compromises user/app.
2. Enumerates OneDrive/SharePoint sites.
3. Downloads files via Graph.
4. Exfiltrates to attacker infrastructure.

## Why it’s dangerous
- Large-scale data theft
- Blends with normal user activity
- Often missed by IR teams

## Stealth & obfuscation
- Download during business hours
- Use Graph batch requests
- Throttle speed

## Detection
- Unusual file download volume
- Access from new devices
- App accessing user files unexpectedly

## Mitigation
- DLP policies
- App governance
- Conditional Access

## Related
- [[Azure_SQL_Exfil_via_App_Identity]]
- [[Blob_Storage_Exposure]]
