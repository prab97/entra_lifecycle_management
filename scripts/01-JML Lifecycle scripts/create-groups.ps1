# Microsoft Graph - Automated Group Management

Import-Module Microsoft.Graph.Groups

$CsvPath = "C:\Users\Prashant\Desktop\Entra\data\groups.csv" #Path hardcoded; change if using in another device.

Write-Host " OliverPay Group Automation"
Write-Host "========================================="

# Verify Graph connection
$Context = Get-MgContext

if (-not $Context) {
    Write-Error "Microsoft Graph is not connected."
    exit 1
}

Write-Host "Connected as: $($Context.Account)"
Write-Host "Tenant ID: $($Context.TenantId)"
Write-Host ""

$Groups = Import-Csv $CsvPath

foreach ($Group in $Groups) {

    Write-Host ""
    Write-Host "-----------------------------------------"
    Write-Host "Processing: $($Group.GroupName)"
    Write-Host "-----------------------------------------"

    # Check whether group already exists
    $ExistingGroup = Get-MgGroup -All |
        Where-Object {
            $_.DisplayName -eq $Group.GroupName
        }

    if ($ExistingGroup) {

        Write-Host "SKIPPED - Group already exists." 
        Write-Host "Group ID: $($ExistingGroup.Id)"

        continue
    }

# Create security group
$GroupParams = @{
        displayName = $Group.GroupName
        description = $Group.Description
        mailEnabled = $false
        mailNickname = ($Group.GroupName -replace '[^a-zA-Z0-9]', '')
        securityEnabled = $true
        groupTypes = @()
    }

try {

        $NewGroup = New-MgGroup -BodyParameter $GroupParams

        Write-Host "CREATED successfully." -ForegroundColor Green
        Write-Host "Group ID: $($NewGroup.Id)"
        Write-Host "Display Name: $($NewGroup.DisplayName)"
    }
    catch {

        Write-Host "FAILED to create group." -ForegroundColor Red
        Write-Host $_.Exception.Message
    }
}

Write-Host ""
Write-Host " Group provisioning complete"
Write-Host "========================================="