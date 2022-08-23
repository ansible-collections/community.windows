#!powershell

# Copyright: (c) 2020 VMware, Inc. All Rights Reserved.
# SPDX-License-Identifier: GPL-3.0-only
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

#AnsibleRequires -CSharpUtil Ansible.Basic

$spec = @{
    options = @{
        type = @{ type = "str"; choices = "reservation", "lease"; default = "reservation" }
        ip = @{ type = "str" }
        scope_id = @{ type = "str" }
        mac = @{ type = "str" }
        duration = @{ type = "int" }
        dns_hostname = @{ type = "str"; }
        dns_regtype = @{ type = "str"; choices = "aptr", "a", "noreg"; default = "aptr" }
        reservation_name = @{ type = "str"; }
        description = @{ type = "str"; }
        state = @{ type = "str"; choices = "absent", "present"; default = "present" }
    }
    required_if = @(
        @("state", "present", @("mac", "ip"), $true),
        @("state", "absent", @("mac", "ip"), $true)
    )
    supports_check_mode = $true
}

$module = [Ansible.Basic.AnsibleModule]::Create($args, $spec)
$check_mode = $module.CheckMode

$type = $module.Params.type
$ip = $module.Params.ip
$scope_id = $module.Params.scope_id
$mac = $module.Params.mac
$duration = $module.Params.duration
$dns_hostname = $module.Params.dns_hostname
$dns_regtype = $module.Params.dns_regtype
$reservation_name = $module.Params.reservation_name
$description = $module.Params.description
$state = $module.Params.state

Function Convert-MacAddress {
    Param(
        [string]$mac
    )
    # Remove dashes and colons
    $mac = $mac -replace ':'
    $mac = $mac -replace '-'
    
    # These are valid characters for a mac address or a client identifier
    $pat = "^[a-fA-F0-9]+$"
    
    # Get the length of the provided identifier
    $mac_length = $mac.length

    # Evaluate the identifier. The maximum length of a client identifier is 510 characters, otherwise the DHCP server crashes. 
    # The number of characters should be an even number, as the DHCP server otherwise shortens the string. The minimum
    # number of characters is 2 (regardless if such a short identifier makes sense). Allowed characters are 0-9 and A-F,
    # allthough the RFC allows any characters, Microsoft does not.
    if ($mac -match $pat -and $mac_length -ge 2 -and $mac_length -le 510 -and $mac_length % 2 -eq 0) {
    
        # The string is a valid client identifier, so we prepare the string to represent the *-*-* pattern for this client id
    	for ($i = 2; $i -lt $mac_length; $i+=3) {
            $mac = $mac.Insert($i,'-')
        }
        return $mac
    }
    else {
        return $false
    }
}

Function Compare-DhcpLease {
    Param(
        [PSObject]$Original,
        [PSObject]$Updated
    )

    # Compare values that we care about
    -not (
        ($Original.AddressState -eq $Updated.AddressState) -and
        ($Original.IPAddress -eq $Updated.IPAddress) -and
        ($Original.ScopeId -eq $Updated.ScopeId) -and
        ($Original.Name -eq $Updated.Name) -and
        ($Original.Description -eq $Updated.Description)
    )
}

Function Convert-ReturnValue {
    Param(
        $Object
    )

    return @{
        address_state = $Object.AddressState
        client_id = $Object.ClientId
        ip_address = $Object.IPAddress.IPAddressToString
        scope_id = $Object.ScopeId.IPAddressToString
        name = $Object.Name
        description = $Object.Description
    }
}

# Parse Regtype
if ($dns_regtype) {
    Switch ($dns_regtype) {
        "aptr" { $dns_regtype = "AandPTR"; break }
        "a" { $dns_regtype = "A"; break }
        "noreg" { $dns_regtype = "NoRegistration"; break }
        default { $dns_regtype = "NoRegistration"; break }
    }
}

Try {
    # Import DHCP Server PS Module
    Import-Module DhcpServer
}
Catch {
    # Couldn't load the DhcpServer Module
    $module.FailJson("The DhcpServer module failed to load properly: $($_.Exception.Message)", $_)
}

# Determine if there is an existing lease
if ($ip) {
    $current_lease = Get-DhcpServerv4Scope | Get-DhcpServerv4Lease | Where-Object IPAddress -eq $ip
}

# MacAddress was specified
if ($mac) {
    
    if ($mac -like "*-*") {
        $mac_original = $mac
        $mac = Convert-MacAddress -mac $mac
    }

    if ($mac -eq $false) {
        $module.FailJson("The MAC Address is not properly formatted")
    }
    else {
        $current_lease = Get-DhcpServerv4Scope | Get-DhcpServerv4Lease | Where-Object ClientId -eq $mac_original
    }
}

