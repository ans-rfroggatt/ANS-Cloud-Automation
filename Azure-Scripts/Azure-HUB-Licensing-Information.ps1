#Parameter Declaration
Param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$username,
    [Parameter(Mandatory=$true, Position=0)]
    $password,
    [Parameter(Mandatory=$true, Position=0)]
    [string]$subid
)


Write-Output "ANS - Azure HUB Licensing Information <br />"
Write-Output "Version 1.0.0 <br />"
Write-Output "<p> </p>"

#Build Credentials
$secpassword = ConvertTo-SecureString -String $password -AsPlainText -Force
$Credentials = New-Object System.Management.Automation.PSCredential ($username, $secpassword)


#Install and Import AzureRM Module
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Importing module... <br />"
Import-Module -Name AzureRM -ErrorVariable ModuleError -ErrorAction SilentlyContinue
If ($ModuleError) {
    Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Installing module... <br />"
    Install-Module -Name AzureRM
    Import-Module -Name AzureRM
    Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Successfully Installed module... <br />"
}
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

#Create File Name
$file = $username.Split('@')
$file = $file[0] + $subid

#Set CSV Headers and Path
$CSVPath = "\www\Azure-Script-Exports"

"""VMName"",""ResourceGroup"",""VMSize"",""HUB Enabled"",""Number of Cores"",""OSType"",""Required Licenses""" | Out-File -Encoding ASCII -FilePath "$CSVPath\$file-HubCSV.csv"


#Getting HUB Licensing Info
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Getting HUB Licensing Information for Windows Virtual Machines <br />"

foreach ($VM in Get-AzureRmVm | Where-Object {$_.StorageProfile.OsDisk.OsType -eq "Windows"}) {
    Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Processing VM -" $VM.Name "<br />"

    #Get HUB Licensing Status
    if ($VM.LicenseType -ne "Windows_Server") {$HUB = "False"
    }
    if ($VM.LicenseType -eq "Windows_Server") {$HUB = "True"
    }

    #Get Number of Cores
    $Cores = (Get-AzureRmVMSize -ResourceGroupName $VM.ResourceGroupName -VMName $VM.Name | Where-Object {$_.Name -eq $VM.HardwareProfile.VmSize}).NumberOfCores

    #Calculate Required Licenses
    if ($Cores -le 8) { $Licenses = "0.5"
    }
    if ($Cores -le 16 -and $Cores -ge 9) { $Licenses = "1"
    }
    if ($Cores -ge 17) { $Licenses = "VM Size not applicable"
    }

    #Write Output for VM to CSV
    """"+$VM.Name+""","""+$VM.ResourceGroupName+""","""+$VM.HardwareProfile.VmSize+""","""+$HUB+""","""+$Cores+""","""+$VM.StorageProfile.OsDisk.OsType+""","""+$Licenses+"""" | 
    Out-File -Encoding ASCII -FilePath "$CSVPath\$file-HubCSV.csv" -Append
}

Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] HUB Licensing Information Obtained Successfully! <br />"