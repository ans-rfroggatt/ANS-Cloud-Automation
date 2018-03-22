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
$env:PSModulePath = $env:PSModulePath + ";D:\home\site\wwwroot\Modules"

Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Importing module... <br />"
Import-Module -Name Azure
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Successfully Imported Module <br />"
Write-Output "<p> </p>"

#Login to Azure Environment
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Logging in to Azure Account... <br />"
Add-AzureAccount -Credential $Credentials
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Successfully logged in to Azure Account <br />"
Write-Output "<p> </p>"

#Select SubscriptionId
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Selecting Azure Subscripion <br />"
Select-AzureRmSubscription -SubscriptionId $subId
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Subscription successfully selected <br />"
Write-Output "<p> </p>"

#Create File Name
$file = $username.Split('@')
$file = $file[0] + $subid

#Set CSV Headers and Path
$CSVPath = "D:\home\site\wwwroot\Azure-Script-Exports"

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



