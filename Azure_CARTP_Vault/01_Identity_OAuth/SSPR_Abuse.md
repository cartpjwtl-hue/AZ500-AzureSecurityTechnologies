# SSPR Abuse

## What it is
Attackers abuse Self-Service Password Reset (SSPR) flows to take over accounts or regain access after eviction.

## Why attackers use it
- MFA bypass if SSPR is weak
- Easy initial access
- Easy persistence
- Looks like legitimate user activity

## How it works
1. Identify users with weak SSPR methods.
2. Compromise email/SMS or use social engineering.
3. Reset password via SSPR portal.
4. Log in and enroll new MFA.

## Why it’s dangerous
- Full account takeover
- Hard to distinguish from legitimate resets
- Works even with MFA enabled

## Stealth & obfuscation
- Reset during business hours
- Use local IP ranges
- Enroll MFA immediately

## Detection
- SSPR events for privileged accounts
- New MFA enrollments after SSPR
- Sign-ins from new devices post-reset

## Mitigation
- Strong SSPR verification
- Restrict SSPR for admins
- Monitor SSPR logs

## Related
- [[Refresh_Token_Theft]]
- [[Legacy_Authentication_Abuse]]
