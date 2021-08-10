#!powershell

# Copyright: (c) 2016, Daniele Lazzari <lazzari@mailup.com>
# Modified by: Vicente Danzmann Vivian (@iVcente)
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

#Requires -Module Ansible.ModuleUtils.Legacy

# win_route (Add or remove a network static route)

$params = Parse-Args $args -supports_check_mode $true

$check_mode = Get-AnsibleParam -obj $params -name "_ansible_check_mode" -default $false
$network = Get-AnsibleParam -obj $params -name "network" -type "str" -failifempty $true
$mask = Get-AnsibleParam -obj $params -name "mask" -type "str" -failifempty $true
$gateway = Get-AnsibleParam -obj $params -name "gateway" -type "str" -failifempty $true
$metric = Get-AnsibleParam -obj $params -name "metric" -type "int" -default 1
$state = Get-AnsibleParam -obj $params -name "state" -type "str" -default "present" -validateSet "present","absent"
$result = @{
             "changed" = $false
             "output" = ""
           }

########################
### Add static route ###
########################

Function Add-Route {
    Param (
        [Parameter(Mandatory=$true)]
        [string]$Network,

        [Parameter(Mandatory=$true)]
        [string]$Mask,

        [Parameter(Mandatory=$true)]
        [string]$Gateway,

        [Parameter(Mandatory=$true)]
        [int]$Metric,

        [Parameter(Mandatory=$true)]
        [bool]$CheckMode
    )

    # Check if the static route is already present
    $Route = Get-CimInstance -ClassName Win32_IP4PersistedRouteTable | Where-Object { $_.Destination -EQ "$($Network)" -AND $_.Mask -EQ "$($Mask)" }

    # In case of running in Check Mode
    if ($CheckMode -AND !($Route)) {
        $result.changed = $true
        $result.output = "Route can be added!"
        return
    }

    # If route doesn't exist, add it
    if (!($Route)) {
        try {
            # Add static route
            route -p ADD $Network MASK $Mask $Gateway METRIC $Metric
            $result.changed = $true
            $result.output = "Route added!"
        }
        catch {
            $ErrorMessage = $_.Exception.Message
            Fail-Json $result $ErrorMessage
        }
    }
    # If route already exists, just print
    else {
        $result.output = "Static route already exists."
    }
}

###########################
### Remove static route ###
###########################

Function Remove-Route {
    Param (
        [Parameter(Mandatory=$true)]
        [string]$Network,

        [Parameter(Mandatory=$true)]
        [string]$Mask,

        [Parameter(Mandatory=$true)]
        [string]$Gateway,

        [Parameter(Mandatory=$true)]
        [bool]$CheckMode
    )

    # Check if the static route is already present
    $Route = Get-CimInstance -ClassName Win32_IP4PersistedRouteTable | Where-Object { $_.Destination -EQ "$($Network)" -AND $_.Mask -EQ "$($Mask)" }

    # In case of running in Check Mode
    if ($CheckMode -AND $Route) {
        $result.changed = $true
        $result.output = "Route can be removed!"
        return
    }

    # If route exists, remove it
    if ($Route) {
        try {
            # Remove static route
            route DELETE $Network MASK $Mask $Gateway
            $result.changed = $true
            $result.output = "Route removed!"
        }
        catch {
            $ErrorMessage = $_.Exception.Message
            Fail-Json $result $ErrorMessage
        }
    }
    # If route doesn't exist, just print
    else {
        $result.output = "No route to remove."
    }
}

if ($state -EQ "absent") {
    Remove-Route -Network $network -Mask $mask -Gateway $gateway -CheckMode $check_mode
}
else {
    Add-Route -Network $network -Mask $mask -Gateway $gateway -Metric $metric -CheckMode $check_mode
}

Exit-Json $result