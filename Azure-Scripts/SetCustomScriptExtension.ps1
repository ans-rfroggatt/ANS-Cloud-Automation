#Parameter Declaration
Param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$username,
    [Parameter(Mandatory=$true, Position=0)]
    $password,
    [Parameter(Mandatory=$true, Position=0)]
    [string]$subid,
    [Parameter(Mandatory=$true, Position=0)]
    [string]$resourceGroup,
    [Parameter(Mandatory=$true, Position=0)]
    [string]$windowsapi,
    [Parameter(Mandatory=$true, Position=0)]
    [string]$linuxapi
)

Write-Output "ANS Azure CloudHealth Agent Install <br />"
Write-Output "Version 4.0.0 <br />"
Write-Output "<p> </p>"

#Build Credentials
$secpassword = ConvertTo-SecureString -String $password -AsPlainText -Force
$Credentials = New-Object System.Management.Automation.PSCredential ($username, $secpassword)

#Create Windows OS Agent Install Script
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Creating Windows Agent Install Script <br />"
$content = '
#Create Temp Directory
New-Item -ItemType Directory -Path C:\Temp

#Download CloudHealth Agent
Invoke-WebRequest -OutFile C:\Temp\CloudHealthAgent.exe https://s3.amazonaws.com/remote-collector/agent/windows/18/CloudHealthAgent.exe

#Install CloudHealth Agent
C:\Temp\CloudHealthAgent.exe /S /v"/l* install.log /qn CLOUDNAME=azure CHTAPIKEY='+$windowsapi+'"
'
$content | Out-File './WindowsCloudHealthAgentInstall.ps1'
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Created Windows Agent Install Script Successfully <br />"

#Create Linux OS Agent Install Script
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Creating Linux Agent Install Script <br />"
$content = '
#!/bin/bash
#Download CloudHealth Agent
wget https://s3.amazonaws.com/remote-collector/agent/v18/install_cht_perfmon.sh -O /tmp/install_cht_perfmon.sh;

#Install CloudHealth Agent
sudo sh /tmp/install_cht_perfmon.sh 18 '+$linuxapi+' azure;
'
$content | Out-File './LinuxCloudHealthAgentInstall.sh'
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Created Linux Agent Install Script Successfully <br />"



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


#Static Parameters
$StorageAccount = "cloudhealthagent"
$Container = "scripts"
$FileUrlWindows = "https://cloudhealthagent.blob.core.windows.net/scripts/WindowsCloudHealthAgentInstall.ps1"
$FileNameWindows = "WindowsCloudHealthAgentInstall.ps1"
$ExtensionName = "CloudHealthExtension"
$StorageAccountKey = "YfOaZDO2kdiMzHNxTiBpdTuJwM6/ZYT+m6V3K43n8N3yxclC14y2rcUegqGZdDMYDLexEvGQk9qZ8wYfzksUNA=="
$ProtectedSettings = '{"storageAccountName":"' + $StorageAccount + '","storageAccountKey":"' + $StorageAccountKey + '"}';
$Settings = '{
    "fileUris": ["https://cloudhealthtesting.blob.core.windows.net/agentinstall/LinuxCloudHealthAgentInstall.sh"], 
    "commandToExecute": "sh LinuxCloudHealthAgentInstall.sh"
}';

#Create Storage Context
$Context = New-AzureStorageContext -StorageAccountName $StorageAccount -StorageAccountKey $StorageAccountKey

#Upload Windows OS Agent Install Script to Storage Account
Get-AzureStorageBlob -Container $Container -Blob 'WindowsCloudHealthAgentInstall.ps1' -Context $Context.Context | Set-AzureStorageBlobContent -File 'WindowsCloudHealthAgentInstall.ps1' -Force

#Upload Linux OS Agent Install Script to Storage Account
Get-AzureStorageBlob -Container $Container -Blob 'LinuxCloudHealthAgentInstall.sh' -Context $Context.Context | Set-AzureStorageBlobContent -File 'LinuxCloudHealthAgentInstall.sh' -Force


#GatherVMs
$VMs = Get-AzureRmVM -ResourceGroupName $resourceGroup
$vmOutput = @()
$VMs | ForEach-Object {
$tmpObj = New-Object -TypeName PSObject
$tmpObj | Add-Member -MemberType Noteproperty -Name "VMName" -Value $_.Name
$tmpObj | Add-Member -MemberType Noteproperty -Name "OStype" -Value $_.StorageProfile.OsDisk.OsType
$tmpObj | Add-Member -MemberType Noteproperty -Name "VMResourceGroup" -Value $_.ResourceGroupName
$tmpObj | Add-Member -MemberType Noteproperty -Name "Location" -Value $_.location
$vmOutput += $tmpObj
}
$vmoutput

#Filter Windows VMs
$WindowsVM = $vmoutput | where 'OStype' -eq "Windows"

#Filter Linux VMs
$LinuxVM = $vmoutput | where 'OStype' -eq "Linux"

#Add Custom Script Extension to Windows VMs
foreach ($VM in $WindowsVM)
{
	$resourceGroup = $VM.VMResourceGroup
	$VMName = $VM.VMName
    $location = $VM.Location
    Write-Output "Setting extension on VM " $vmname " <br />"
	Set-AzureRmVMCustomScriptExtension -Name $ExtensionName -ResourceGroupName $resourceGroup -VMName $VMName -Location $location -FileUri $FileUrlWindows -Run $FileNameWindows
}

#Add Custom Script Extension to Linux VMs
foreach ($VM in $LinuxVM)
{
	$resourceGroup = $VM.VMResourceGroup
	$VMName = $VM.VMName
    $location = $VM.Location
    Write-Output "Setting extension on VM " $vmname " <br />"
    Set-AzureRmVMExtension -Name $ExtensionName -ResourceGroupName $resourceGroup -VMName $VMName -Location $location -Publisher "Microsoft.OSTCExtensions" -ExtensionType  "CustomScriptForLinux" -TypeHandlerVersion "1.5" -Settingstring $Settings -ProtectedSettingString $ProtectedSettings
}

Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] VM Extensions have been added successfully <br />"