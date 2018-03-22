#  
# Module manifest for module 'AzureRM.Automation'  
#  
# Generated by: Microsoft Corporation  
#  
# Generated on: 01/23/2018 05:09:50
#  

$PSDefaultParameterValues.Clear()
Set-StrictMode -Version Latest

$module = Get-Module AzureRM.Profile 
if ($module -ne $null -and $module.Version.ToString().CompareTo("4.2.0") -lt 0) 
{ 
    Write-Error "This module requires AzureRM.Profile version 4.2.0. An earlier version of AzureRM.Profile is imported in the current PowerShell session. Please open a new session before importing this module. This error could indicate that multiple incompatible versions of the Azure PowerShell cmdlets are installed on your system. Please see https://aka.ms/azps-version-error for troubleshooting information." -ErrorAction Stop 
} 
elseif ($module -eq $null) 
{ 
    Import-Module AzureRM.Profile -MinimumVersion 4.2.0 -Scope Global 
}
Import-Module (Join-Path -Path $PSScriptRoot -ChildPath Microsoft.Azure.Commands.ResourceManager.Automation.dll)


if (Test-Path -Path "$PSScriptRoot\StartupScripts")
{
    Get-ChildItem "$PSScriptRoot\StartupScripts" | ForEach-Object {
        . $_.FullName
    }
}

if ($PSVersionTable.PSVersion.Major -ge 5)
{
    $completerCommands = @(@{'Command' = 'Get-AzureRMAutomationHybridWorkerGroup'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Get-AzureRmAutomationJobOutputRecord'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Import-AzureRmAutomationDscNodeConfiguration'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Export-AzureRmAutomationDscConfiguration'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Export-AzureRmAutomationDscNodeReportContent'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Get-AzureRmAutomationCertificate'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Get-AzureRmAutomationConnection'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Get-AzureRmAutomationCredential'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Get-AzureRmAutomationDscCompilationJob'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Get-AzureRmAutomationDscCompilationJobOutput'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Get-AzureRmAutomationDscNodeConfiguration'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Get-AzureRmAutomationDscNodeReport'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Get-AzureRmAutomationJob'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Get-AzureRmAutomationJobOutput'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Get-AzureRmAutomationModule'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Get-AzureRmAutomationRunbook'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Export-AzureRmAutomationRunbook'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Get-AzureRmAutomationSchedule'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Get-AzureRmAutomationScheduledRunbook'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Get-AzureRmAutomationVariable'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Get-AzureRmAutomationWebhook'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'New-AzureRmAutomationCertificate'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'New-AzureRmAutomationConnection'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'New-AzureRmAutomationCredential'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'New-AzureRmAutomationModule'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'New-AzureRmAutomationRunbook'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'New-AzureRmAutomationSchedule'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'New-AzureRmAutomationVariable'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'New-AzureRmAutomationWebhook'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Publish-AzureRmAutomationRunbook'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Register-AzureRmAutomationDscNode'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Register-AzureRmAutomationScheduledRunbook'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Remove-AzureRmAutomationCertificate'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Remove-AzureRmAutomationConnectionType'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Remove-AzureRmAutomationConnection'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Remove-AzureRmAutomationCredential'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Remove-AzureRmAutomationDscNodeConfiguration'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Remove-AzureRmAutomationModule'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Remove-AzureRmAutomationRunbook'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Remove-AzureRmAutomationSchedule'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Remove-AzureRmAutomationVariable'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Remove-AzureRmAutomationDscConfiguration'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Remove-AzureRmAutomationWebhook'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Resume-AzureRmAutomationJob'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Set-AzureRmAutomationCertificate'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Set-AzureRmAutomationConnectionFieldValue'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Set-AzureRmAutomationCredential'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Set-AzureRmAutomationModule'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Set-AzureRmAutomationRunbook'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Import-AzureRmAutomationRunbook'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Set-AzureRmAutomationSchedule'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Set-AzureRmAutomationVariable'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Set-AzureRmAutomationWebhook'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Start-AzureRmAutomationDscCompilationJob'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Get-AzureRmAutomationRegistrationInfo'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Get-AzureRmAutomationDscConfiguration'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Get-AzureRmAutomationDscNode'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Get-AzureRmAutomationDscOnboardingMetaconfig'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Import-AzureRmAutomationDscConfiguration'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'New-AzureRmAutomationKey'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Start-AzureRmAutomationRunbook'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Stop-AzureRmAutomationJob'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Start-AzureRmAutomationDscNodeConfigurationDeployment'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Get-AzureRmAutomationDscNodeConfigurationDeployment'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Get-AzureRmAutomationDscNodeConfigurationDeploymentSchedule'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Stop-AzureRmAutomationDscNodeConfigurationDeployment'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Suspend-AzureRmAutomationJob'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Unregister-AzureRmAutomationDscNode'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Set-AzureRmAutomationAccount'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Remove-AzureRmAutomationAccount'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'New-AzureRmAutomationAccount'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'New-AzureRmAutomationAccount'; 'Parameter' = 'Location'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.LocationCompleterAttribute'; 'ArgumentList' = @('Microsoft.Automation/automationAccounts')},@{'Command' = 'Get-AzureRmAutomationAccount'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Set-AzureRmAutomationDscNode'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()},@{'Command' = 'Unregister-AzureRmAutomationScheduledRunbook'; 'Parameter' = 'ResourceGroupName'; 'AttributeType' = 'Microsoft.Azure.Commands.ResourceManager.Common.ArgumentCompleters.ResourceGroupCompleterAttribute'; 'ArgumentList' = @()})
    
    $completerCommands | ForEach-Object {
        $type = $_.AttributeType
        $args = "@()"
        if ($_.ArgumentList.Count -ne 0) {
		    $temp = $_.ArgumentList -join "`", `"" 
            $args = "@(`"" + $temp + "`")" 
        }
        $sb = [scriptblock]::Create("param(`$commandName, `$parameterName, `$wordToComplete, `$commandAst, `$fakeBoundParameter) `
        `$completerObject = New-Object $type -ArgumentList $args `
        `$arguments = `$completerObject.GetCompleterValues() `
        `$wordToCompleteTrimQuote = `$wordToComplete.Trim(`"'`")
        `$wordToCompleteTrimmed = `$wordToCompleteTrimQuote.Trim(`"```"`")
        `$arguments | Where-Object { (`$_ -Like `"`$wordToComplete*`")  -or (`$_ -Like `"```'`$wordToCompleteTrimmed*```'`") } | ForEach-Object { [System.Management.Automation.CompletionResult]::new(`$_, `$_, 'ParameterValue', `$_) }")
        Register-ArgumentCompleter -CommandName $_.Command -ParameterName $_.Parameter -ScriptBlock $sb
    }
}

