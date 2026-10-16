Employee leaves OliverPay
        ↓
Disable account
        ↓
Remove access
        ↓
Remove group memberships
        ↓
Preserve required information
        ↓
Record evidence


Conceptually:
Active employee
       ↓
Normal groups
       ↓
Application access


Leaver
       ↓
Account disabled
       ↓
LEAVER-HOLD
       ↓
Review / retention / cleanup

# Leaver Scenario

## Scenario

John Miller leaves OliverPay.

## Before Offboarding

User:

John Miller

Department:

Finance

Account:

Enabled

Access:

SEC-DYN-Finance

Application:

OliverPay Finance Portal

## Offboarding Actions

1. Account disabled.
2. Existing group memberships reviewed.
3. Application access reviewed.
4. Leaver status recorded.
5. Required information retained according to organizational policy.
6. Remaining access scheduled for cleanup.

## Expected Security State

John should no longer be able to authenticate using the
disabled account.

Application and group access should be reviewed and removed
according to the organization's offboarding policy.

## Important Observation

Disabling a user account and removing group membership are
separate operations.

A dynamic group based only on:

    user.department -eq "Finance"

does not inherently mean that a disabled Finance user will
automatically disappear from the group.

This demonstrates why identity lifecycle processes require
explicit offboarding logic.

## IAM Principle

Offboarding should be systematic, auditable, and based on
defined organizational controls rather than ad-hoc manual
actions.