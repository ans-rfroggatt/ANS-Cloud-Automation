#Parameter Declaration
Param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$username,
    [Parameter(Mandatory=$true, Position=0)]
    $password,
    [Parameter(Mandatory=$true, Position=0)]
    [string]$subid
)

Write-Output "ANS - Tag Associated VM Resources"
Write-Output "Version 1.0.0"
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


foreach ($VM in Get-AzureRmVM | Where-Object {$_.Tags -ne $null}) {
    
    #Get Current VM Tags
    Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Getting Tags for -" $VM.Name " <br />"
    $Tags = $VM.Tags
    Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Gathered Tags Successfully <br />"
    Write-Output ""


    #Get Associated Network Interfaces and Tag
    Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Tagging Network Interfaces for -" $VM.Name " <br />"
    $NetworkInterfaceIDs = $VM.NetworkProfile.NetworkInterfaces.Id

    foreach ($Int in $NetworkInterfaceIDs) {

        #Get Interface Name
        $IntName = $Int.Split("/")[8]
        Write-Output " <br />"
        Write-Output "Tagging Interface" $IntName " <br />"
        Set-AzureRmResource -ResourceId $Int -Tag $Tags -Force
    }
    Write-Output " <br />"
    Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Network Interfaces Tagged Successfully <br />"
    Write-Output "<p> </p>"


    #Get Associated Managed Disks and Tag
    Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Tagging Managed Disks for -" $VM.Name

    if ($VM.StorageProfile.OsDisk.ManagedDisk -ne $null) {
        $OSDisk = $VM.StorageProfile.OsDisk.Name
        $DataDisks = $VM.StorageProfile.DataDisks.Name
        $Disks = $OSDisk,$DataDisks

        foreach ($Disk in $Disks) {
            Write-Output " <br />"
            Write-Output "Tagging Managed Disk" $Disk " <br />"
            $Config = New-AzureRmDiskUpdateConfig -Tag $Tags
            $Disk = Get-AzureRmDisk -ResourceGroupName $VM.ResourceGroupName -DiskName $Disk 
            Update-AzureRmDisk -ResourceGroupName $VM.ResourceGroupName -DiskName $Disk.Name -DiskUpdate $Config
        }
        Write-Output " <br />"
        Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Managed Disks Tagged Successfully <br />"
        Write-Output "<p> </p>"
    }

    else {
    Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")]" $VM.Name "is using Unmanaged Disks <br />"
    Write-Output "<p> </p>"
    }


    #Get Associated Public IP Addresses and Tag
    Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Tagging Public IPs for -" $VM.Name " <br />"
    foreach ($Int in $NetworkInterfaceIDs) {
        
        #Get All IP Configuration for Interface
        $Int = Get-AzureRmResource -ResourceId $Int
        $IPConfigurations = $Int.Properties.ipConfigurations

        #Check IP Configurations for Public IPs

        If ($IPConfigurations.properties.publicIPAddress -eq $null) {
        Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] No Public IP Addresses to Tag <br />"
        }

        #If Public IPs exist then Tag
        else {
            foreach ($IP in $IPConfigurations | Where-Object {$_.properties.publicIPAddress -ne $null}) {
                
                #Get Public IP Name
                $PIPName = $IP.properties.publicIPAddress.id.Split("/")[8]
                Write-Output " <br />"
                Write-Output "Tagging Public IP" $PIPName " <br />"
                Set-AzureRmResource -ResourceId $IP.properties.publicIPAddress.id -Tag $Tags -Force
            }
        }
    Write-Output " <br />"
    Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Public IPs Tagged Successfully <br />"
    Write-Output "<p> </p>"
    }
    Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")]" $VM.Name "Tagged Successfully! <br />"
}
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Tagging Completed Successfully for all Virtual Machines <br />"
