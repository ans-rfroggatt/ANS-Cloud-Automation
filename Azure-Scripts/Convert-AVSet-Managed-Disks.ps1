Param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$username,
    [Parameter(Mandatory=$true, Position=0)]
    $password,
    [Parameter(Mandatory=$true, Position=0)]
    [string]$subid,
    [Parameter(Mandatory=$true, Position=0)]
    [string]$rgName,
    [Parameter(Mandatory=$true, Position=0)]
    [string]$avSetName,
    [Parameter(Mandatory=$true, Position=0)]
    [uint16]$Time
)

Write-Output "ANS Convert Azure Availabiltiy Set to Managed Disks <br />"
Write-Output "Version 1.2.0 <br />"
Write-Output "<p> </p>"

#Build Credentials
$secpassword = ConvertTo-SecureString -String $password -AsPlainText -Force
$Credentials = New-Object System.Management.Automation.PSCredential ($username, $secpassword)

#Import AzureRM Module
$env:PSModulePath = $env:PSModulePath + ";D:\home\site\wwwroot\Modules"
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Importing module... <br />"
Import-Module -Name AzureRM 
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Successfully Imported module <br />"
Write-Output "<p> </p>"

#Login to Azure Environment
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Logging in to Azure Account... <br />"
Login-AzureRmAccount -Credential $Credentials
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Successfully logged in to Azure Account <br />"
Write-Output "<p> </p>"

#Set Subscription Id
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Selecting Azure Subscripion <br />"
Select-AzureRmSubscription -SubscriptionId $subId
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Subscription successfully selected <br />"
Write-Output "<p> </p>"


#Convert Availability set to Managed
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Changing Availability set SKU to aligned <br />"

#Try with current number of fault domains
$avSet = Get-AzureRmAvailabilitySet -ResourceGroupName $rgName -Name $avSetName
Update-AzureRmAvailabilitySet -AvailabilitySet $avSet -Sku Aligned -ErrorAction SilentlyContinue

#If Error Try with 2 Fault Domains
if ($error.Count -gt 0) {
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Changing Availability set Fault Domains to 2 as current number is not supported <br />"
$avSet.PlatformFaultDomainCount = 2
Update-AzureRmAvailabilitySet -AvailabilitySet $avSet -Sku Aligned  
}

Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Availability set updated successfully <br />"

#Convert each VM disks to managed
$avSet = Get-AzureRmAvailabilitySet -ResourceGroupName $rgName -Name $avSetName
foreach($vm in $avSet.VirtualMachinesReferences)
{
  #Get VM Object  
  $vm = Get-AzureRmResource -ResourceId $vm.id

  #Stop VM
  Write-Output "<p> </p>"
  Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Stopping Virtual Machine -" $vm.Name " <br />"
  Stop-AzureRmVM -ResourceGroupName $rgName -Name $vm.Name -Force

  #Convert VM to Managed Disks
  Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Converting" $vm.Name "to Managed Disks <br />"
  ConvertTo-AzureRmVMManagedDisk -ResourceGroupName $rgName -VMName $vm.Name
  Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Converted" $vm.Name "to Managed Disks successfully <br />"

  #Start VM
  Start-AzureRmVM -ResourceGroupName $rgName -Name $vm.Name
  Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Virtual Machine" $vm.Name "started successfully <br />"

  #Wait for specified time period before proceeding
  Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Waiting for previous VM to boot and start application services - waiting for" $Time "seconds <br />"
  SLEEP $TIME
}