#Parameter Declaration
Param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$EnrollmentID,
    [Parameter(Mandatory=$true, Position=0)]
    $APIKey
)

Write-Output ""
Write-Output "ANS - Export EA Price List <br />"
Write-Output "Version 1.0.0 <br />"
Write-Output "<p> </p>"

#Set CSV Path
$CSVPath = "$PSScriptRoot\..\Azure-Script-Exports"

#Invoke API Request
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Invoking API Request <br />"

$Headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$Headers.Add("Authorization", "Bearer $APIKey")

$JSON = Invoke-RestMethod -Uri https://consumption.azure.com/v2/enrollments/$EnrollmentID/pricesheet -Method Get -Headers $Headers -ErrorVariable APIError -ErrorAction SilentlyContinue

if ($JSON -ne $null) {
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] EA Price List Retreived successfully <br />"
}
else {
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] API Request Error - $APIError <br />"
}


#Convert API Response from JSON to CSV
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] Converting JSON response to CSV <br />"
$JSON | Export-CSV "$CSVPath\$EnrollmentID-PriceList.csv" -NoTypeInformation
Write-Output "[$(get-date -Format "dd/mm/yy hh:mm:ss")] JSON Response converted to CSV successfully <br />"