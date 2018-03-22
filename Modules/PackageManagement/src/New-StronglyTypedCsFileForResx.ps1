﻿param(
    [ValidateSet("Microsoft.PackageManagement",
        "Microsoft.PackageManagement.ArchiverProviders",
        "Microsoft.PackageManagement.CoreProviders",
        "Microsoft.PackageManagement.MetaProvider.PowerShell",
        "Microsoft.PackageManagement.MsiProvider",
        "Microsoft.PackageManagement.MsuProvider",
        "Microsoft.PowerShell.PackageManagement",
        "Microsoft.PackageManagement.NuGetProvider"
        )]
    [string] $project
)

$nameSpaceDict = @{
    "Microsoft.PackageManagement" = "Microsoft.PackageManagement.Internal";
    "Microsoft.PackageManagement.CoreProviders" = "Microsoft.PackageManagement.Providers";
    "Microsoft.PackageManagement.MetaProvider.PowerShell" = "Microsoft.PackageManagement.MetaProvider.PowerShell.Internal";
    "Microsoft.PackageManagement.MsiProvider" = "Microsoft.PackageManagement.Msi.Internal";
    "Microsoft.PackageManagement.MsuProvider" = "Microsoft.PackageManagement.Msu.Internal";
    "Microsoft.PowerShell.PackageManagement" = "Microsoft.PowerShell.PackageManagement";
    "Microsoft.PackageManagement.NuGetProvider" = "Microsoft.PackageManagement.NuGetProvider"
}

function Get-StronglyTypeCsFileForResx
{
    param($xml, $ClassName, $moduleName)

    # Example
    #
    # $ClassName = Full.Name.Of.The.ClassFoo
    # $shortClassName = ClassFoo
    # $namespaceName = Full.Name.Of.The

    $shortClassName = $ClassName
    $namespaceName = $null

    $lastIndexOfDot = $className.LastIndexOf(".")
    if ($lastIndexOfDot -ne -1)
    {
        $namespaceName = $className.Substring(0, $lastIndexOfDot)
        $shortClassName = $className.Substring($lastIndexOfDot + 1)
    }

$banner = @'
//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a New-StronglyTypedCsFileForResx funciton.
//     To add or remove a member, edit your .ResX file then rerun buildCoreClr.ps1
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

{0}
'@

$namespace = @'
namespace {0} {{
{1}
}}
'@

$body = @'
using System;
using System.Reflection;

/// <summary>
///   A strongly-typed resource class, for looking up localized strings, etc.
/// </summary>
[global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Resources.Tools.StronglyTypedResourceBuilder", "4.0.0.0")]
[global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
[global::System.Runtime.CompilerServices.CompilerGeneratedAttribute()]

internal class {0} {{

    private static global::System.Resources.ResourceManager resourceMan;

    private static global::System.Globalization.CultureInfo resourceCulture;

    [global::System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode")]
    internal {0}() {{
    }}

    /// <summary>
    ///   Returns the cached ResourceManager instance used by this class.
    /// </summary>
    [global::System.ComponentModel.EditorBrowsableAttribute(global::System.ComponentModel.EditorBrowsableState.Advanced)]
    internal static global::System.Resources.ResourceManager ResourceManager {{
        get {{
            if (object.ReferenceEquals(resourceMan, null)) {{
                global::System.Resources.ResourceManager temp = new global::System.Resources.ResourceManager("{3}.resources.{2}", typeof({0}).GetTypeInfo().Assembly);
                resourceMan = temp;
            }}
            return resourceMan;
        }}
    }}

    /// <summary>
    ///   Overrides the current thread's CurrentUICulture property for all
    ///   resource lookups using this strongly typed resource class.
    /// </summary>
    [global::System.ComponentModel.EditorBrowsableAttribute(global::System.ComponentModel.EditorBrowsableState.Advanced)]
    internal static global::System.Globalization.CultureInfo Culture {{
        get {{
            return resourceCulture;
        }}
        set {{
            resourceCulture = value;
        }}
    }}
    {1}
}}
'@

    $entry = @'

    /// <summary>
    ///   Looks up a localized string similar to {1}
    /// </summary>
    internal static string {0} {{
        get {{
            return ResourceManager.GetString("{0}", resourceCulture);
        }}
    }}
'@
    $entries = $xml.root.data | % {
        if ($_) {
            $val = $_.value.Replace("`n", "`n    ///")
            $name = $_.name.Replace(' ', '_')
            $entry -f $name,$val
        }
    } | Out-String
    
    $bodyCode = $body -f $shortClassName,$entries,$ClassName,$moduleName

    if ($NamespaceName)
    {
        $bodyCode = $namespace -f $NamespaceName, $bodyCode
    }

    $resultCode = $banner -f $bodyCode

    return $resultCode -replace "`r`n?|`n","`r`n"
}

$projectRoot = Split-Path $MyInvocation.InvocationName
if (-not (Test-Path "$projectRoot/global.json"))
{
    throw "Not in solution root"
}
$inputFilePath = Join-Path $projectRoot "$project/resources/Messages.resx"

if ($nameSpaceDict.ContainsKey($project)) {
    $className = $nameSpaceDict[$project] + ".Resources.Messages"
    $outputFilePath = Join-Path $projectRoot "$project/gen/$className.cs"

    if (-not (Test-Path "$projectRoot/$project/gen"))
    {
        md "$projectRoot/$project/gen"
    }

    $newResxFile = Join-Path $projectRoot "$project/resources/$className.resx"
    Copy-Item $inputFilePath $newResxFile -Force
    $xml = [xml](Get-Content -raw $inputFilePath)
    $genSource = Get-StronglyTypeCsFileForResx -xml $xml -ClassName $className -moduleName $project
    Set-Content -Encoding Ascii -Path $outputFilePath -Value $genSource
}