# Did we find a lease/reservation
if ($current_lease) {
    $current_lease_exists = $true
    $original_lease = $current_lease
    $module.Diff.before = Convert-ReturnValue -Object $original_lease
}
else {
    $current_lease_exists = $false
}

# If we found a lease, is it a reservation?
if ($current_lease_exists -eq $true -and ($current_lease.AddressState -like "*Reservation*")) {
    $current_lease_reservation = $true
}
else {
    $current_lease_reservation = $false
}

# State: Absent
# Ensure the DHCP Lease/Reservation is not present
if ($state -eq "absent") {
    # If the lease doesn't exist, our work here is done
    if ($current_lease_exists -eq $false) {
        $module.Result.msg = "The lease doesn't exist."
    }
    else {
        # If the lease exists, we need to destroy it
        if ($current_lease_reservation -eq $true) {
            # Try to remove reservation
            Try {
                $current_lease | Remove-DhcpServerv4Reservation -WhatIf:$check_mode
                $state_absent_removed = $true
            }
            Catch {
                $state_absent_removed = $false
                $remove_err = $_
            }
        }
        else {
            # Try to remove lease
            Try {
                $current_lease | Remove-DhcpServerv4Lease -WhatIf:$check_mode
                $state_absent_removed = $true
            }
            Catch {
                $state_absent_removed = $false
                $remove_err = $_
            }
        }

        # See if we removed the lease/reservation
        if ($state_absent_removed) {
            $module.Result.changed = $true
        }
        else {
            $module.Result.lease = Convert-ReturnValue -Object $current_lease
            $module.FailJson("Unable to remove lease/reservation: $($remove_err.Exception.Message)", $remove_err)
        }
    }
}

