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
Write-Output "ANS Unmodernised Instances <br />"
Write-Output "Version 3.0.0 <br />"
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


#Create Log Output File
$LogFile = "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Log Output from Instance Modernisation Checks... <br />"

#Set CSV Path and Import CSV
$CSVPath = "$PSScriptRoot\..\Azure-Script-Exports"
$CSV = Import-Csv "$PSScriptRoot\..\Azure-Scripts\Azure Instance Modernisation Table.csv"

#Create File Name
$file = $username.Split('@')
$file = $file[0] + $subid


#Set CSV Headers
"""VMName"",""ResourceGroup"",""VMSize"",""Location"",""OSType"",""NewSize""" | Out-File -Encoding ASCII -FilePath "$CSVPath\$file-ModCSV.csv"


#Create Hash Table of Key Pairs from CSV to determine correct moderinisation approach
$CSVTable=@{}

#Get Number of Columns in CSV
$CSVCount=(Get-Member -InputObject $CSV[0] -MemberType NoteProperty).count

#NOTE - Assumes Column Headers are named VersionX
foreach($TableEntry in $CSV) {
    #All but last column
    for($First=1;$First -lt $CSVCount;$First++)  {
        #Get version to upgrade from
        $FirstStr=$TableEntry.pSobject.Properties.item("Version"+$First.ToString()).Value
            
        if($FirstStr -ne "N/A") {
            #All remaining columns
            for($Second=$First+1;$Second -le $CSVCount;$Second++) {
                #Get version to upgrade to
                $SecondStr=$TableEntry.pSobject.Properties.item("Version"+$Second.ToString()).Value
        
                if($SecondStr -ne "N/A") {
                    #If from and to are valid write hash table entry
                    $CSVTable[$FirstStr]=$SecondStr
                }
            }
        }
    }
}


#Login to Azure Environment
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Logging in to Azure Account... <br />"
Login-AzureRmAccount -Credential $Credentials
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Successfully logged in to Azure Account <br />"
Write-Output "<p> </p>"


#Select SubscriptionId
#Set Subscription Id
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Selecting Azure Subscripion <br />"
Select-AzureRmSubscription -SubscriptionId $subId
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Subscription successfully selected <br />"
Write-Output "<p> </p>"

#Get All Azure VMs
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Gathering all Virtual Machines... <br />"
$AllVMs = Get-AzureRmVM
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] All Virtual Machines gathered successfully <br />"
Write-Output "<p> </p>"


#Process Each VM based on Hash Table Key Value Pairs
foreach ($VM in $AllVMs) {

    #If Hash Table contains the VM Size Output Recommendation
    if ($CSVTable[$VM.HardwareProfile.VmSize]) {
    
    """"+$VM.Name+""","""+$VM.ResourceGroupName+""","""+$VM.HardwareProfile.VmSize+""","""+$VM.Location+""","""+$VM.StorageProfile.OsDisk.OsType+""","""+$CSVTable[$VM.HardwareProfile.VmSize]+"""" | 
    Out-File -Encoding ASCII -FilePath "$CSVPath\$file-ModCSV.csv" -Append

    #Write output to Log File
    $LogFile += "`n" + "[$(get-date -Format "dd/mm/yy hh:mm:ss")] " + $VM.Name + "can be modernised to " + $CSVTable[$VM.HardwareProfile.VmSize]
    Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")]" $VM.Name " can be modernised to" $CSVTable[$VM.HardwareProfile.VmSize]"  <br />"
    } 
    
    else {
    #Write output to Log File
    $LogFile += "`n" + "[$(get-date -Format 'dd/mm/yy hh:mm:ss')] " + $VM.Name + " cannot be modernised <br />"
    Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")]" $VM.Name "cannot be modernised <br />" 
    }
}

#Export Log File
Out-File -InputObject $LogFile -FilePath "$CSVPath\$file-ModLog.txt"