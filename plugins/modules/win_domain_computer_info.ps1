#!powershell
Set-StrictMode -Version 2.0

# Copyright: (c) 2021, Ansible Project
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

#AnsibleRequires -CSharpUtil Ansible.Basic
#Requires -Module ActiveDirectory

$spec = @{
    options = @{
        identity = @{ type = "str";  }
        properties = @{type = "list"; default = '*'}
        search_scope = @{ type = 'str'; choices = @('base', 'one_level', 'subtree')}
        filter = @{type= "str";}
        ldap_filter = @{type= "str";}
        domain_username = @{ type = "str"; }
        domain_password = @{ type = "str";  no_log = $true }
        domain_server = @{ type = "str"; }
    }
    required_together = @(
            ,@('domain_password', 'domain_username')
        )
    mutually_exclusive = @(
            ,@('filter', 'identity', 'ldap_filter')
            ,@('identity', 'search_scope')
            ,@('identity', 'search_base')
        )
    required_one_of = @(
            ,@('filter', 'identity', 'ldap_filter')
        )
    supports_check_mode = $true
}

$module = [Ansible.Basic.AnsibleModule]::Create($args, $spec)

#setting so always returns something
$module.Result.computers = @{}
$module.Result.exists = $false
$module.Result.changed = $false

$extra_args = @{}
if ($null -ne $module.Params.Identity){
    $extra_args.Identity = $module.Params.identity
}
if ($module.Params.properties.count -ne 0){
    $extra_args.Properties = New-Object Collections.Generic.List[string]
    $module.Params.properties | Foreach-Object{
        $keyName = $_
        $extra_args.Properties.Add($keyName)
    }
}else{
    $extra_args.Properties = '*'
}
if ($null -ne $module.Params.search_scope){
    $extra_args.SearchScope = $module.Params.search_scope
}
if ($null -ne $module.Params.filter){
    $extra_args.Filter = $module.Params.filter
}
if ($null -ne $module.Params.ldap_filter){
    $extra_args.ldap_filter = $module.Params.ldap_filter
}

if ($null -ne $module.Params.domain_username) {
    $domain_password = ConvertTo-SecureString $module.Params.domain_password -AsPlainText -Force
    $credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $module.Params.domain_username, $domain_password
    $extra_args.Credential = $credential
}

if ($null -ne $module.Params.domain_server) {
    $extra_args.Server = $module.Params.domain_server
}

# attempt import of module
Try { Import-Module ActiveDirectory }
Catch { $module.FailJson("The ActiveDirectory module failed to load properly: $($_.Exception.Message)", $_) }

# Attempt to run Get-AdComputer
Try { $All_Computer_Info = Get-ADComputer @extra_args}
Catch {$module.FailJson("Get-ADComputer @extra_args failed durring execution: $($_.Exception.Message)", $_) }

# Process return info
$module.Result.computers = @(foreach ($Computer in ($All_Computer_Info)) {
    $returnObj = @{}
    $computer.GetEnumerator() | Foreach-Object {
        $name = $_.key
        $value =$_.value | ConvertTo-Json -Depth 2 | ConvertFrom-Json
        $returnObj.Add($name, $value )
    }
    $module.Result.exists = $true
    $returnObj
})
$module.ExitJson()