# State: Present
# Ensure the DHCP Lease/Reservation is present, and consistent
if ($state -eq "present") {
    # Current lease exists, and is not a reservation
    if (($current_lease_reservation -eq $false) -and ($current_lease_exists -eq $true)) {
        if ($type -eq "reservation") {
            Try {
                # Update parameters
                $params = @{ }

                if ($mac) {
                    $params.ClientId = $mac
                }
                else {
                    $params.ClientId = $current_lease.ClientId
                }

                if ($description) {
                    $params.Description = $description
                }
                else {
                    $params.Description = $current_lease.Description
                }

                if ($reservation_name) {
                    $params.Name = $reservation_name
                }
                else {
                    $params.Name = "reservation-" + $params.ClientId
                }

                # Desired type is reservation
                $current_lease | Add-DhcpServerv4Reservation -WhatIf:$check_mode

                if (-not $check_mode) {
                    $current_reservation = Get-DhcpServerv4Lease -ClientId $params.ClientId -ScopeId $current_lease.ScopeId
                }

                # Update the reservation with new values
                $current_reservation | Set-DhcpServerv4Reservation @params -WhatIf:$check_mode

                if (-not $check_mode) {
                    $updated_reservation = Get-DhcpServerv4Lease -ClientId $params.ClientId -ScopeId $current_reservation.ScopeId
                }

                if (-not $check_mode) {
                    # Compare Values
                    $module.Result.changed = Compare-DhcpLease -Original $original_lease -Updated $updated_reservation
                    $module.Result.lease = Convert-ReturnValue -Object $updated_reservation
                }
                else {
                    $module.Result.changed = $true
                }

                $module.ExitJson()
            }
            Catch {
                $module.FailJson("Could not convert lease to a reservation", $_)
            }
        }
    }

    # Current lease exists, and is a reservation
    if (($current_lease_reservation -eq $true) -and ($current_lease_exists -eq $true)) {
        if ($type -eq "lease") {
            Try {
                # Desired type is a lease, remove the reservation
                $current_lease | Remove-DhcpServerv4Reservation -WhatIf:$check_mode

                # Build a new lease object with remnants of the reservation
                $lease_params = @{
                    ClientId = $original_lease.ClientId
                    IPAddress = $original_lease.IPAddress.IPAddressToString
                    ScopeId = $original_lease.ScopeId.IPAddressToString
                    HostName = $original_lease.HostName
                    AddressState = 'Active'
                }

                # Create new lease
                Try {
                    Add-DhcpServerv4Lease @lease_params -WhatIf:$check_mode
                }
                Catch {
                    $module.FailJson("Unable to convert the reservation to a lease", $_)
                }

                # Get the lease we just created
                if (-not $check_mode) {
                    Try {
                        $new_lease = Get-DhcpServerv4Lease -ClientId $lease_params.ClientId -ScopeId $lease_params.ScopeId
                    }
                    Catch {
                        $module.FailJson("Unable to retreive the newly created lease", $_)
                    }
                }

                if (-not $check_mode) {
                    $module.Result.lease = Convert-ReturnValue -Object $new_lease
                }

                $module.Result.changed = $true
                $module.ExitJson()
            }
            Catch {
                $module.FailJson("Could not convert reservation to lease", $_)
            }
        }

        # Already in the desired state
        if ($type -eq "reservation") {

            # Update parameters
            $params = @{ }

            if ($mac) {
                $params.ClientId = $mac
            }
            else {
                $params.ClientId = $current_lease.ClientId
            }

            if ($description) {
                $params.Description = $description
            }
            else {
                $params.Description = $current_lease.Description
            }

            if ($reservation_name) {
                $params.Name = $reservation_name
            }
            else {
                # Original lease had a null name so let's generate one
                if ($null -eq $original_lease.Name) {
                    $params.Name = "reservation-" + $original_lease.ClientId
                }
                else {
                    $params.Name = $original_lease.Name
                }
            }

            # Update the reservation with new values
            $current_lease | Set-DhcpServerv4Reservation @params -WhatIf:$check_mode

            if (-not $check_mode) {
                $reservation = Get-DhcpServerv4Lease -ClientId $current_lease.ClientId -ScopeId $current_lease.ScopeId
                $module.Result.changed = Compare-DhcpLease -Original $original_lease -Updated $reservation
                $module.Result.lease = Convert-ReturnValue -Object $reservation
            }
            else {
                $module.Result.changed = $true
            }

            # Return values
            $module.ExitJson()
        }
    }

    # Lease Doesn't Exist - Create
    if ($current_lease_exists -eq $false) {
        # Required: Scope ID
        if (-not $scope_id) {
            $module.Result.changed = $false
            $module.FailJson("The scope_id parameter is required for state=present when a lease or reservation doesn't already exist")
        }

        # Required Parameters
        $lease_params = @{
            ClientId = $mac
            IPAddress = $ip
            ScopeId = $scope_id
            AddressState = 'Active'
            Confirm = $false
        }

        if ($duration) {
            $lease_params.LeaseExpiryTime = (Get-Date).AddDays($duration)
        }

        if ($dns_hostname) {
            $lease_params.HostName = $dns_hostname
        }

        if ($dns_regtype) {
            $lease_params.DnsRR = $dns_regtype
        }

        if ($description) {
            $lease_params.Description = $description
        }

        # Create Lease
        Try {
            # Create lease based on parameters
            Add-DhcpServerv4Lease @lease_params -WhatIf:$check_mode

            # Retreive the lease
            if (-not $check_mode) {
                $new_lease = Get-DhcpServerv4Lease -ClientId $mac -ScopeId $scope_id
                $module.Result.lease = Convert-ReturnValue -Object $new_lease
            }

            # If lease is the desired type
            if ($type -eq "lease") {
                $module.Result.changed = $true
                $module.ExitJson()
            }
        }
        Catch {
            # Failed to create lease
            $module.FailJson("Could not create DHCP lease: $($_.Exception.Message)", $_)
        }

        # Create Reservation
        Try {
            # If reservation is the desired type
            if ($type -eq "reservation") {
                if ($reservation_name) {
                    $lease_params.Name = $reservation_name
                }
                else {
                    $lease_params.Name = "reservation-" + $mac
                }

                Try {
                    if ($check_mode) {
                        # In check mode, a lease won't exist for conversion, make one manually
                        Add-DhcpServerv4Reservation -ScopeId $scope_id -ClientId $mac_original -IPAddress $ip -WhatIf:$check_mode
                    }
                    else {
                        # Convert to Reservation
                        $new_lease | Add-DhcpServerv4Reservation -WhatIf:$check_mode
                    }
                }
                Catch {
                    # Failed to create reservation
                    $module.FailJson("Could not create DHCP reservation: $($_.Exception.Message)", $_)
                }

                if (-not $check_mode) {
                    # Get DHCP reservation object
                    $new_lease = Get-DhcpServerv4Reservation -ClientId $mac_original -ScopeId $scope_id
                    $module.Result.lease = Convert-ReturnValue -Object $new_lease
                }

                $module.Result.changed = $true
            }
        }
        Catch {
            # Failed to create reservation
            $module.FailJson("Could not create DHCP reservation: $($_.Exception.Message)", $_)
        }
    }
}

$module.ExitJson()
