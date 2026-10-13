# Automated Leaver / Offboarding Script

Import-Module Microsoft.Graph.Users
Import-Module Microsoft.Graph.Groups

# Create audit log directory
$LogPath = "C:\Users\Prashant\Desktop\Entra\logs"

New-Item -ItemType Directory -Path $LogPath -Force | Out-Null

# Ask for user
$UserUPN = Read-Host "Enter user principal name"

Write-Host ""
Write-Host "Finding user..."

$User = Get-MgUser -All |
    Where-Object {
        $_.UserPrincipalName -eq $UserUPN
    }

if (-not $User) {
    Write-Host "User not found." -ForegroundColor Red
    exit 1
}

Write-Host "User found: $($User.DisplayName)" -ForegroundColor Green

# Find LEAVER-HOLD group
Write-Host ""
Write-Host "Finding LEAVER-HOLD group..."

$LeaverHold = Get-MgGroup -All |
    Where-Object {
        $_.DisplayName -eq "LEAVER-HOLD"
    }

if (-not $LeaverHold) {
    Write-Host "LEAVER-HOLD group not found." -ForegroundColor Red
    exit 1
}

Write-Host "LEAVER-HOLD found." -ForegroundColor Green

# Capture current state
$AccountEnabledBefore = [bool]$User.AccountEnabled

Write-Host ""
Write-Host "Current account state: $AccountEnabledBefore"

# Check existing LEAVER-HOLD membership
Write-Host ""
Write-Host "Checking LEAVER-HOLD membership..."

$ExistingMember = Get-MgGroupMember `
    -GroupId $LeaverHold.Id `
    -All |
    Where-Object {
        $_.Id -eq $User.Id
    }

$HoldMembershipBefore = [bool]$ExistingMember

# Add user to LEAVER-HOLD if needed
$HoldAdded = $false

if (-not $ExistingMember) {

    Write-Host "Adding user to LEAVER-HOLD..."

    $MemberReference = @{
        "@odata.id" = "https://graph.microsoft.com/v1.0/directoryObjects/$($User.Id)"
    }

    New-MgGroupMemberByRef `
        -GroupId $LeaverHold.Id `
        -BodyParameter $MemberReference

    $HoldAdded = $true

    Write-Host "User added to LEAVER-HOLD." -ForegroundColor Green
}
else {

    Write-Host "User is already a member of LEAVER-HOLD." -ForegroundColor Yellow
}

# Disable account
if ($User.AccountEnabled) {

    Write-Host ""
    Write-Host "Disabling account..."

    $UpdateParams = @{
        accountEnabled = $false
    }

    Update-MgUser `
        -UserId $User.Id `
        -BodyParameter $UpdateParams

    Write-Host "Account disabled." -ForegroundColor Green
}
else {

    Write-Host ""
    Write-Host "Account is already disabled." -ForegroundColor Yellow
}

# Re-read user to verify final state
$AfterUser = Get-MgUser -UserId $User.Id

$AccountEnabledAfter = [bool]$AfterUser.AccountEnabled

# Verify LEAVER-HOLD membership
$FinalMember = Get-MgGroupMember `
    -GroupId $LeaverHold.Id `
    -All |
    Where-Object {
        $_.Id -eq $User.Id
    }

$HoldMembershipAfter = [bool]$FinalMember

# Determine result
if (
    ($AccountEnabledAfter -eq $false) -and
    ($HoldMembershipAfter -eq $true)
) {
    $Result = "SUCCESS"
}
else {
    $Result = "REVIEW REQUIRED"
}

# Create audit record
$AuditRecord = [PSCustomObject]@{
    Timestamp               = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    UserDisplayName         = $AfterUser.DisplayName
    UserPrincipalName       = $AfterUser.UserPrincipalName
    UserId                  = $AfterUser.Id
    Department              = $AfterUser.Department
    JobTitle                = $AfterUser.JobTitle
    AccountEnabledBefore    = $AccountEnabledBefore
    AccountEnabledAfter     = $AccountEnabledAfter
    LeaverHoldGroup         = $LeaverHold.DisplayName
    HoldMembershipBefore    = $HoldMembershipBefore
    HoldMembershipAfter     = $HoldMembershipAfter
    HoldAddedByScript       = $HoldAdded
    Action                  = "Automated Leaver Offboarding"
    Result                  = $Result
}

# Save audit log
$Timestamp = Get-Date -Format "yyyyMMdd-HHmmss"

$LogFile = Join-Path `
    $LogPath `
    "offboarding-$Timestamp.csv"

$AuditRecord |
    Export-Csv `
        -Path $LogFile `
        -NoTypeInformation

# Display result
Write-Host ""
Write-Host "OFFBOARDING RESULT"
Write-Host "========================================"

$AuditRecord | Format-List

Write-Host ""
Write-Host "Audit log created:"
Write-Host $LogFile 