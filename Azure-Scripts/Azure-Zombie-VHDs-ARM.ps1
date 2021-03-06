﻿#Parameter Declaration
Param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$username,
    [Parameter(Mandatory=$true, Position=0)]
    $password,
    [Parameter(Mandatory=$true, Position=0)]
    [string]$subid,
    [Parameter(Mandatory=$true, Position=0)]
    [string]$option,
    [Parameter(Position=0)]
    [string]$resourcegroup,
    [Parameter(Position=0)]
    [string]$StorageAccountName,
    [Parameter(Position=0)]
    [string]$SearchString
)


Write-Output "ANS Azure Zombie VHDs <br />"
Write-Output "Version 2.0.0 <br />"
Write-Output "<p> </p>"

#Build Credentials
$secpassword = ConvertTo-SecureString -String $password -AsPlainText -Force
$Credentials = New-Object System.Management.Automation.PSCredential ($username, $secpassword)

#Import AzureRM Module
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Importing module AzureRM... <br />"
Import-Module -Name AzureRM -ErrorVariable AzureModuleError -ErrorAction SilentlyContinue
if ($AzureModuleError) {
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Module Error - $ModuleError <br />"
Write-Output "<p> </p>"
}
else {
"<br />"
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Successfully Imported AzureRM module <br />"
Write-Output "<p> </p>"
}

Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Importing module AzureStorage... <br />"
Import-Module -Name Azure.Storage -ErrorVariable StorageModuleError -ErrorAction SilentlyContinue
if ($StorageModuleError) {
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Module Error - $StorageModuleError <br />"
Write-Output "<p> </p>"
}
else {
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Successfully Imported AzureStorage module <br />"
Write-Output "<p> </p>"
}

#Create File Name
$file = $username.Split('@')
$file = $file[0] + $subid

#Set CSV Headers and Path
$CSVPath = "$PSScriptRoot\..\Azure-Script-Exports"
Write-Output "<p> </p>"
"""Uri"",""AttachedToVMName"",""Lease Status"",""Lease State"",""Storage Type"",""Storage Tier"",""StorageAccount Name"",""Location"",""Resource Group"",""Size GB""" | Out-File -Encoding ASCII -FilePath "$CSVPath\$file-ARMVHD-CSV.csv"


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

#Option 1 - Collect for Single Storage Account
If ($option -eq "1") {

    $StorageAccount = Get-AzureRmStorageAccount -ResourceGroupName $resourcegroup -Name $StorageAccountName
    foreach ($Container in $StorageAccount | Get-AzureStorageContainer) {
        Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Processing Container -" $Container.Name " <br />"
        foreach ($VHD in $Container | Get-AzureStorageBlob | Where {$_.Name -like '*.vhd'}) {
        
            #Append VHD to CSV
            """"+$VHD.ICloudBlob.Uri.AbsoluteUri+""","""+$VHD.ICloudBlob.Metadata.MicrosoftAzureCompute_VMName+""","""+$VHD.ICloudBlob.Properties.LeaseStatus+""","""+
            $VHD.ICloudBlob.Properties.LeaseState+""","""+$StorageAccount.Sku.Name+""","""+$StorageAccount.Sku.Tier+""","""+$StorageAccount.StorageAccountName+""","""+
            $StorageAccount.Location+""","""+$StorageAccount.ResourceGroupName+""","""+$VHD.Length / 1024 / 1024 / 1024+"""" | 
            Out-File -Encoding ASCII -FilePath "$CSVPath\$file-ARMVHD-CSV.csv" -Append
        }
    }
}


#Option 2 - Collect Storage Accounts that match input string
If ($option -eq "2") {

    #Parse each storage account based on input string
    foreach ($StorageAccount in Get-AzureRmStorageAccount | Where {$_.StorageAccountName -match $SearchString}) {
        Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Processing Storage Account -" $StorageAccount.StorageAccountName " <br />"

        #Parse each container in Storage Account
        foreach ($Container in $StorageAccount | Get-AzureStorageContainer) {
            Write-Output "                    Processing Container -" $Container.Name " <br />"

            #Parse each VHD in Container
            foreach ($VHD in $Container | Get-AzureStorageBlob | Where {$_.Name -like '*.vhd'}) {
        
                #Append VHD to CSV
                """"+$VHD.ICloudBlob.Uri.AbsoluteUri+""","""+$VHD.ICloudBlob.Metadata.MicrosoftAzureCompute_VMName+""","""+$VHD.ICloudBlob.Properties.LeaseStatus+""","""+
                $VHD.ICloudBlob.Properties.LeaseState+""","""+$StorageAccount.Sku.Name+""","""+$StorageAccount.Sku.Tier+""","""+$StorageAccount.StorageAccountName+""","""+
                $StorageAccount.Location+""","""+$StorageAccount.ResourceGroupName+""","""+$VHD.Length / 1024 / 1024 / 1024+"""" | 
                Out-File -Encoding ASCII -FilePath "$CSVPath\$file-ARMVHD-CSV.csv" -Append
            }
        }
    }
}



#Option 3 - Collect data for all storage accounts.
If ($option -eq "3") {
    foreach ($StorageAccount in Get-AzureRmStorageAccount) {
        Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Processing Storage Account -" $StorageAccount.StorageAccountName " <br />"

        foreach ($Container in $StorageAccount | Get-AzureStorageContainer) {
            Write-Output "                    Processing Container -" $Container.Name " <br />"
            foreach ($VHD in $Container | Get-AzureStorageBlob | Where {$_.Name -like '*.vhd'}) {
        
                #Append VHD to CSV
                """"+$VHD.ICloudBlob.Uri.AbsoluteUri+""","""+$VHD.ICloudBlob.Metadata.MicrosoftAzureCompute_VMName+""","""+$VHD.ICloudBlob.Properties.LeaseStatus+""","""+
                $VHD.ICloudBlob.Properties.LeaseState+""","""+$StorageAccount.Sku.Name+""","""+$StorageAccount.Sku.Tier+""","""+$StorageAccount.StorageAccountName+""","""+
                $StorageAccount.Location+""","""+$StorageAccount.ResourceGroupName+""","""+$VHD.Length / 1024 / 1024 / 1024+"""" | 
                Out-File -Encoding ASCII -FilePath "$CSVPath\$file-ARMVHD-CSV.csv" -Append
            }
        }
    }
}