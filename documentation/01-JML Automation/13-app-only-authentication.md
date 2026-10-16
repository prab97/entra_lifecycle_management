# App-Only Microsoft Graph Authentication

## Purpose

This stage demonstrates certificate-based app-only
authentication for Microsoft Graph PowerShell.

The automation authenticates as an Entra application rather
than as an interactive administrator.

## Architecture

PowerShell
    ↓
Certificate
    ↓
OliverPay-Graph-Automation
    ↓
Microsoft Graph
    ↓
Microsoft Entra ID

## Application

Application:

OliverPay-Graph-Automation

Authentication method:

Certificate-based authentication

Authentication type:

AppOnly

## Certificate

A self-signed certificate was created for the lab.

The public certificate was uploaded to the Entra application
registration.

The private key remains on the automation machine.

Private keys and secrets are not stored in the GitHub
repository.

## Initial Permission

The application was initially configured with:

Microsoft Graph
    → Application permissions
        → User.Read.All

Administrator consent was granted.

This permission was used to validate read-only app-only
authentication before introducing write permissions.

## Validation

The authentication was verified using:

Get-MgContext

The expected authentication type is:

AuthType : AppOnly

Graph access was then verified using:

Get-MgUser -Top 5

## Automation Script

The reusable connection script is:

scripts/connect-graph-app.ps1

The script:

1. Accepts the application ID.
2. Accepts the tenant ID.
3. Accepts the certificate thumbprint.
4. Connects to Microsoft Graph.
5. Verifies AppOnly authentication.
6. Tests Microsoft Graph user access.

## Security Considerations

The application should receive only the Microsoft Graph
permissions required for its automation tasks.

Credentials and private keys must not be committed to source
control.

The lab uses a self-signed certificate for demonstration.
Production implementations should use an appropriately
managed certificate and secure key storage.

## Result

Certificate-based app-only authentication was successfully
established and Microsoft Graph user data was retrieved
without an interactive user sign-in.