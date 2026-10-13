#MS Graph connection test script
#Organisation : OliverPay

Import-Module Microsoft.Graph
Write-Host "Connecting to Microsoft Graph..."

Connect-MgGraph -Scopes "User.Read.All", "Group.ReadWrite.All"

Write-Host "Connected"

Write-Host "Connected."

Write-Host "`nCurrent Graph Context:"
Get-MgContext | Select-Object Account,TenantId, Scopes

Write-Host "`n Testing User access..."

Get-MgUser -Top 4 | Select-Object DisplayName,UserPrincipalName, AccountEnabled

Write-Host "`n Testing group access..."
Get-MgGroup -Top 10 |
    Select-Object DisplayName, SecurityEnabled