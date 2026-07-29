Import-Module ActiveDirectory

$CsvPath = Join-Path $PSScriptRoot "..\data\users.csv"
$UserOU = "OU=OU_Users,DC=lab,DC=local"

$Users = Import-Csv -Path $CsvPath

foreach ($User in $Users) {
    $ExistingUser = Get-ADUser `
        -Filter "SamAccountName -eq '$($User.Username)'" `
        -ErrorAction SilentlyContinue

    if ($ExistingUser) {
        Write-Warning "User $($User.Username) already exists. Skipping."
        continue
    }

    $SecurePassword = ConvertTo-SecureString `
        $User.Password `
        -AsPlainText `
        -Force

    $DisplayName = "$($User.FirstName) $($User.LastName)"
    $UserPrincipalName = "$($User.Username)@lab.local"

    try {
        New-ADUser `
            -Name $DisplayName `
            -GivenName $User.FirstName `
            -Surname $User.LastName `
            -DisplayName $DisplayName `
            -SamAccountName $User.Username `
            -UserPrincipalName $UserPrincipalName `
            -Department $User.Department `
            -Path $UserOU `
            -AccountPassword $SecurePassword `
            -Enabled $true `
            -ChangePasswordAtLogon $true

        Add-ADGroupMember `
            -Identity $User.Department `
            -Members $User.Username

        Write-Host "Created $DisplayName and added the account to $($User.Department)."
    }
    catch {
        Write-Error "Failed to create $($User.Username): $($_.Exception.Message)"
    }
}