$FilteredCommands = @('Get-AzureRMAutomationHybridWorkerGroup:ResourceGroupName','Get-AzureRmAutomationJobOutputRecord:ResourceGroupName','Import-AzureRmAutomationDscNodeConfiguration:ResourceGroupName','Export-AzureRmAutomationDscConfiguration:ResourceGroupName','Export-AzureRmAutomationDscNodeReportContent:ResourceGroupName','Get-AzureRmAutomationCertificate:ResourceGroupName','Get-AzureRmAutomationConnection:ResourceGroupName','Get-AzureRmAutomationCredential:ResourceGroupName','Get-AzureRmAutomationDscCompilationJob:ResourceGroupName','Get-AzureRmAutomationDscCompilationJobOutput:ResourceGroupName','Get-AzureRmAutomationDscNodeConfiguration:ResourceGroupName','Get-AzureRmAutomationDscNodeReport:ResourceGroupName','Get-AzureRmAutomationJob:ResourceGroupName','Get-AzureRmAutomationJobOutput:ResourceGroupName','Get-AzureRmAutomationModule:ResourceGroupName','Get-AzureRmAutomationRunbook:ResourceGroupName','Export-AzureRmAutomationRunbook:ResourceGroupName','Get-AzureRmAutomationSchedule:ResourceGroupName','Get-AzureRmAutomationScheduledRunbook:ResourceGroupName','Get-AzureRmAutomationVariable:ResourceGroupName','Get-AzureRmAutomationWebhook:ResourceGroupName','New-AzureRmAutomationCertificate:ResourceGroupName','New-AzureRmAutomationConnection:ResourceGroupName','New-AzureRmAutomationCredential:ResourceGroupName','New-AzureRmAutomationModule:ResourceGroupName','New-AzureRmAutomationRunbook:ResourceGroupName','New-AzureRmAutomationSchedule:ResourceGroupName','New-AzureRmAutomationVariable:ResourceGroupName','New-AzureRmAutomationWebhook:ResourceGroupName','Publish-AzureRmAutomationRunbook:ResourceGroupName','Register-AzureRmAutomationDscNode:ResourceGroupName','Register-AzureRmAutomationScheduledRunbook:ResourceGroupName','Remove-AzureRmAutomationCertificate:ResourceGroupName','Remove-AzureRmAutomationConnectionType:ResourceGroupName','Remove-AzureRmAutomationConnection:ResourceGroupName','Remove-AzureRmAutomationCredential:ResourceGroupName','Remove-AzureRmAutomationDscNodeConfiguration:ResourceGroupName','Remove-AzureRmAutomationModule:ResourceGroupName','Remove-AzureRmAutomationRunbook:ResourceGroupName','Remove-AzureRmAutomationSchedule:ResourceGroupName','Remove-AzureRmAutomationVariable:ResourceGroupName','Remove-AzureRmAutomationDscConfiguration:ResourceGroupName','Remove-AzureRmAutomationWebhook:ResourceGroupName','Resume-AzureRmAutomationJob:ResourceGroupName','Set-AzureRmAutomationCertificate:ResourceGroupName','Set-AzureRmAutomationConnectionFieldValue:ResourceGroupName','Set-AzureRmAutomationCredential:ResourceGroupName','Set-AzureRmAutomationModule:ResourceGroupName','Set-AzureRmAutomationRunbook:ResourceGroupName','Import-AzureRmAutomationRunbook:ResourceGroupName','Set-AzureRmAutomationSchedule:ResourceGroupName','Set-AzureRmAutomationVariable:ResourceGroupName','Set-AzureRmAutomationWebhook:ResourceGroupName','Start-AzureRmAutomationDscCompilationJob:ResourceGroupName','Get-AzureRmAutomationRegistrationInfo:ResourceGroupName','Get-AzureRmAutomationDscConfiguration:ResourceGroupName','Get-AzureRmAutomationDscNode:ResourceGroupName','Get-AzureRmAutomationDscOnboardingMetaconfig:ResourceGroupName','Import-AzureRmAutomationDscConfiguration:ResourceGroupName','New-AzureRmAutomationKey:ResourceGroupName','Start-AzureRmAutomationRunbook:ResourceGroupName','Stop-AzureRmAutomationJob:ResourceGroupName','Start-AzureRmAutomationDscNodeConfigurationDeployment:ResourceGroupName','Get-AzureRmAutomationDscNodeConfigurationDeployment:ResourceGroupName','Get-AzureRmAutomationDscNodeConfigurationDeploymentSchedule:ResourceGroupName','Stop-AzureRmAutomationDscNodeConfigurationDeployment:ResourceGroupName','Suspend-AzureRmAutomationJob:ResourceGroupName','Unregister-AzureRmAutomationDscNode:ResourceGroupName','Set-AzureRmAutomationAccount:ResourceGroupName','Remove-AzureRmAutomationAccount:ResourceGroupName','New-AzureRmAutomationAccount:ResourceGroupName','Set-AzureRmAutomationDscNode:ResourceGroupName','Unregister-AzureRmAutomationScheduledRunbook:ResourceGroupName')

