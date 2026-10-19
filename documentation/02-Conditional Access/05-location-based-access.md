# CA-05 Location-Based Access
## Objective
Allow normal access from the designated lab/corporate network while requiring MFA from other network locations.
## Scope
**Users:** All users  
**Excluded:** Emergency/break-glass account where configured  
**Resources:** All resources
## Named Location
A named IP location was created:
`OliverPay-Corporate-Network`
The location should contain only an IP address/range that the tester is authorized to designate.
## Conditions
**Network/location:**
- Include: Any network or location
- Exclude: `OliverPay-Corporate-Network`
This causes the policy to apply to locations outside the designated corporate/lab network.
## Grant Controls
**Grant access → Require multifactor authentication**
## Session Controls
Default.
## Policy State
**Report-only** during initial testing.
## Expected Result
**Corporate/lab network:** CA-05 is excluded, allowing normal access from that location.
**Other network:** CA-05 applies and requires MFA.
## Testing Procedure
1. Sign in from the designated lab/corporate network.
2. Open the sign-in log and Conditional Access evaluation.
3. Confirm CA-05 is excluded/not applied because the request originated from the named location.
4. If an authorized second network is available, repeat the sign-in.
5. Confirm CA-05 is evaluated and MFA is required in Report-only mode.
## Security Considerations
Do not designate an arbitrary IP as a trusted corporate location. Use only a network/IP range that you are authorized to classify for the lab.
## Security Objective
Use network context as one signal in a Zero Trust decision while maintaining stronger authentication outside the designated environment.
