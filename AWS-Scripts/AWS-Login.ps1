#Parameter Declaration
Param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$Customer,
    [Parameter(Mandatory=$true, Position=0)]
    [string]$AccessKey,
    [Parameter(Mandatory=$true, Position=0)]
    $SecretKey
)


Write-Output "AWS Login Test <br />"
Write-Output "Version 2.0.0 <br />"
Write-Output "<p> </p>"


#Build Secure Credentials
$SecAccessKey = ConvertTo-SecureString -String $AccessKey -AsPlainText -Force
$SecSecretKey = ConvertTo-SecureString -String $SecretKey -AsPlainText -Force

#Import AWS PowerShell Module
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Importing module... <br />"
Import-Module -Name AWSPowerShell -ErrorVariable ModuleError -ErrorAction SilentlyContinue
if ($ModuleError) {
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Module Error - $ModuleError <br />"
Write-Output "<p> </p>"
}
else {
"<br />"
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Successfully Imported module <br />"
Write-Output "<p> </p>"
}

#Login to AWS
Write-Output "<p> </p>"
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Logging in to AWS Account... <br />"
Set-AWSCredentials -AccessKey $SecAccessKey -SecretKey $SecSecretKey -ErrorVariable LoginError -ErrorAction SilentlyContinue
if ($LoginError) {
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Login Error - $LoginError <br />"
Write-Output "<p> </p>"
}
else {
"<br />"
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Successfully logged in to AWS Account <br />"
Write-Output "<p> </p>"
}