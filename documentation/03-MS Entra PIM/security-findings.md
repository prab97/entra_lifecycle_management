# Security Findings — Microsoft Entra PIM JIT Access Lab

## Scope and evidence standard

This document records security observations from a **personal Microsoft Entra test tenant** using the `PIM Lab Admin` identity and the **Groups Administrator** directory role.

**Evidence labels:**

- **Verified:** Visible in screenshots or audit data reviewed during the lab.
- **Reported:** Lab action/result was confirmed by the operator but the underlying screenshot or log is not embedded here.
- **Configured / not independently verified:** A policy setting was applied, but a corresponding enforcement event was not established from the available evidence.

These are lab observations, **not findings from a production security assessment**.

## Findings summary

| ID | Control / observation | Status | Security significance |
| --- | --- | --- | --- |
| SF-01 | Eligible rather than permanently active role assignment | **Verified** | Reduces standing administrative privilege |
| SF-02 | Groups Administrator selected instead of Global Administrator | **Verified** | Applies role-based least privilege |
| SF-03 | One-hour activation duration | **Verified in activation UI** | Limits exposure window |
| SF-04 | Justification required | **Verified in activation UI** | Improves accountability |
| SF-05 | MFA required during activation | **Configured / not independently verified** | Strengthens privileged authentication |
| SF-06 | Group-management task during active role | **Reported** | Functional test; authorization attribution needs stronger control |
| SF-07 | Role expiration or deactivation | **Reported** | Supports removal of temporary privileges |
| SF-08 | PIM configuration and assignment events logged | **Verified** | Enables privileged-access auditing |
| SF-09 | Failed role update/removal events visible | **Verified** | Shows unsuccessful administrative operations are auditable |
| SF-10 | Approval workflow | **Not implemented** | Opportunity for additional separation of duties |

## Detailed observations

### SF-01 — Standing privilege reduced through eligible assignment

**Observation:** `PIM Lab Admin` was assigned **Groups Administrator** with an **Eligible** status. The eligibility was permanent, but the privileged role was not intended to remain active continuously.

**Risk addressed:** Unnecessary standing administrative privileges increase the window for misuse or account compromise.

**Evidence:** Eligible-assignment details showing `PIM Lab Admin`, `Groups Administrator`, and `Eligible`.

**Assessment:** Control design demonstrated. Review the user for other direct/indirect administrative grants before asserting the account has no standing privileged access of any kind.

### SF-02 — Least-privilege role selection

**Observation:** The lab used **Groups Administrator**, not Global Administrator, for a group-management scenario.

**Risk addressed:** Overprivileged roles grant access beyond the task's business need.

**Evidence:** PIM assignment and activation screens identifying the Groups Administrator role.

**Assessment:** Appropriate scoped role choice for the lab. A further improvement would be to evaluate whether an even narrower permission model is suitable for the exact task.

### SF-03 — Time-limited JIT activation

**Observation:** The activation panel showed a **1-hour** duration limit. The operator reported checking the role after expiration/deactivation.

**Risk addressed:** Long-lived privileged sessions and standing role assignments.

**Evidence:** Activation panel showing duration; retain active-assignment and post-expiration screenshots.

**Assessment:** Activation time limit was visible. The post-expiration result is operator-reported until supporting evidence is stored in the repository.

### SF-04 — Justification required for activation

**Observation:** The PIM activation panel marked the reason field as required, and a lab justification was entered.

**Risk addressed:** Privileged activity without a documented purpose.

**Evidence:** Activation panel screenshot showing the required reason field.

**Assessment:** Verified in the activation interface. Justification improves traceability but does not by itself validate whether a request is appropriate.

### SF-05 — MFA policy configured; enforcement needs evidence

**Observation:** MFA was configured as an activation requirement. No separate MFA button or new MFA prompt was visible in the activation screenshot.

**Risk addressed:** Privileged access obtained using only a compromised password.

**Evidence:** PIM role settings, plus sign-in authentication details if available.

**Assessment:** **Do not mark a fresh MFA challenge as passed.** PIM may accept an existing authentication session that already meets the requirement. Confirm using sign-in logs/authentication details or a controlled fresh-session test before making a stronger enforcement claim.

**Recommendation:** Retain authentication-method and conditional-access/sign-in evidence showing how the MFA requirement was satisfied, while redacting sensitive identifiers.

### SF-06 — Group creation is not exclusive proof of privileged authorization

**Observation:** The operator reported creating `PIM-JIT-Test-Group` while Groups Administrator was active.

