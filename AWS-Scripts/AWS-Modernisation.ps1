#Parameter Declaration
Param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$Customer,
    [Parameter(Mandatory=$true, Position=0)]
    [string]$AccessKey,
    [Parameter(Mandatory=$true, Position=0)]
    $SecretKey
)


Write-Output "ANS Unmodernised Instances <br />"
Write-Output "Version 2.0.0 <br />"
Write-Output "<p> </p>"


#Build Secure Credentials
$SecAccessKey = ConvertTo-SecureString -String $AccessKey -AsPlainText -Force
$SecSecretKey = ConvertTo-SecureString -String $SecretKey -AsPlainText -Force

#Import AWS PowerShell Module
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Importing module... <br />"
Import-Module -Name AWSPowerShell -ErrorVariable ModuleError -ErrorAction SilentlyContinue
if ($ModuleError) {
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Module Error - $ModuleError <br />"
Write-Output "<p> </p>"
}
else {
"<br />"
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Successfully Imported module <br />"
Write-Output "<p> </p>"
}


#Set CSV Path and Import CSV
$CSVPath = "$PSScriptRoot\..\AWS-Script-Exports"
$CSV = Import-Csv "$PSScriptRoot\..\AWS-Scripts\AWS Instance Modernisation Table.csv"


#Set Log Output Header
"[$(get-date -Format "dd/mm/yy hh:mm:ss")] Log Output from Instance Modernisation Checks..." | Out-File -FilePath "$CSVPath\$Customer-Modernisation Log.txt"

#Set CSV Headers
"""InstanceName"",""InstanceId"",""InstanceSize"",""Region"",""OSType"",""NewSize""" | Out-File -Encoding ASCII -FilePath "$CSVPath\$Customer-InstanceModernisationRecommendations.csv"


#Create Hash Table of Key Pairs from CSV to determine correct moderinisation approach
$CSVTable=@{}

#Get Number of Columns in CSV
$CSVCount=(get-member -InputObject $CSV[0] -MemberType NoteProperty).count

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


#Login to AWS
Write-Output "<p> </p>"
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Logging in to AWS Account... <br />"
Set-AWSCredentials -AccessKey $SecAccessKey -SecretKey $SecSecretKey -ErrorVariable LoginError -ErrorAction SilentlyContinue
if ($LoginError) {
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Login Error - $LoginError <br />"
Write-Output "<p> </p>"
}
else {
"<br />"
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Successfully logged in to AWS Account <br />"
Write-Output "<p> </p>"
}


#Get All EC2 Instances
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Gathering all EC2 Instances in account... <br />"
foreach ($reg in Get-AWSRegion) {
    Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")]" "Processing Region $reg <br />"
    #Process Each Instance based on Hash Table Key Value Pairs
    foreach ($Instance in (Get-EC2Instance -Region $reg).instances) {

        #If Hash Table contains the Instance Size Output Recommendation
        if ($CSVTable[$Instance.InstanceType.Value]) {
        
            #Set Instance Name and Region Variables
            $InstanceName = $Instance.Tags | Where-Object {$_.Key -eq "Name"} | select -ExpandProperty Value

            #Append Recommendation to CSV
            """"+$InstanceName+""","""+$Instance.InstanceId+""","""+$Instance.InstanceType.Value+""","""+$reg+""","""+$Instance.Platform.Value+""","""+$CSVTable[$Instance.InstanceType.Value]+"""" | 
            Out-File -Encoding ASCII -FilePath "$CSVPath\$Customer-InstanceModernisationRecommendations.csv" -Append

            #Write output to Log File
            #If Instance has name tag use name tag
            if ($InstanceName -eq $null) {
                "[$(get-date -Format "dd/mm/yy hh:mm:ss")] " + $Instance.InstanceId + "can be modernised to " + $CSVTable[$Instance.InstanceType.Value] |
                Out-File -FilePath "$CSVPath\$Customer-Modernisation Log.txt" -Append

                Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")]" $Instance.InstanceId " can be modernised to" $CSVTable[$Instance.InstanceType.Value] " <br />"
            }
            #If Instance does not have name tag use ID
            else {
                "[$(get-date -Format "dd/mm/yy hh:mm:ss")] " + $InstanceName + "can be modernised to " + $CSVTable[$Instance.InstanceType.Value] |
                Out-File -FilePath "$CSVPath\$Customer-Modernisation Log.txt" -Append

                Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")]" $InstanceName " can be modernised to" $CSVTable[$Instance.InstanceType.Value] " <br />"
            }
        } 

        #If HashTable does not contain the instance size
        else {
            #Write output to Log File
            $InstanceName = $Instance.Tags | Where-Object {$_.Key -eq "Name"} | select -ExpandProperty Value

            #If Instance has name tag use name tag
            if ($InstanceName -eq $null) {
                "[$(get-date -Format 'dd/mm/yy hh:mm:ss')] " + $Instance.InstanceId + " cannot be modernised" |
                Out-File -FilePath "$CSVPath\$Customer-Modernisation Log.txt" -Append

                Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")]" $Instance.InstanceId "cannot be modernised <br />" 

            }
            #If Instance does not have name tag use ID
            else {
                "[$(get-date -Format 'dd/mm/yy hh:mm:ss')] " + $InstanceName + " cannot be modernised" |
                Out-File -FilePath "$CSVPath\$Customer-Modernisation Log.txt" -Append

                Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")]" $InstanceName "cannot be modernised <br />" 

            }
        }
    }
}