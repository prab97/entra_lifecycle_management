# OliverPay Identity Lifecycle Management Lab
# Microsoft Graph - Automated User Provisioning

Import-Module Microsoft.Graph.Users

$CsvPath = "C:\Users\Prashant\Desktop\Entra\data\users.csv"

Write-Host "========================================="
Write-Host " OliverPay User Provisioning"
Write-Host "========================================="

# Verify Microsoft Graph connection
$Context = Get-MgContext

if (-not $Context) {
    Write-Error "Microsoft Graph is not connected."
    exit 1
}

Write-Host "Connected as: $($Context.Account)"
Write-Host "Tenant ID: $($Context.TenantId)"
Write-Host ""

# Get tenant domain
$TenantDomain = Read-Host "Enter your Entra tenant domain"

# Get temporary password securely
$TemporaryPassword = Read-Host "Enter temporary password for the test users" -AsSecureString

$PlainPassword = [System.Net.NetworkCredential]::new(
    "",
    $TemporaryPassword
).Password

# Import users from CSV
$Users = Import-Csv $CsvPath

foreach ($User in $Users) {

    $MailNickname = "$($User.FirstName)$($User.LastName)".ToLower()

    $UserPrincipalName = "$MailNickname@$TenantDomain"

    Write-Host ""
    Write-Host "-----------------------------------------"
    Write-Host "Processing: $($User.FirstName) $($User.LastName)"
    Write-Host "UPN: $UserPrincipalName"
    Write-Host "-----------------------------------------"

    # Check whether the user already exists
    # Using local filtering instead of -Filter for compatibility
    $ExistingUser = Get-MgUser -All |
        Where-Object {
            $_.UserPrincipalName -eq $UserPrincipalName
        }

    if ($ExistingUser) {

        Write-Host "SKIPPED - User already exists." -ForegroundColor Yellow
        continue
    }

    # Build Microsoft Graph request body
    $UserParams = @{
        accountEnabled = $true

        displayName = "$($User.FirstName) $($User.LastName)"

        givenName = $User.FirstName

        surname = $User.LastName

        userPrincipalName = $UserPrincipalName

        mailNickname = $MailNickname

        department = $User.Department

        jobTitle = $User.JobTitle

        usageLocation = $User.UsageLocation

        passwordProfile = @{
            password = $PlainPassword
            forceChangePasswordNextSignIn = $true
        }
    }

    try {

        $NewUser = New-MgUser -BodyParameter $UserParams

        Write-Host "CREATED successfully." -ForegroundColor Green
        Write-Host "Object ID: $($NewUser.Id)"
        Write-Host "Display Name: $($NewUser.DisplayName)"
        Write-Host "Department: $($NewUser.Department)"
        Write-Host "Job Title: $($NewUser.JobTitle)"
    }
    catch {

        Write-Host "FAILED to create user." -ForegroundColor Red
        Write-Host $_.Exception.Message
    }
}

Write-Host ""
Write-Host "========================================="
Write-Host " Provisioning complete"
Write-Host "========================================="