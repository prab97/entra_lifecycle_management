# CA-01 — Require MFA for All Users

## Objective

Require multifactor authentication for users accessing protected resources.

## Scope

**Users:** All users  
**Excluded:** Emergency/break-glass account where configured  
**Resources:** All resources

## Conditions

No additional conditions were required for this baseline MFA policy.

## Grant Controls

**Grant access → Require multifactor authentication**

## Session Controls

Default.

## Policy State

**Report-only** during initial testing.

## Expected Result

A user sign-in should evaluate the policy and indicate that MFA would be required.

## Testing Procedure

1. Sign in using a controlled lab user.
2. Open Microsoft Entra sign-in logs.
3. Open the sign-in event.
4. Select Conditional Access.
5. Locate `CA-01-require-mfa-all-users`.
6. Record the Report-only evaluation.

## Evidence

Store the relevant sign-in-log screenshot in `screenshots/`.

## Security Objective

Provide a baseline second factor for authentication and reduce the impact of compromised passwords.
