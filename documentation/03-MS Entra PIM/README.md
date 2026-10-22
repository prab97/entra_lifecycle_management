# Microsoft Entra Privileged Identity Management (PIM) — Just-in-Time Access Lab

## Overview

This hands-on IAM portfolio project demonstrates **just-in-time (JIT) privileged access** using Microsoft Entra Privileged Identity Management (PIM). A dedicated lab user receives an **eligible** Groups Administrator assignment rather than permanent active privileges, then requests temporary activation to complete an administrative task.

The lab was performed in a personally managed Microsoft Entra test tenant. All accounts and resources referenced here are lab assets.

## Objectives

- Apply **least privilege** by selecting Groups Administrator instead of Global Administrator for group-management work.
- Distinguish **eligible** role assignments from **active** role assignments.
- Configure a time-limited PIM activation policy with **a maximum one-hour duration**, **justification**, and an **MFA requirement**.
- Activate an eligible role through the PIM self-service workflow.
- Test a permitted group-management action during activation.
- Review role expiration/deactivation and audit history.
- Capture defensible evidence for an IAM engineering portfolio.

## Technologies and concepts

- Microsoft Entra ID
- Microsoft Entra Privileged Identity Management (PIM)
- Microsoft Entra directory roles
- Just-in-time (JIT) access
- Role-based access control (RBAC)
- Least privilege
- Multifactor authentication (MFA)
- Privileged-access audit logging

## Lab environment

| Component | Lab configuration |
| --- | --- |
| Environment | Personal Microsoft Entra test tenant |
| Test identity | `PIM Lab Admin` |
| Target role | `Groups Administrator` |
| Assignment type | **Eligible** |
| Eligibility duration | Permanent eligibility (does **not** mean permanently active privileges) |
| Maximum activation duration | **1 hour** |
| Activation justification | Required |
| MFA on activation | Configured as required; separate challenge not independently confirmed |
| Approval | Not required in this initial lab |
| Test resource | `PIM-JIT-Test-Group` (security group) |

> **Security note:** Tenant-wide PIM role settings apply to the Groups Administrator role, not solely to the test user. Existing administrators and assignments should be reviewed before modifying settings.

## Architecture

```text
PIM Lab Admin (standard account)
              |
              v
Microsoft Entra PIM — Eligible Groups Administrator
              |
              v
       Activation request
              |
              v
MFA requirement + justification + 1-hour limit
              |
              v
Temporary active Groups Administrator assignment
              |
              v
Authorized group-management operation
              |
              v
Deactivation / expiration -> active role removed
              |
              v
        PIM audit history
```

## Implementation

### 1. Prepare the lab identity

Used the dedicated `PIM Lab Admin` account for privileged-access testing. Checked that the lab user was enabled and was not intended to have standing administrative privileges outside PIM.

### 2. Assign an eligible role

In **ID Governance → Privileged Identity Management → Microsoft Entra roles → Assignments**, selected **Groups Administrator**, chose the lab identity, and set the assignment type to **Eligible**.

**Why:** Eligibility lets the user request privileged access without holding an active administrative role continuously.

### 3. Configure activation controls

Opened PIM role settings for **Groups Administrator** and configured:

- Maximum activation duration: **1 hour**
- Require justification: **Yes**
- Require MFA: **Yes**
- Require ticket information: **No**
- Require approval: **No**, for the initial self-service lab

**Why:** These controls reduce standing privilege and establish accountability for privileged activity.

### 4. Request just-in-time activation

Signed in as `PIM Lab Admin`, navigated to **PIM → My roles → Microsoft Entra roles**, and activated **Groups Administrator** with a documented business justification.

Example justification:

> PIM lab test: validating just-in-time privileged access, MFA enforcement, and time-limited Groups Administrator activation.

**Important:** The activation flow may not display a fresh MFA prompt when the current sign-in already satisfies the authentication requirement. A successful activation alone is not proof that a new MFA challenge occurred.

### 5. Validate temporary privileges

During the active role window, created the security group `PIM-JIT-Test-Group` to exercise a group-management operation.

**Testing limitation:** Some tenants permit non-admin users to create groups, and group owners can manage groups without Groups Administrator. Group creation therefore supports the functional test but is **not conclusive proof** that PIM was the only source of authorization. For stronger validation, test an operation that requires the role, with group ownership and other permissions excluded.

### 6. Review role expiration

Checked the PIM active-assignment state after the activation period and reviewed the removal of temporary access. For reliable authorization testing after expiration, use a new sign-in session and confirm that no other roles or ownership rights grant equivalent access.

### 7. Review audit history

Opened **PIM → My audit history → Microsoft Entra roles** and reviewed audit records. A captured audit screenshot showed successful role-setting changes and eligible-role assignment operations, as well as unsuccessful role-update/removal attempts. The activation audit record was subsequently checked in the lab; retain a screenshot or exported log before describing its details as independently evidenced.

## Test matrix

| ID | Test | Expected result | Lab status / evidence |
| --- | --- | --- | --- |
| PIM-T01 | Eligible role assignment | Lab user appears as **Eligible**, not permanently active | Completed; eligible-assignment screenshot |
| PIM-T02 | Activation policy | 1-hour maximum and justification requirement displayed | Completed; activation-settings / activation-panel evidence |
| PIM-T03 | JIT role activation | Temporary active Groups Administrator assignment created | Reported completed; preserve active-assignment screenshot |
| PIM-T04 | MFA requirement | Activation satisfies configured MFA requirement | **Configured; authentication evidence not independently verified** |
| PIM-T05 | Group-management operation | Authorized operation succeeds while role is active | Completed; group creation reported |
| PIM-T06 | Role expiration / deactivation | Temporary active assignment disappears | Reported completed; preserve post-expiration screenshot |
| PIM-T07 | PIM audit logging | Assignment and configuration actions recorded | Verified in audit screenshot; activation-specific record should be retained |

## Evidence checklist

Place your own screenshots under `screenshots/` using descriptive filenames:

```text
screenshots/
├── 01-eligible-groups-administrator.png
├── 02-pim-activation-settings.png
├── 03-jit-activation-panel.png
├── 04-active-role-assignment.png
├── 05-pim-jit-test-group.png
├── 06-role-expired-or-deactivated.png
├── 07-pim-audit-history.png
└── 08-activation-audit-details.png
```

> Screenshots are **not included** in these Markdown files. Add only genuine evidence from your own lab. Redact unnecessary personal information, tokens, and sensitive tenant details.

## Security findings

See [security-findings.md](security-findings.md) for control observations, limitations, and recommended improvements.

## Key takeaways

This lab demonstrates how PIM can replace continuously active administrative access with **eligible assignments**, **time-bound activation**, and **auditable privileged-access requests**. It also illustrates why IAM testing must distinguish **policy configuration**, **successful activation**, and **verified authentication/authorization evidence**.

## References

- [Microsoft Learn — Assign Microsoft Entra roles in PIM](https://learn.microsoft.com/en-us/entra/id-governance/privileged-identity-management/pim-how-to-add-role-to-user)
- [Microsoft Learn — Configure Microsoft Entra role settings in PIM](https://learn.microsoft.com/en-us/entra/id-governance/privileged-identity-management/pim-how-to-change-default-settings)
- [Microsoft Learn — Activate Microsoft Entra roles in PIM](https://learn.microsoft.com/en-us/entra/id-governance/privileged-identity-management/pim-how-to-activate-role)

---

**Project type:** Personal IAM security lab / portfolio demonstration. Not a production deployment or an independent security audit.
