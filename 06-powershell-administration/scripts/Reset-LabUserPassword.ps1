param(
    [Parameter(Mandatory = $true)]
    [string]$Username,

    [Parameter(Mandatory = $true)]
    [string]$NewPassword
)

Import-Module ActiveDirectory

$User = Get-ADUser `
    -Identity $Username `
    -ErrorAction SilentlyContinue

if (-not $User) {
    Write-Error "User '$Username' was not found."
    exit 1
}

$SecurePassword = ConvertTo-SecureString `
    $NewPassword `
    -AsPlainText `
    -Force

Set-ADAccountPassword `
    -Identity $Username `
    -NewPassword $SecurePassword `
    -Reset

Set-ADUser `
    -Identity $Username `
    -ChangePasswordAtLogon $true

Unlock-ADAccount `
    -Identity $Username `
    -ErrorAction SilentlyContinue

Write-Host "Password reset successfully for '$Username'."
Write-Host "The user must change the password at the next logon."