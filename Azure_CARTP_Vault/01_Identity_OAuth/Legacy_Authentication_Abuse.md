# Legacy Authentication Abuse

## What it is
Attackers authenticate using legacy protocols (IMAP, POP, SMTP) that do not support MFA.

## Why attackers use it
- MFA bypass via non-modern protocols
- Credential stuffing and password spraying
- Low sophistication but high success rate
- Common in BEC and commodity campaigns

## How it works
1. Attacker obtains credentials (phishing, reuse, brute force).
2. Targets legacy endpoints (IMAP/POP/SMTP).
3. Authenticates without MFA.
4. Exfiltrates mail or sends phishing from the account.

## Why it’s dangerous
- Full mailbox compromise
- Hidden MFA bypass path
- Often overlooked by defenders

## Stealth & obfuscation
- Use old Outlook/Apple Mail user-agents
- Slow brute force to avoid lockouts

## Detection
- Sign-ins with legacy client apps
- Legacy auth from unusual geos
- Users who normally use modern auth suddenly using IMAP/POP

## Mitigation
- Disable legacy auth globally
- Conditional Access blocking legacy protocols
- Migrate old clients to modern auth

## Real-world examples
- BEC campaigns using IMAP logins for persistence and exfiltration

## Related techniques
- [[Refresh_Token_Theft]]
- [[Over_Permissive_Roles_and_App_Permissions]]
