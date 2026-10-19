# CA-04 Require MFA for Risky Sign-Ins
## Objective
Require additional authentication when Microsoft Entra identifies elevated sign-in risk.
## Scope
**Users:** All users  
**Excluded:** Emergency/break-glass account where configured  
**Resources:** All resources
## Conditions
**Sign-in risk:**
- Medium
- High
Low risk was not selected.
## Grant Controls
**Grant access ->  Require multifactor authentication**
## Session Controls
Default.
## Policy State
**Report-only** during initial testing.
## Expected Result
A medium- or high-risk sign-in should evaluate as requiring MFA.
## Testing Procedure
1. Review available sign-in risk information in Microsoft Entra.
2. Use Conditional Access simulation where supported.
3. Locate `CA-04-Require-MFA-Risky-Sign-In`.
4. Confirm that medium/high sign-in risk maps to the MFA grant control.
5. Record the result.
## Safety Note
The lab does not intentionally generate suspicious activity merely to create a risk event.
## Security Objective
Use identity risk as an additional Zero Trust signal and require stronger authentication when risk increases.
