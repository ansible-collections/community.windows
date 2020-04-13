#!powershell
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

<#
Function to enable 32 bit .net version for iis web Apps
#>
#Requires -Module WebAdministration
Param(
[Parameter(Mandatory=$true)][string]$poolname
)
<# Function to enable 32 bit for spesified pool 
#>
Function Enable32bitVersion
    { 
        [Cmdletbinding()]
        try {
            Import-Module WebAdministration
            Set-ItemProperty IIS:\AppPools\$poolname -name "enable32BitAppOnWin64" -Value "true"
            return "Enabled 32 Bit App for $poolname"
        }
        catch {
        throw $_
        }
    }
  
Enable32bitVersion