**Risk addressed:** Failure to verify that temporary role activation enables the intended task.

**Evidence:** Test-group screenshot and timestamp, if captured.

**Assessment:** A useful functional demonstration, **but not a conclusive role-dependent authorization test**. Microsoft Entra tenant settings can allow non-admin group creation; group ownership may also permit management.

**Recommendation:** Repeat the test using a role-dependent operation on a group the test user does not own, compare results before/during/after activation, and ensure no other privileges explain success.

### SF-07 — Expiration/deactivation removes active privilege

**Observation:** The operator reported completing the expiration test.

**Risk addressed:** Privileged access persisting beyond the approved window.

**Evidence:** Active-assignment state before and after expiration or deactivation; audit record if available.

**Assessment:** Operator-reported. Preserve timestamps and verify no alternative role assignment remains. For a true **automatic expiration** test, distinguish waiting for the configured end time from manually selecting **Deactivate**.

### SF-08 — PIM audit logging captures administrative activity

**Observation:** An audit-history screenshot showed successful events for **Update role setting in PIM**, **Add eligible member to role in PIM**, and role-removal actions.

**Risk addressed:** Lack of traceability for privileged-role configuration and assignment changes.

**Evidence:** PIM audit-history screenshot with event type, requester, target, time, and status.

**Assessment:** **Verified** for the events visible in the screenshot. The operator later reported checking activation audit history; retain that activation-specific record separately to substantiate its details.

### SF-09 — Failed administrative requests are visible

**Observation:** The audit-history screenshot contained failed **Process role update request** and **Process role removal request** events.

**Risk addressed:** Unsuccessful or unexpected privileged changes going unnoticed.

**Evidence:** Audit rows marked unsuccessful.

**Assessment:** **Verified** that failed operations were logged. Their root causes were **not established** from the screenshot alone; do not characterize them as attacks or control violations without further investigation.

**Recommendation:** Open event details, document error codes and initiators, and correlate with intended lab actions before assigning severity.

### SF-10 — Approval workflow not enabled

**Observation:** Approval was intentionally disabled to allow the initial self-service activation test.

**Risk addressed by future improvement:** Privileged users self-activating without independent authorization for sensitive tasks.

**Assessment:** **Not implemented**. This is a documented lab limitation, not evidence of a misconfiguration.

**Recommendation:** In a follow-up lab, configure a dedicated approver and test approved, denied, and timed-out requests without creating an approval deadlock.

## Recommended next improvements

1. **Strengthen MFA evidence:** Capture relevant sign-in authentication details rather than relying on whether a prompt appeared.
2. **Strengthen authorization testing:** Use an operation demonstrably unavailable to the same user without the active role.
3. **Preserve expiration proof:** Record role status and timestamps before and after the automatic one-hour expiry.
4. **Review failed PIM requests:** Inspect event details and record benign causes or corrective actions.
5. **Test approval and notifications:** Introduce an independent approver in a future controlled scenario.
6. **Minimize permanent active administrator roles:** Review standing privileges in the personal lab while preserving necessary emergency access.

## Evidence register

| Evidence | File to add | Current confidence |
| --- | --- | --- |
| Eligible role assignment | `screenshots/01-eligible-groups-administrator.png` | Screenshot reviewed |
| Activation settings | `screenshots/02-pim-activation-settings.png` | Operator-confirmed configuration |
| Activation form (duration + reason) | `screenshots/03-jit-activation-panel.png` | Screenshot reviewed |
| Active role assignment | `screenshots/04-active-role-assignment.png` | Operator-reported |
| Test security group | `screenshots/05-pim-jit-test-group.png` | Operator-reported |
| Role expiration/deactivation | `screenshots/06-role-expired-or-deactivated.png` | Operator-reported |
| PIM audit history | `screenshots/07-pim-audit-history.png` | Screenshot reviewed |
| Activation-specific audit details | `screenshots/08-activation-audit-details.png` | Operator-reported; retain source evidence |

## Conclusion

The lab illustrates the core PIM security model: **eligible role assignment → controlled temporary activation → privileged task → role expiration → audit trail**. Evidence confirms eligible assignment, time-limited activation UI, justification requirement, and audit logging for configuration/assignment changes. MFA enforcement details, authorization exclusivity, and expiration evidence should be retained before presenting those tests as independently verified.

---

**Environment:** Personal test tenant. **Purpose:** IAM portfolio and security-learning documentation.
