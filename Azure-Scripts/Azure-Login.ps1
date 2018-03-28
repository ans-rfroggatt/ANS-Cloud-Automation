#Parameter Declaration
Param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$username,
    [Parameter(Mandatory=$true, Position=0)]
    $password,
    [Parameter(Mandatory=$true, Position=0)]
    [string]$subid
)


Write-Output ""
Write-Output "Login Test <br />"
Write-Output "Version 1.0.0 <br />"
Write-Output "<p> </p>"

#Build Credentials
$secpassword = ConvertTo-SecureString -String $password -AsPlainText -Force
$Credentials = New-Object System.Management.Automation.PSCredential ($username, $secpassword)

#Import AzureRM Module
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Importing module... <br />"
Import-Module -Name AzureRM -ErrorVariable ModuleError -ErrorAction SilentlyContinue
if ($ModuleError) {
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Module Error - $ModuleError <br />"
Write-Output "<p> </p>"
}
else {
"<br />"
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Successfully Imported module <br />"
Write-Output "<p> </p>"
}

#Login to Azure Environment
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Logging in to Azure Account... <br />"
Login-AzureRmAccount -Credential $Credentials -ErrorVariable LoginError -ErrorAction SilentlyContinue
if ($LoginError) {
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Login Error - $LoginError <br />"
Write-Output "<p> </p>"
}
else {
"<br />"
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Successfully logged in to Azure Account <br />"
Write-Output "<p> </p>"
}

#Set Subscription Id
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Selecting Azure Subscripion <br />"
Select-AzureRmSubscription -SubscriptionId $subId  -ErrorVariable SubscriptionError -ErrorAction SilentlyContinue
if ($SubscriptionError) {
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Subscription Error - $SubscriptionError <br />"
Write-Output "<p> </p>"
}
else {
"<br />"
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Subscription successfully selected <br />"
Write-Output "<p> </p>"
}

#Get All Azure VMs
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Gathering all Virtual Machines... <br />"
$AllVMs = Get-AzureRmVM
Write-Output "$AllVMs <br />"
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] All Virtual Machines gathered successfully <br />"
Write-Output "<p> </p>"