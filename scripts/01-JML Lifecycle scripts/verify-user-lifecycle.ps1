#MS Graph - User Lifecycle Verification
Import-Module Microsoft.Graph.Users
Import-Module Microsoft.Graph.Groups

$UserDisplayName = Read-Host "Enter the user's display name."

Write-Host ""
Write-Host "User Lifecycle Verification"

#Find User
$User = Get-MgUser -All | Where-Object { $_.DisplayName -eq $UserDisplayName
}

if (-not $User) {
  Write-Host "User not found." -Foreground Red
  exit 1
}



Write-Host "User:"
Write-Host "------------------------------"
Write-Host "Display Name : $($User.DisplayName)"
Write-Host "UPN          : $($User.UserPrincipalName)"
Write-Host "Department   : $($User.Department)"
Write-Host "Job Title    : $($User.JobTitle)"
Write-Host "Enabled      : $($User.AccountEnabled)"
Write-Host "Object ID    : $($User.Id)"

#Retrieve direct group memberships

Write-Host "Group Memberships"
Write-Host "================="

$Groups = Get-MgUserMemberOfAsGroup `
    -UserId $User.Id `
    -All

if ($Groups) {

    $Groups |
        Select-Object DisplayName, Id |
        Format-Table -AutoSize

}
else {

    Write-Host "No direct group memberships found."

}

Write-Host ""
Write-Host "========================================="
Write-Host " Verification complete"