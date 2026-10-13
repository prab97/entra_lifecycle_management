# Add an Entra user to an assigned security group

Import-Module Microsoft.Graph.Users
Import-Module Microsoft.Graph.Groups

$UserDisplayName = Read-Host "Enter user display name"
$GroupDisplayName = Read-Host "Enter group display name"

Write-Host ""
Write-Host "Finding user..."

$User = Get-MgUser -All |
    Where-Object {
        $_.DisplayName -eq $UserDisplayName
    }

if (-not $User) {
    Write-Host "User not found." 
    exit 1
}

Write-Host "User found: $($User.DisplayName)"

Write-Host ""
Write-Host "Finding group..."

$Group = Get-MgGroup -All |
    Where-Object {
        $_.DisplayName -eq $GroupDisplayName
    }

if (-not $Group) {
    Write-Host "Group not found." 
    exit 1
}

Write-Host "Group found: $($Group.DisplayName)"

Write-Host ""
Write-Host "Adding user to group..."

$MemberReference = @{
    "@odata.id" = "https://graph.microsoft.com/v1.0/directoryObjects/$($User.Id)"
}

try {

    New-MgGroupMemberByRef `
        -GroupId $Group.Id `
        -BodyParameter $MemberReference

    Write-Host ""
    Write-Host "SUCCESS - User added to group." -ForegroundColor Green

}
catch {

    Write-Host ""
    Write-Host "FAILED - Could not add user to group." -ForegroundColor Red
    Write-Host $_.Exception.Message
}