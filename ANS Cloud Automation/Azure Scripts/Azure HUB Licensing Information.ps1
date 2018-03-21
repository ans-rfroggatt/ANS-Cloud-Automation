Write-Host ""
Write-Host "ANS - Azure HUB Licensing Information"
Write-Host "Version 1.0.0"
Write-Host ""
Write-Host ""

#Parameter Declaration
Param (
    [Parameter(Mandatory=$True)]
    [string]$username,

    [Parameter(Mandatory=$True)]
    [securestring]$password,
	
    [Parameter(Mandatory=$True)]
    [string]$subId
)

#Build Credentials
$Credentials = New-Object System.Management.Automation.PSCredential ($Username, $Password)


#Install and Import AzureRM Module
Write-Host "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Importing module..."
Import-Module -Name AzureRM -ErrorVariable ModuleError -ErrorAction SilentlyContinue
If ($ModuleError) {
    Write-Host "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Installing module..."
    Install-Module -Name AzureRM
    Import-Module -Name AzureRM
    Write-Host "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Successfully Installed module..."
}
Write-Host "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Successfully Imported module"
Write-Host ""


#Login to Azure Environment
Write-Host "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Logging in to Azure Account..."
Login-AzureRmAccount -Credential $Credentials
Write-Host "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Successfully logged in to Azure Account"
Write-Host ""

#Set Subscription Id
Write-Host "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Selecting Azure Subscripion"
Select-AzureRmSubscription -SubscriptionId $subId
Write-Host "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Subscription successfully selected"
Write-Host ""

#Set CSV Headers and Path
$CSVPath = "C:\Script Exports"

"""VMName"",""ResourceGroup"",""VMSize"",""HUB Enabled"",""Number of Cores"",""OSType"",""Required Licenses""" | Out-File -Encoding ASCII -FilePath "$CSVPath\Azure HUB Licensing.csv"

#Getting HUB Licensing Info
Write-Host "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Getting HUB Licensing Information for Windows Virtual Machines"

foreach ($VM in Get-AzureRmVm | Where-Object {$_.StorageProfile.OsDisk.OsType -eq "Windows"}) {
    Write-Host "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Processing VM -" $VM.Name

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
    Out-File -Encoding ASCII -FilePath "$CSVPath\Azure HUB Licensing.csv" -Append
}

Write-Host "[$(get-date -Format "dd/mm/yy hh:mm:ss")] HUB Licensing Information Obtained Successfully!"