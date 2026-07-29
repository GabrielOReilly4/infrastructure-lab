param(
    [Parameter(Mandatory = $true)]
    [string]$Username
)

Import-Module ActiveDirectory

$User = Get-ADUser `
    -Identity $Username `
    -Properties MemberOf, Enabled `
    -ErrorAction SilentlyContinue

if (-not $User) {
    Write-Error "User '$Username' was not found."
    exit 1
}

if (-not $User.Enabled) {
    Write-Warning "User '$Username' is already disabled."
    exit 0
}

$ProtectedGroups = @(
    "Domain Users"
)

foreach ($GroupDN in $User.MemberOf) {
    $Group = Get-ADGroup -Identity $GroupDN

    if ($Group.Name -notin $ProtectedGroups) {
        Remove-ADGroupMember `
            -Identity $Group `
            -Members $User `
            -Confirm:$false

        Write-Host "Removed $Username from group $($Group.Name)."
    }
}

Disable-ADAccount -Identity $Username

Set-ADUser `
    -Identity $Username `
    -Description "Disabled through PowerShell offboarding script"

Write-Host "User '$Username' was disabled successfully."