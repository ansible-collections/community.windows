#!powershell

# Copyright: (c) 2017, Noah Sparks <nsparks@outlook.com>
# Copyright: (c) 2017, Ansible Project
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

#Requires -Module Ansible.ModuleUtils.Legacy
#Requires -Module Ansible.ModuleUtils.CommandUtil

$ErrorActionPreference = 'Stop'

$params = Parse-Args -arguments $args -supports_check_mode $true
$check_mode = Get-AnsibleParam -obj $params -name "_ansible_check_mode" -type "bool" -default $false

$results = @{
    changed = $false
}

######################################
### populate sets for -validateset ###
######################################
$categories_rc = run-command -command 'auditpol /list /category /r'
$subcategories_rc = run-command -command 'auditpol /list /subcategory:* /r'

If ($categories_rc.item('rc') -eq 0) {
    $categories_guid = ConvertFrom-Csv $categories_rc.item('stdout') | Select-Object -expand GUID
    $categories_guid = $categories_guid.Trim('{', '}')
}
Else {
    Fail-Json -obj $results -message "Failed to retrive audit policy categories. Please make sure the auditpol command is functional on
    the system and that the account ansible is running under is able to retrieve them. $($_.Exception.Message)"
}

If ($subcategories_rc.item('rc') -eq 0) {
    $subcategories_guid = ConvertFrom-Csv $subcategories_rc.item('stdout') | Select-Object -expand GUID |
        Where-Object { $_ -notin $categories_guid }
    $subcategories_guid = $subcategories_guid.Trim('{', '}')
}
Else {
    Fail-Json -obj $results -message "Failed to retrive audit policy subcategories. Please make sure the auditpol command is functional on
    the system and that the account ansible is running under is able to retrieve them. $($_.Exception.Message)"
}

