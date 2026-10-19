# CA-03 — Protect Administrators
## Objective
Apply stronger authentication requirements to administrative identities.
## Scope
**Users:** Selected Microsoft Entra directory administrative roles  
**Excluded:** Emergency/break-glass account where configured  
**Resources:** All resources
## Conditions
No additional conditions were required.
## Grant Controls
Both requirements were configured:
- Require multifactor authentication
- Require device to be marked as compliant
The requirements are intended to be satisfied together.
## Session Controls
Default.
## Policy State
**Report-only** during initial testing.
## Expected Result
An administrator sign-in should evaluate the requirement for MFA and a compliant device.
## Testing Procedure
1. Use a controlled account with one of the targeted administrative roles.
2. Sign in normally.
3. Open Microsoft Entra sign-in logs.
4. Open the sign-in event.
5. Select Conditional Access.
6. Locate `CA-03-Protect-Administrators`.
7. Record the Report-only evaluation.
## Important Dependency
The compliant-device control depends on an available supported device-compliance signal, such as Microsoft Intune.
## Security Objective
Reduce the risk associated with privileged identities by requiring stronger authentication and device trust.
