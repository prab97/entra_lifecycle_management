# Automated Leaver / Offboarding

## Purpose

This scenario demonstrates automated employee offboarding
using Microsoft Graph PowerShell.

The automation performs controlled identity lifecycle actions
when an employee leaves the organization.

## Process

The workflow is:

1. Find the employee.
2. Capture the current account state.
3. Check LEAVER-HOLD membership.
4. Add the employee to LEAVER-HOLD if required.
5. Disable the Entra ID account.
6. Re-read the account to verify the change.
7. Verify LEAVER-HOLD membership.
8. Generate an audit CSV.

## Example User

User:

Olivia Leaver

Department:

Engineering

Job Title:

Test Leaver

## Offboarding Controls

The automation:

- disables the account
- adds the account to LEAVER-HOLD
- verifies the resulting state
- creates an audit record

The user is not deleted.

## Dynamic Group Consideration

Dynamic group membership is controlled by group rules.

The automation does not attempt to manually remove users
from dynamic groups.

Instead, the account is disabled and the explicit
LEAVER-HOLD group provides a controlled offboarding state.

## Audit

Each execution creates a timestamped CSV file under:

logs/

Example:

offboarding-YYYYMMDD-HHmmss.csv

The audit record contains:

- timestamp
- user identity
- department
- job title
- account state before
- account state after
- LEAVER-HOLD membership
- automation result

## Architecture

PowerShell
↓
Microsoft Graph
↓
Entra ID User
↓
Disable Account
↓
LEAVER-HOLD
↓
Audit Log

## Security

The automation uses the existing delegated Microsoft Graph
session established for the lab.

The automation does not store passwords or access tokens.

## Production Considerations

A production offboarding process may also require controlled
handling of:

- active sessions
- application assignments
- licenses
- privileged roles
- devices
- mailbox/data retention
- downstream applications
- HR termination records

Those controls are outside the scope of this lab script.