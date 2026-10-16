# Automated User Verification

## Purpose

Microsoft Graph PowerShell is used to verify that users
created through automation have the expected identity
attributes and group memberships.

## Test User

Jeremy White

## Verification

The following attributes were verified:

- Display Name
- User Principal Name
- Department
- Job Title
- Account Enabled
- Microsoft Entra Object ID

## Group Evaluation

Jeremy White was provisioned with:

Department = Engineering

The existing dynamic group rule:

user.department -eq "Engineering"

was used to determine membership in:

SEC-DYN-Engineering

## Access Model

The dynamic group is assigned to:

OliverPay Engineering Portal

Therefore, the automated provisioning process integrates
with the existing group-based application access model.

## Automation Flow

CSV
↓
PowerShell
↓
Microsoft Graph
↓
Entra ID User
↓
Department Attribute
↓
Dynamic Group
↓
Enterprise Application Access

## Verification Script

scripts/verify-user-lifecycle.ps1