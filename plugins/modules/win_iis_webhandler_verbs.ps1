<# Function to set or create Web handler 
Handler mappings settings for GAS 19.4
This script will set  
-HandlerName Name of the handler
-ModuleName Which module to use (Not Mandatory)
-SiteName Which site to set handler mappings
-ResourceType Whether file,directory,both or unspecified
-Verb which Http verb to uses
#>
Param(
[Parameter(Mandatory=$true)][string]$HandlerName,
[Parameter(Mandatory=$false)][string]$ModuleName,
[Parameter(Mandatory=$true)][string]$DllPath,
[Parameter(Mandatory=$true)][string]$SitePath,
[Parameter(Mandatory=$false)][string]$ResourceType
)
Import-Module WebAdministration
cd 'IIS:\Sites\Default Web Site'
Function NewHandaler
{
[CmdletBinding()]
# If web handler is present then edit
if(Test-Path -Path 'IIS:\Sites\Default Web Site\$SiteName')
{
Set-WebHandler -Name $HandlerName -Modules IsapiModule -PSPath $SitePath -verb '*' -ScriptProcessor $DllPath -path "*" -ResourceType Unspecified
}
# If web handler is not present then create 
else
{
New-WebHandler -Name $HandlerName -Modules IsapiModule -PSPath $SitePath -Path "*" -ResourceType Unspecified -ScriptProcessor $DllPath -verb '*'
}
}
# Calling function
NewHandaler