####################################
### GUID -> English name mapping ###
####################################
# Based off of DSC Community AuditPolicyDsc file
$category_to_guid_hash = @{
    ######Category/Subcategory                  GUID
    #Category
    "System" = "69979848-797A-11D9-BED3-505054503030";
    "Logon/Logoff" = "69979849-797A-11D9-BED3-505054503030";
    "Object Access" = "6997984A-797A-11D9-BED3-505054503030";
    "Privilege Use" = "6997984B-797A-11D9-BED3-505054503030";
    "Detailed Tracking" = "6997984C-797A-11D9-BED3-505054503030";
    "Policy Change" = "6997984D-797A-11D9-BED3-505054503030";
    "Account Management" = "6997984E-797A-11D9-BED3-505054503030";
    "DS Access" = "6997984F-797A-11D9-BED3-505054503030";
    "Account Logon" = "69979850-797A-11D9-BED3-505054503030";
    # Subcategory
    "Security State Change" = "0CCE9210-69AE-11D9-BED3-505054503030";
    "Security System Extension" = "0CCE9211-69AE-11D9-BED3-505054503030";
    "System Integrity" = "0CCE9212-69AE-11D9-BED3-505054503030";
    "IPsec Driver" = "0CCE9213-69AE-11D9-BED3-505054503030";
    "Other System Events" = "0CCE9214-69AE-11D9-BED3-505054503030";
    "Logon" = "0CCE9215-69AE-11D9-BED3-505054503030";
    "Logoff" = "0CCE9216-69AE-11D9-BED3-505054503030";
    "Account Lockout" = "0CCE9217-69AE-11D9-BED3-505054503030";
    "IPsec Main Mode" = "0CCE9218-69AE-11D9-BED3-505054503030";
    "IPsec Quick Mode" = "0CCE9219-69AE-11D9-BED3-505054503030";
    "IPsec Extended Mode" = "0CCE921A-69AE-11D9-BED3-505054503030";
    "Special Logon" = "0CCE921B-69AE-11D9-BED3-505054503030";
    "Other Logon/Logoff Events" = "0CCE921C-69AE-11D9-BED3-505054503030";
    "Network Policy Server" = "0CCE9243-69AE-11D9-BED3-505054503030";
    "User / Device Claims" = "0CCE9247-69AE-11D9-BED3-505054503030";
    "Group Membership" = "0CCE9249-69AE-11D9-BED3-505054503030";
    "File System" = "0CCE921D-69AE-11D9-BED3-505054503030";
    "Registry" = "0CCE921E-69AE-11D9-BED3-505054503030";
    "Kernel Object" = "0CCE921F-69AE-11D9-BED3-505054503030";
    "SAM" = "0CCE9220-69AE-11D9-BED3-505054503030";
    "Certification Services" = "0CCE9221-69AE-11D9-BED3-505054503030";
    "Application Generated" = "0CCE9222-69AE-11D9-BED3-505054503030";
    "Handle Manipulation" = "0CCE9223-69AE-11D9-BED3-505054503030";
    "File Share" = "0CCE9224-69AE-11D9-BED3-505054503030";
    "Filtering Platform Packet Drop" = "0CCE9225-69AE-11D9-BED3-505054503030";
    "Filtering Platform Connection" = "0CCE9226-69AE-11D9-BED3-505054503030";
    "Other Object Access Events" = "0CCE9227-69AE-11D9-BED3-505054503030";
    "Detailed File Share" = "0CCE9244-69AE-11D9-BED3-505054503030";
    "Removable Storage" = "0CCE9245-69AE-11D9-BED3-505054503030";
    "Central Policy Staging" = "0CCE9246-69AE-11D9-BED3-505054503030";
    "Sensitive Privilege Use" = "0CCE9228-69AE-11D9-BED3-505054503030";
    "Non Sensitive Privilege Use" = "0CCE9229-69AE-11D9-BED3-505054503030";
    "Other Privilege Use Events" = "0CCE922A-69AE-11D9-BED3-505054503030";
    "Process Creation" = "0CCE922B-69AE-11D9-BED3-505054503030";
    "Process Termination" = "0CCE922C-69AE-11D9-BED3-505054503030";
    "DPAPI Activity" = "0CCE922D-69AE-11D9-BED3-505054503030";
    "RPC Events" = "0CCE922E-69AE-11D9-BED3-505054503030";
    "Plug and Play Events" = "0CCE9248-69AE-11D9-BED3-505054503030";
    "Token Right Adjusted Events" = "0CCE924A-69AE-11D9-BED3-505054503030";
    "Audit Policy Change" = "0CCE922F-69AE-11D9-BED3-505054503030";
    "Authentication Policy Change" = "0CCE9230-69AE-11D9-BED3-505054503030";
    "Authorization Policy Change" = "0CCE9231-69AE-11D9-BED3-505054503030";
    "MPSSVC Rule-Level Policy Change" = "0CCE9232-69AE-11D9-BED3-505054503030";
    "Filtering Platform Policy Change" = "0CCE9233-69AE-11D9-BED3-505054503030";
    "Other Policy Change Events" = "0CCE9234-69AE-11D9-BED3-505054503030";
    "User Account Management" = "0CCE9235-69AE-11D9-BED3-505054503030";
    "Computer Account Management" = "0CCE9236-69AE-11D9-BED3-505054503030";
    "Security Group Management" = "0CCE9237-69AE-11D9-BED3-505054503030";
    "Distribution Group Management" = "0CCE9238-69AE-11D9-BED3-505054503030";
    "Application Group Management" = "0CCE9239-69AE-11D9-BED3-505054503030";
    "Other Account Management Events" = "0CCE923A-69AE-11D9-BED3-505054503030";
    "Directory Service Access" = "0CCE923B-69AE-11D9-BED3-505054503030";
    "Directory Service Changes" = "0CCE923C-69AE-11D9-BED3-505054503030";
    "Directory Service Replication" = "0CCE923D-69AE-11D9-BED3-505054503030";
    "Detailed Directory Service Replication" = "0CCE923E-69AE-11D9-BED3-505054503030";
    "Credential Validation" = "0CCE923F-69AE-11D9-BED3-505054503030";
    "Kerberos Service Ticket Operations" = "0CCE9240-69AE-11D9-BED3-505054503030";
    "Other Account Logon Events" = "0CCE9241-69AE-11D9-BED3-505054503030";
    "Kerberos Authentication Service" = "0CCE9242-69AE-11D9-BED3-505054503030";
}

