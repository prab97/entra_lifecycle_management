
# Connect to Microsoft Graph using app-only certificate authentication

Import-Module Microsoft.Graph.Authentication
Import-Module Microsoft.Graph.Users


Write-Host "OliverPay Graph App-Only Connection"
Write-Host ""

$ClientId = Read-Host "Enter Application (Client) ID"
$TenantId = Read-Host "Enter Directory (Tenant) ID"
$CertificateThumbprint = Read-Host "Enter certificate thumbprint"

Write-Host ""
Write-Host "Connecting to Microsoft Graph..."

try {

    Connect-MgGraph `
        -ClientId $ClientId `
        -TenantId $TenantId `
        -CertificateThumbprint $CertificateThumbprint `
        -NoWelcome

}
catch {

    Write-Host ""
    Write-Host "FAILED - Could not connect to Microsoft Graph." `
        -ForegroundColor Red

    Write-Host $_.Exception.Message

    exit 1
}

$Context = Get-MgContext

Write-Host ""
Write-Host "Connection information:"
Write-Host ""

$Context |
    Select-Object `
        ClientId,
        TenantId,
        AuthType,
        AuthProviderType,
        Account,
        AppName |
    Format-List

if ($Context.AuthType -ne "AppOnly") {

    Write-Host ""
    Write-Host "WARNING - Authentication is not AppOnly." `
        -ForegroundColor Yellow

    exit 1
}

Write-Host ""
Write-Host "SUCCESS - App-only authentication confirmed." `
    -ForegroundColor Green

Write-Host ""
Write-Host "Testing Microsoft Graph user access..."

try {

    Get-MgUser -Top 5 |
        Select-Object `
            DisplayName,
            UserPrincipalName,
            AccountEnabled |
        Format-Table -AutoSize

}
catch {

    Write-Host ""
    Write-Host "FAILED - Graph user query failed." `
        -ForegroundColor Red

    Write-Host $_.Exception.Message

    exit 1
}

Write-Host ""
Write-Host "Graph user query completed successfully." `
    -ForegroundColor Green