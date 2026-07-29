Import-Module ActiveDirectory

$OutputFolder = Join-Path $PSScriptRoot "..\reports"
$OutputFile = Join-Path $OutputFolder "ad-users-report.csv"

if (-not (Test-Path $OutputFolder)) {
    New-Item -ItemType Directory -Path $OutputFolder | Out-Null
}

Get-ADUser `
    -Filter * `
    -SearchBase "OU=OU_Users,DC=lab,DC=local" `
    -Properties Department, Enabled, WhenCreated |
Select-Object `
    Name,
    SamAccountName,
    Department,
    Enabled,
    WhenCreated |
Export-Csv `
    -Path $OutputFile `
    -NoTypeInformation `
    -Encoding UTF8

Write-Host "Report exported to: $OutputFile"