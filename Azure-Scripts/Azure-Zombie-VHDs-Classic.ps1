Param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$username,
    [Parameter(Mandatory=$true, Position=0)]
    $password,
    [Parameter(Mandatory=$true, Position=0)]
    [string]$subid
)


Write-Output "ANS Azure Zombie VHDs (Classic) <br />"
Write-Output "Version 2.0.0 <br />"
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

#Create File Name
$file = $username.Split('@')
$file = $file[0] + $subid

#Set CSV Headers and Path
$CSVPath = "$PSScriptRoot\..\Azure-Script-Exports"

$DISKOUTPUT = @()
foreach ($STORAGEACCOUNT in Get-AzureStorageAccount )
    {
    Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Processing Storage Account - $STORAGEACCOUNT <br />"
    
    Get-AzureDisk | where-Object {$_.MediaLink.Host.Contains($STORAGEACCOUNT.StorageAccountName)} | Where-Object -Property AttachedTo -EQ $null | 
    Select @{L="StorageAccount";E={$STORAGEACCOUNT.StorageAccountName}}, DiskName, DiskSizeInGB, SourceImageName, Location | ForEach-Object {
        $_
        $tmpObj = New-Object -TypeName PSObject
        $tmpObj | Add-Member -MemberType Noteproperty -Name "StorageAccount" -Value $STORAGEACCOUNT.StorageAccountName
        $tmpObj | Add-Member -MemberType Noteproperty -Name "StorageAccountSKU" -Value ($STORAGEACCOUNT.AccountType)
        $tmpObj | Add-Member -MemberType Noteproperty -Name "ResourceType" -Value "CLASSIC"
        $tmpObj | Add-Member -MemberType Noteproperty -Name "DiskName" -Value $_.DiskName
        $tmpObj | Add-Member -MemberType Noteproperty -Name "DiskSizeInGB" -Value $_.DiskSizeInGB
        $tmpObj | Add-Member -MemberType Noteproperty -Name "SourceImageName" -Value $_.SourceImageName
        $tmpObj | Add-Member -MemberType Noteproperty -Name "Location" -Value $_.location
        #$tmpObj
        $DISKOUTPUT += $tmpObj
    }
}
$DISKOUTPUT | Export-csv -NoTypeInformation "$CSVPath\$file-ASMVHD-CSV.csv"