$guid_to_category_hash = @{}
$category_to_guid_hash.Keys | ForEach-Object {
    $guid_to_category_hash.Add($category_to_guid_hash[$_], $_)
}

$categories = $categories_guid | Foreach-Object { $guid_to_category_hash[$_] }
$subcategories = $subcategories_guid | Foreach-Object { $guid_to_category_hash[$_] }

######################
### ansible params ###
######################
$category = Get-AnsibleParam -obj $params -name "category" -type "str" -ValidateSet $categories
$subcategory = Get-AnsibleParam -obj $params -name "subcategory" -type "str" -ValidateSet $subcategories
$audit_type = Get-AnsibleParam -obj $params -name "audit_type" -type "list" -failifempty -

########################
### Start Processing ###
########################
Function Get-AuditPolicy ($GetString) {
    $auditpolcsv = Run-Command -command $GetString
    If ($auditpolcsv.item('rc') -eq 0) {
        $Obj = ConvertFrom-CSV $auditpolcsv.item('stdout') | Select-Object @{n = 'subcategory'; e = { $_.Subcategory.ToLower() } },
        @{ n = 'audit_type'; e = { $_."Inclusion Setting".ToLower() } }
    }
    Else {
        return $auditpolcsv.item('stderr')
    }

    $HT = @{}
    Foreach ( $Item in $Obj ) {
        $HT.Add($Item.subcategory, $Item.audit_type)
    }
    $HT
}

################
### Validate ###
################

#make sure category and subcategory are valid
If (-Not $category -and -Not $subcategory) { Fail-Json -obj $results -message "You must provide either a Category or Subcategory parameter" }
If ($category -and $subcategory) { Fail-Json -obj $results -message "Must pick either a specific subcategory or category. You cannot define both" }


$possible_audit_types = 'success', 'failure', 'none'
$audit_type | ForEach-Object {
    If ($_ -notin $possible_audit_types) {
        Fail-Json -obj $result -message "$_ is not a valid audit_type. Please choose from $($possible_audit_types -join ',')"
    }
}

#############################################################
### build lists for setting, getting, and comparing rules ###
#############################################################
$audit_type_string = $audit_type -join ' and '

$SetString = 'auditpol /set'
$GetString = 'auditpol /get /r'

If ($category) { $SetString = "$SetString /category:`"$category`""; $GetString = "$GetString /category:`"$category`"" }
If ($subcategory) { $SetString = "$SetString /subcategory:`"$subcategory`""; $GetString = "$GetString /subcategory:`"$subcategory`"" }


Switch ($audit_type_string) {
    'success and failure' { $SetString = "$SetString /success:enable /failure:enable"; $audit_type_check = $audit_type_string }
    'failure' { $SetString = "$SetString /success:disable /failure:enable"; $audit_type_check = $audit_type_string }
    'success' { $SetString = "$SetString /success:enable /failure:disable"; $audit_type_check = $audit_type_string }
    'none' { $SetString = "$SetString /success:disable /failure:disable"; $audit_type_check = 'No Auditing' }
    default { Fail-Json -obj $result -message "It seems you have specified an invalid combination of items for audit_type. Please review documentation" }
}

#########################
### check Idempotence ###
#########################

$CurrentRule = Get-AuditPolicy $GetString

#exit if the audit_type is already set properly for the category
If (-not ($CurrentRule.Values | Where-Object { $_ -ne $audit_type_check }) ) {
    $results.current_audit_policy = Get-AuditPolicy $GetString
    Exit-Json -obj $results
}

####################
### Apply Change ###
####################

If (-not $check_mode) {
    $ApplyPolicy = Run-Command -command $SetString

    If ($ApplyPolicy.Item('rc') -ne 0) {
        $results.current_audit_policy = Get-AuditPolicy $GetString
        Fail-Json $results "Failed to set audit policy - $($_.Exception.Message)"
    }
}

$results.changed = $true
$results.current_audit_policy = Get-AuditPolicy $GetString
Exit-Json $results