$FilteredCommands | ForEach-Object {
	$global:PSDefaultParameterValues.Add($_,
		{
			$context = Get-AzureRmContext
			if (($context -ne $null) -and $context.ExtendedProperties.ContainsKey("Default Resource Group")) {
				$context.ExtendedProperties["Default Resource Group"]
			} 
		})
}

# SIG # Begin signature block
# MIIkBgYJKoZIhvcNAQcCoIIj9zCCI/MCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCBVEV23EGbNfxEF
# MPsSeZYGJdD/7e8EXsqqpLuNFtmfJaCCDYMwggYBMIID6aADAgECAhMzAAAAxOmJ
# +HqBUOn/AAAAAADEMA0GCSqGSIb3DQEBCwUAMH4xCzAJBgNVBAYTAlVTMRMwEQYD
# VQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNpZ25p
# bmcgUENBIDIwMTEwHhcNMTcwODExMjAyMDI0WhcNMTgwODExMjAyMDI0WjB0MQsw
# CQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9u
# ZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMR4wHAYDVQQDExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
# AQCIirgkwwePmoB5FfwmYPxyiCz69KOXiJZGt6PLX4kvOjMuHpF4+nypH4IBtXrL
# GrwDykbrxZn3+wQd8oUK/yJuofJnPcUnGOUoH/UElEFj7OO6FYztE5o13jhwVG87
# 7K1FCTBJwb6PMJkMy3bJ93OVFnfRi7uUxwiFIO0eqDXxccLgdABLitLckevWeP6N
# +q1giD29uR+uYpe/xYSxkK7WryvTVPs12s1xkuYe/+xxa8t/CHZ04BBRSNTxAMhI
# TKMHNeVZDf18nMjmWuOF9daaDx+OpuSEF8HWyp8dAcf9SKcTkjOXIUgy+MIkogCy
# vlPKg24pW4HvOG6A87vsEwvrAgMBAAGjggGAMIIBfDAfBgNVHSUEGDAWBgorBgEE
# AYI3TAgBBggrBgEFBQcDAzAdBgNVHQ4EFgQUy9ZihM9gOer/Z8Jc0si7q7fDE5gw
# UgYDVR0RBEswSaRHMEUxDTALBgNVBAsTBE1PUFIxNDAyBgNVBAUTKzIzMDAxMitj
# ODA0YjVlYS00OWI0LTQyMzgtODM2Mi1kODUxZmEyMjU0ZmMwHwYDVR0jBBgwFoAU
# SG5k5VAF04KqFzc3IrVtqMp1ApUwVAYDVR0fBE0wSzBJoEegRYZDaHR0cDovL3d3
# dy5taWNyb3NvZnQuY29tL3BraW9wcy9jcmwvTWljQ29kU2lnUENBMjAxMV8yMDEx
# LTA3LTA4LmNybDBhBggrBgEFBQcBAQRVMFMwUQYIKwYBBQUHMAKGRWh0dHA6Ly93
# d3cubWljcm9zb2Z0LmNvbS9wa2lvcHMvY2VydHMvTWljQ29kU2lnUENBMjAxMV8y
# MDExLTA3LTA4LmNydDAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEBCwUAA4ICAQAG
# Fh/bV8JQyCNPolF41+34/c291cDx+RtW7VPIaUcF1cTL7OL8mVuVXxE4KMAFRRPg
# mnmIvGar27vrAlUjtz0jeEFtrvjxAFqUmYoczAmV0JocRDCppRbHukdb9Ss0i5+P
# WDfDThyvIsoQzdiCEKk18K4iyI8kpoGL3ycc5GYdiT4u/1cDTcFug6Ay67SzL1BW
# XQaxFYzIHWO3cwzj1nomDyqWRacygz6WPldJdyOJ/rEQx4rlCBVRxStaMVs5apao
# pIhrlihv8cSu6r1FF8xiToG1VBpHjpilbcBuJ8b4Jx/I7SCpC7HxzgualOJqnWmD
# oTbXbSD+hdX/w7iXNgn+PRTBmBSpwIbM74LBq1UkQxi1SIV4htD50p0/GdkUieeN
# n2gkiGg7qceATibnCCFMY/2ckxVNM7VWYE/XSrk4jv8u3bFfpENryXjPsbtrj4Ns
# h3Kq6qX7n90a1jn8ZMltPgjlfIOxrbyjunvPllakeljLEkdi0iHv/DzEMQv3Lz5k
# pTdvYFA/t0SQT6ALi75+WPbHZ4dh256YxMiMy29H4cAulO2x9rAwbexqSajplnbI
# vQjE/jv1rnM3BrJWzxnUu/WUyocc8oBqAU+2G4Fzs9NbIj86WBjfiO5nxEmnL9wl
# iz1e0Ow0RJEdvJEMdoI+78TYLaEEAo5I+e/dAs8DojCCB3owggVioAMCAQICCmEO
# kNIAAAAAAAMwDQYJKoZIhvcNAQELBQAwgYgxCzAJBgNVBAYTAlVTMRMwEQYDVQQI
# EwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3Nv
# ZnQgQ29ycG9yYXRpb24xMjAwBgNVBAMTKU1pY3Jvc29mdCBSb290IENlcnRpZmlj
# YXRlIEF1dGhvcml0eSAyMDExMB4XDTExMDcwODIwNTkwOVoXDTI2MDcwODIxMDkw
# OVowfjELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcT
# B1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEoMCYGA1UE
# AxMfTWljcm9zb2Z0IENvZGUgU2lnbmluZyBQQ0EgMjAxMTCCAiIwDQYJKoZIhvcN
# AQEBBQADggIPADCCAgoCggIBAKvw+nIQHC6t2G6qghBNNLrytlghn0IbKmvpWlCq
# uAY4GgRJun/DDB7dN2vGEtgL8DjCmQawyDnVARQxQtOJDXlkh36UYCRsr55JnOlo
# XtLfm1OyCizDr9mpK656Ca/XllnKYBoF6WZ26DJSJhIv56sIUM+zRLdd2MQuA3Wr
# aPPLbfM6XKEW9Ea64DhkrG5kNXimoGMPLdNAk/jj3gcN1Vx5pUkp5w2+oBN3vpQ9
# 7/vjK1oQH01WKKJ6cuASOrdJXtjt7UORg9l7snuGG9k+sYxd6IlPhBryoS9Z5JA7
# La4zWMW3Pv4y07MDPbGyr5I4ftKdgCz1TlaRITUlwzluZH9TupwPrRkjhMv0ugOG
# jfdf8NBSv4yUh7zAIXQlXxgotswnKDglmDlKNs98sZKuHCOnqWbsYR9q4ShJnV+I
# 4iVd0yFLPlLEtVc/JAPw0XpbL9Uj43BdD1FGd7P4AOG8rAKCX9vAFbO9G9RVS+c5
# oQ/pI0m8GLhEfEXkwcNyeuBy5yTfv0aZxe/CHFfbg43sTUkwp6uO3+xbn6/83bBm
# 4sGXgXvt1u1L50kppxMopqd9Z4DmimJ4X7IvhNdXnFy/dygo8e1twyiPLI9AN0/B
# 4YVEicQJTMXUpUMvdJX3bvh4IFgsE11glZo+TzOE2rCIF96eTvSWsLxGoGyY0uDW
# iIwLAgMBAAGjggHtMIIB6TAQBgkrBgEEAYI3FQEEAwIBADAdBgNVHQ4EFgQUSG5k
# 5VAF04KqFzc3IrVtqMp1ApUwGQYJKwYBBAGCNxQCBAweCgBTAHUAYgBDAEEwCwYD
# VR0PBAQDAgGGMA8GA1UdEwEB/wQFMAMBAf8wHwYDVR0jBBgwFoAUci06AjGQQ7kU
# BU7h6qfHMdEjiTQwWgYDVR0fBFMwUTBPoE2gS4ZJaHR0cDovL2NybC5taWNyb3Nv
# ZnQuY29tL3BraS9jcmwvcHJvZHVjdHMvTWljUm9vQ2VyQXV0MjAxMV8yMDExXzAz
# XzIyLmNybDBeBggrBgEFBQcBAQRSMFAwTgYIKwYBBQUHMAKGQmh0dHA6Ly93d3cu
# bWljcm9zb2Z0LmNvbS9wa2kvY2VydHMvTWljUm9vQ2VyQXV0MjAxMV8yMDExXzAz
# XzIyLmNydDCBnwYDVR0gBIGXMIGUMIGRBgkrBgEEAYI3LgMwgYMwPwYIKwYBBQUH
# AgEWM2h0dHA6Ly93d3cubWljcm9zb2Z0LmNvbS9wa2lvcHMvZG9jcy9wcmltYXJ5
# Y3BzLmh0bTBABggrBgEFBQcCAjA0HjIgHQBMAGUAZwBhAGwAXwBwAG8AbABpAGMA
# eQBfAHMAdABhAHQAZQBtAGUAbgB0AC4gHTANBgkqhkiG9w0BAQsFAAOCAgEAZ/KG
# pZjgVHkaLtPYdGcimwuWEeFjkplCln3SeQyQwWVfLiw++MNy0W2D/r4/6ArKO79H
# qaPzadtjvyI1pZddZYSQfYtGUFXYDJJ80hpLHPM8QotS0LD9a+M+By4pm+Y9G6XU
# tR13lDni6WTJRD14eiPzE32mkHSDjfTLJgJGKsKKELukqQUMm+1o+mgulaAqPypr
# WEljHwlpblqYluSD9MCP80Yr3vw70L01724lruWvJ+3Q3fMOr5kol5hNDj0L8giJ
# 1h/DMhji8MUtzluetEk5CsYKwsatruWy2dsViFFFWDgycScaf7H0J/jeLDogaZiy
# WYlobm+nt3TDQAUGpgEqKD6CPxNNZgvAs0314Y9/HG8VfUWnduVAKmWjw11SYobD
# HWM2l4bf2vP48hahmifhzaWX0O5dY0HjWwechz4GdwbRBrF1HxS+YWG18NzGGwS+
# 30HHDiju3mUv7Jf2oVyW2ADWoUa9WfOXpQlLSBCZgB/QACnFsZulP0V3HjXG0qKi
# n3p6IvpIlR+r+0cjgPWe+L9rt0uX4ut1eBrs6jeZeRhL/9azI2h15q/6/IvrC4Dq
# aTuv/DDtBEyO3991bWORPdGdVk5Pv4BXIqF4ETIheu9BCrE/+6jMpF3BoYibV3FW
# TkhFwELJm3ZbCoBIa/15n8G9bW1qyVJzEw16UM0xghXZMIIV1QIBATCBlTB+MQsw
# CQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9u
# ZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSgwJgYDVQQDEx9NaWNy
# b3NvZnQgQ29kZSBTaWduaW5nIFBDQSAyMDExAhMzAAAAxOmJ+HqBUOn/AAAAAADE
# MA0GCWCGSAFlAwQCAQUAoIHMMBkGCSqGSIb3DQEJAzEMBgorBgEEAYI3AgEEMBwG
# CisGAQQBgjcCAQsxDjAMBgorBgEEAYI3AgEVMC8GCSqGSIb3DQEJBDEiBCA9RN/u
# BIv2Ce9pHObzzH3szvlQ85bRKhzwC0rez+lfSzBgBgorBgEEAYI3AgEMMVIwUKA2
# gDQATQBpAGMAcgBvAHMAbwBmAHQAIABBAHoAdQByAGUAIABQAG8AdwBlAHIAUwBo
# AGUAbABsoRaAFGh0dHA6Ly9Db2RlU2lnbkluZm8gMA0GCSqGSIb3DQEBAQUABIIB
# ABvET8fOeo0XXDuXOl2zeQi1RDt2PtKNaIioLsNt7+oX4dIlA/ssvtLomiOLjDoO
# MGFzFBoF148EoLDSG/RyaqB0yWG0v3zKFn9alFLm3/u57WEJOcj7+H/3eO7RNpNG
# pFoJ99y4bTdzqtwHBfSK6pZGRXj+lD740hQWHJEzFGj/kcjjRd4zSw8anMyoJMaD
# ncekBa/yMR4CDOLL0VI+9TzLCVa/3gNOnX6l4GkAtGIazxOPgrNFnn0dVNMaE5pQ
# mBYobw/LI7PeKYxD92+EvhGN7cjBiu6FYG1jEiZ0j6uI32XEZ3ZhdUll3dbmLTla
# monzvnUldWIA5d6GlPSr1t6hghNFMIITQQYKKwYBBAGCNwMDATGCEzEwghMtBgkq
# hkiG9w0BBwKgghMeMIITGgIBAzEPMA0GCWCGSAFlAwQCAQUAMIIBOwYLKoZIhvcN
# AQkQAQSgggEqBIIBJjCCASICAQEGCisGAQQBhFkKAwEwMTANBglghkgBZQMEAgEF
# AAQgyMBMdMovtFtQZh1fFX+ztxrZNXnYjLcX5sOcB73JWJ8CBlpOwSG+/RgSMjAx
# ODAxMjMwNTExMjQuMDFaMAcCAQGAAgPnoIG4pIG1MIGyMQswCQYDVQQGEwJVUzET
# MBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMV
# TWljcm9zb2Z0IENvcnBvcmF0aW9uMQwwCgYDVQQLEwNBT0MxJzAlBgNVBAsTHm5D
# aXBoZXIgRFNFIEVTTjo4NDNELTM3RjYtRjEwNDElMCMGA1UEAxMcTWljcm9zb2Z0
# IFRpbWUtU3RhbXAgU2VydmljZaCCDsowggZxMIIEWaADAgECAgphCYEqAAAAAAAC
# MA0GCSqGSIb3DQEBCwUAMIGIMQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGlu
# Z3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBv
# cmF0aW9uMTIwMAYDVQQDEylNaWNyb3NvZnQgUm9vdCBDZXJ0aWZpY2F0ZSBBdXRo
# b3JpdHkgMjAxMDAeFw0xMDA3MDEyMTM2NTVaFw0yNTA3MDEyMTQ2NTVaMHwxCzAJ
# BgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25k
# MR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xJjAkBgNVBAMTHU1pY3Jv
# c29mdCBUaW1lLVN0YW1wIFBDQSAyMDEwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8A
# MIIBCgKCAQEAqR0NvHcRijog7PwTl/X6f2mUa3RUENWlCgCChfvtfGhLLF/Fw+Vh
# wna3PmYrW/AVUycEMR9BGxqVHc4JE458YTBZsTBED/FgiIRUQwzXTbg4CLNC3ZOs
# 1nMwVyaCo0UN0Or1R4HNvyRgMlhgRvJYR4YyhB50YWeRX4FUsc+TTJLBxKZd0WET
# bijGGvmGgLvfYfxGwScdJGcSchohiq9LZIlQYrFd/XcfPfBXday9ikJNQFHRD5wG
# Pmd/9WbAA5ZEfu/QS/1u5ZrKsajyeioKMfDaTgaRtogINeh4HLDpmc085y9Euqf0
# 3GS9pAHBIAmTeM38vMDJRF1eFpwBBU8iTQIDAQABo4IB5jCCAeIwEAYJKwYBBAGC
# NxUBBAMCAQAwHQYDVR0OBBYEFNVjOlyKMZDzQ3t8RhvFM2hahW1VMBkGCSsGAQQB
# gjcUAgQMHgoAUwB1AGIAQwBBMAsGA1UdDwQEAwIBhjAPBgNVHRMBAf8EBTADAQH/
# MB8GA1UdIwQYMBaAFNX2VsuP6KJcYmjRPZSQW9fOmhjEMFYGA1UdHwRPME0wS6BJ
# oEeGRWh0dHA6Ly9jcmwubWljcm9zb2Z0LmNvbS9wa2kvY3JsL3Byb2R1Y3RzL01p
# Y1Jvb0NlckF1dF8yMDEwLTA2LTIzLmNybDBaBggrBgEFBQcBAQROMEwwSgYIKwYB
# BQUHMAKGPmh0dHA6Ly93d3cubWljcm9zb2Z0LmNvbS9wa2kvY2VydHMvTWljUm9v
# Q2VyQXV0XzIwMTAtMDYtMjMuY3J0MIGgBgNVHSABAf8EgZUwgZIwgY8GCSsGAQQB
# gjcuAzCBgTA9BggrBgEFBQcCARYxaHR0cDovL3d3dy5taWNyb3NvZnQuY29tL1BL
# SS9kb2NzL0NQUy9kZWZhdWx0Lmh0bTBABggrBgEFBQcCAjA0HjIgHQBMAGUAZwBh
# AGwAXwBQAG8AbABpAGMAeQBfAFMAdABhAHQAZQBtAGUAbgB0AC4gHTANBgkqhkiG
# 9w0BAQsFAAOCAgEAB+aIUQ3ixuCYP4FxAz2do6Ehb7Prpsz1Mb7PBeKp/vpXbRkw
# s8LFZslq3/Xn8Hi9x6ieJeP5vO1rVFcIK1GCRBL7uVOMzPRgEop2zEBAQZvcXBf/
# XPleFzWYJFZLdO9CEMivv3/Gf/I3fVo/HPKZeUqRUgCvOA8X9S95gWXZqbVr5MfO
# 9sp6AG9LMEQkIjzP7QOllo9ZKby2/QThcJ8ySif9Va8v/rbljjO7Yl+a21dA6fHO
# mWaQjP9qYn/dxUoLkSbiOewZSnFjnXshbcOco6I8+n99lmqQeKZt0uGc+R38ONiU
# 9MalCpaGpL2eGq4EQoO4tYCbIjggtSXlZOz39L9+Y1klD3ouOVd2onGqBooPiRa6
# YacRy5rYDkeagMXQzafQ732D8OE7cQnfXXSYIghh2rBQHm+98eEA3+cxB6STOvdl
# R3jo+KhIq/fecn5ha293qYHLpwmsObvsxsvYgrRyzR30uIUBHoD7G4kqVDmyW9rI
# DVWZeodzOwjmmC3qjeAzLhIp9cAvVCch98isTtoouLGp25ayp0Kiyc8ZQU3ghvkq
# mqMRZjDTu3QyS99je/WZii8bxyGvWbWu3EQ8l1Bx16HSxVXjad5XwdHeMMD9zOZN
# +w2/XU/pnR4ZOC+8z1gFLu8NoFA12u8JJxzVs341Hgi62jbb01+P3nSISRIwggTZ
# MIIDwaADAgECAhMzAAAAqVRw2XnAhGXiAAAAAACpMA0GCSqGSIb3DQEBCwUAMHwx
# CzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRt
# b25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xJjAkBgNVBAMTHU1p
# Y3Jvc29mdCBUaW1lLVN0YW1wIFBDQSAyMDEwMB4XDTE2MDkwNzE3NTY1M1oXDTE4
# MDkwNzE3NTY1M1owgbIxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9u
# MRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRp
# b24xDDAKBgNVBAsTA0FPQzEnMCUGA1UECxMebkNpcGhlciBEU0UgRVNOOjg0M0Qt
# MzdGNi1GMTA0MSUwIwYDVQQDExxNaWNyb3NvZnQgVGltZS1TdGFtcCBTZXJ2aWNl
# MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEArJSFGKblVtOd3wNnLtuY
# kUePlYlyTZp08zRA3msRp9THkn4O/581On+nZIxxm2HFGVk+lF2RL07A7cFAbicH
# kdTlrPYePM5QEVMnaITS0makH24deymLJuMJrnTnTPyfg7dGDdsVqQ37V/ezmxDe
# DBykTRrDliRGNimQXN4dR9aXP0KNB/+oLyeO6xIQsUdC9wS9OTbExbvA7La8joGc
# yd2yQDw9o+sbvTB1/lsFcx0UMRHU8Dq/7NET3kTJxP5I4VfELngIFX7zRQY2Sba1
# /VgdEd2IZANCEDnvrlMWRhFbXH0SWndIdnApYSEak1OcImlunLR5eo5MOIQVGWxf
# oQIDAQABo4IBGzCCARcwHQYDVR0OBBYEFA/VQfu78530vklS2ow3V85kD/N9MB8G
# A1UdIwQYMBaAFNVjOlyKMZDzQ3t8RhvFM2hahW1VMFYGA1UdHwRPME0wS6BJoEeG
# RWh0dHA6Ly9jcmwubWljcm9zb2Z0LmNvbS9wa2kvY3JsL3Byb2R1Y3RzL01pY1Rp
# bVN0YVBDQV8yMDEwLTA3LTAxLmNybDBaBggrBgEFBQcBAQROMEwwSgYIKwYBBQUH
# MAKGPmh0dHA6Ly93d3cubWljcm9zb2Z0LmNvbS9wa2kvY2VydHMvTWljVGltU3Rh
# UENBXzIwMTAtMDctMDEuY3J0MAwGA1UdEwEB/wQCMAAwEwYDVR0lBAwwCgYIKwYB
# BQUHAwgwDQYJKoZIhvcNAQELBQADggEBAAiZGKUHiy9yJHUsjiCEAv0Koa8O4bAy
# EYaqxYYgnbvoRDuVzLU654tGpRPTjCAbqDpXHBX3c22NC7IHRW6GRXYkRrp0TPE2
# b1KdtuTklIzJKauJqr5ygtO6m1WroII54Bku2BGtRYkDS8Av4gCeuHuH28rXdbgu
# BLSMkzeKHiZE5NlBZY7RQrleExC8GWd1u86EqekfjnvPG5S4OV1tV1nsCn7G1pUN
# O+f6iC9WrFUEUHJnP7IAA8OOwvw+yJWr4NRntqY0bbRgCLJCid5/YNpYIbzTjDgy
# U/IKzNvfJLcA65NKPwl6NDtLwHNralKEU6GbBERZYUKtcvBAwG78mrKhggN0MIIC
# XAIBATCB4qGBuKSBtTCBsjELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0
# b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3Jh
# dGlvbjEMMAoGA1UECxMDQU9DMScwJQYDVQQLEx5uQ2lwaGVyIERTRSBFU046ODQz
# RC0zN0Y2LUYxMDQxJTAjBgNVBAMTHE1pY3Jvc29mdCBUaW1lLVN0YW1wIFNlcnZp
# Y2WiJQoBATAJBgUrDgMCGgUAAxUAXTq/Vr3hDynKcg5k93U7eBoi6/SggcEwgb6k
# gbswgbgxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQH
# EwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xDDAKBgNV
# BAsTA0FPQzEnMCUGA1UECxMebkNpcGhlciBOVFMgRVNOOjI2NjUtNEMzRi1DNURF
# MSswKQYDVQQDEyJNaWNyb3NvZnQgVGltZSBTb3VyY2UgTWFzdGVyIENsb2NrMA0G
# CSqGSIb3DQEBBQUAAgUA3hDUrDAiGA8yMDE4MDEyMjIxMjI1MloYDzIwMTgwMTIz
# MjEyMjUyWjB0MDoGCisGAQQBhFkKBAExLDAqMAoCBQDeENSsAgEAMAcCAQACAiE7
# MAcCAQACAhqwMAoCBQDeEiYsAgEAMDYGCisGAQQBhFkKBAIxKDAmMAwGCisGAQQB
# hFkKAwGgCjAIAgEAAgMegJihCjAIAgEAAgMehIAwDQYJKoZIhvcNAQEFBQADggEB
# AI2T7beB5XSAT98WncswAzfCHLoAXlP/lTY9MNjc7m0VWTeyrhIv5p/ijk8FBCMK
# VDa0egEg8ZzdGKR4U254F8C0nedmn18Jt8YokEN0JlZieF7WlnQOQLAOVTd+qMrt
# GwCnrbDx1JuNUpqk/SFdVQqzps5aGkUPHX2KOl075+jfbEfZ9eU4JYR9GL8KiLqe
# U3Lm4o7eb+1MPUrNyJ118+nrfJj/PKUbxI5d+AYF1bX5CjYG/rwk6YQEMH/RhBcM
# wHZfaiNpLgwgeNbi2ShstdanEPjqhDZzWh7atONaN+FZJWqS6Vg+0KN+5xy46JgY
# 4VCVNmdHSEXNGsyIPRylUncxggL1MIIC8QIBATCBkzB8MQswCQYDVQQGEwJVUzET
# MBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMV
# TWljcm9zb2Z0IENvcnBvcmF0aW9uMSYwJAYDVQQDEx1NaWNyb3NvZnQgVGltZS1T
# dGFtcCBQQ0EgMjAxMAITMwAAAKlUcNl5wIRl4gAAAAAAqTANBglghkgBZQMEAgEF
# AKCCATIwGgYJKoZIhvcNAQkDMQ0GCyqGSIb3DQEJEAEEMC8GCSqGSIb3DQEJBDEi
# BCCI6tdUdydHrMxLmd9+VScBrPlxMfV4sX16GRiGqUJE0jCB4gYLKoZIhvcNAQkQ
# AgwxgdIwgc8wgcwwgbEEFF06v1a94Q8pynIOZPd1O3gaIuv0MIGYMIGApH4wfDEL
# MAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1v
# bmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEmMCQGA1UEAxMdTWlj
# cm9zb2Z0IFRpbWUtU3RhbXAgUENBIDIwMTACEzMAAACpVHDZecCEZeIAAAAAAKkw
# FgQUGlzWfgTYUemxOv73/60E6xTNYWEwDQYJKoZIhvcNAQELBQAEggEANH2Kn/ik
# Aa0Jny0Z8y/7QhK8hIEdxm8/OW7+lfVWJmXAcTZVlfFQ9ky7Y5uW8gu6YMeIlgnJ
# oT1jMX2q/+bfWycrMIs19JMAHyTyqX0T/Xd6zhoQXdtn/ZY/3wB7SLK3ad2CA2q7
# mso9847q50WfXB0J1eIVsNqcbp/Muihh/wixyf6nH1rNTEp1kOx9mD5stO1LMlnx
# Y97A/oCrWguwZzLQ1cdgsKJE2stQnbcxfY87xH51ZpI1CT8qFZOpwIQQlqAca/JW
# Bvrz5vgKppMY0czAUCNkbzJbG80GBOkQAcdfvsbPO2P4qf+m5WF7bGibHpeK8uC2
# CIPqmLhXHo5moQ==
# SIG # End signature block
