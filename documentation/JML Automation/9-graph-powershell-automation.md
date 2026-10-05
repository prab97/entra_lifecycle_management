# Microsoft Graph + PowerShell Automation

## Purpose

Microsoft Graph PowerShell is used to automate Microsoft
Entra ID identity lifecycle management tasks.

## Authentication

The initial implementation uses delegated Microsoft Graph
authentication with an authorized administrative account.

Required permissions:

- User.Read.All
- Group.ReadWrite.All

## Automation Architecture

PowerShell
    ↓
Microsoft Graph PowerShell SDK
    ↓
Microsoft Graph API
    ↓
Microsoft Entra ID

## Validation

The PowerShell automation was tested by:

1. Connecting to Microsoft Graph.
2. Reading the current Graph context.
3. Retrieving Entra ID users.
4. Retrieving Entra ID groups.

## Security

The initial implementation uses interactive delegated
authentication for controlled lab testing.

Production automation should use an appropriately secured
app-only authentication method with least-privilege
permissions.