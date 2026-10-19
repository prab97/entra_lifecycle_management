# CA-02 — Block Legacy Authentication
## Objective
Prevent authentication protocols that do not support modern authentication and Conditional Access controls.
## Scope
**Users:** All users  
**Excluded:** Emergency/break-glass account where configured  
**Resources:** All resources
## Conditions
**Client apps:**
- Exchange ActiveSync clients
- Other clients
Browser and modern mobile/desktop client categories were not targeted by this policy.
## Grant Controls
**Block access**
## Session Controls
Default.
## Policy State
**Report-only** during initial testing.
## Expected Result
A legacy-authentication scenario should evaluate as access that would be blocked.
## Testing Procedure
1. Use Conditional Access What If/simulation where supported.
2. Select the controlled lab user.
3. Select an appropriate resource.
4. Simulate a legacy client scenario.
5. Locate `CA-02-Block-Legacy-Authentication`.
6. Record the Report-only result.
## Evidence
Store the Conditional Access simulation screenshot in `screenshots/`.
## Security Objective
Reduce exposure from legacy authentication methods that cannot reliably enforce modern identity controls.
