# Automated Group Management

## Purpose

Microsoft Graph PowerShell is used to automate the creation
of assigned security groups and group membership.

## Groups

The automation creates:

- LAB-AUTO-Engineering
- LAB-AUTO-Finance
- LAB-AUTO-IT
- LAB-AUTO-HR
- LAB-AUTO-Sales

## Group Type

The groups are assigned security groups.

They are intentionally separate from the existing dynamic
groups used for attribute-driven access.

## Membership Automation

The `add-user-to-group.ps1` script:

1. Finds a user.
2. Finds a security group.
3. Creates a Microsoft Graph directory-object reference.
4. Adds the user to the group.
5. Reports the result.

## Example

User:

Jeremy White

Department:

Engineering

Group:

LAB-AUTO-Engineering

## Architecture

PowerShell
↓
Microsoft Graph
↓
Security Group
↓
Group Membership
↓
Access Control

## Validation

Group creation and user membership were verified using
Microsoft Graph PowerShell commands.

## Security

The automation uses the existing delegated Graph session
and `Group.ReadWrite.All` permission for controlled lab
testing.