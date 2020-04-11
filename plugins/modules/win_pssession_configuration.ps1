#!powershell

# Copyright: (c) 2020, Brian Scholer <@briantist>
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

#AnsibleRequires -CSharpUtil Ansible.Basic

$type = @{
    guid    = [Func[[Object], [System.Guid]]] {
        [System.Guid]::ParseExact($args[0].Trim([char[]]'}{').Replace('-', ''), 'N')
    }
    version = [Func[[Object], [System.Version]]] {
        [System.Version]::Parse($args[0])
    }
    int64   = [Func[[Object], [System.Int64]]] {
        [System.Int64]::Parse($args[0])
    }
    double  = [Func[[Object], [System.Double]]] {
        [System.Double]::Parse($args[0])
    }
}

$pssc_options = @{
    guid                                      = @{ type = $type.guid }
    schema_version                            = @{ type = $type.version }
    author                                    = @{ type = 'str' }
    description                               = @{ type = 'str' }
    company_name                              = @{ type = 'str' }
    copyright                                 = @{ type = 'str' }
    session_type                              = @{ type = 'str' ; choices = @('default', 'empty', 'restricted_remote_server') }
    transcript_directory                      = @{ type = 'path' }
    run_as_virtual_account                    = @{ type = 'bool' }
    run_as_virtual_account_groups             = @{ type = 'list' ; elements = 'str' }
    mount_user_drive                          = @{ type = 'bool' }
    user_drive_maximum_size                   = @{ type = $type.int64 }
    group_managed_service_account             = @{ type = 'str' }
    scripts_to_process                        = @{ type = 'list' ; elements = 'str' }
    role_definitions                          = @{ type = 'dict' }
    required_groups                           = @{ type = 'dict' }
    language_mode                             = @{ type = 'str' ; choices = @('no_language', 'restricted_language', 'constrained_language', 'full_language') }
    execution_policy                          = @{ type = 'str' ; choices = @('default', 'remote_signed', 'restricted', 'undefined', 'unrestricted') }
    powershell_version                        = @{ type = $type.version }
    modules_to_import                         = @{ type = 'list' }
    visible_aliases                           = @{ type = 'list' ; elements = 'str' }
    visible_cmdlets                           = @{ type = 'list' }
    visible_functions                         = @{ type = 'list' }
    visible_external_commands                 = @{ type = 'list' ; elements = 'str' }
    alias_definitions                         = @{ type = 'dict' }
    function_definitions                      = @{ type = 'dict' }
    variable_definitions                      = @{ type = 'list' }
    environment_variables                     = @{ type = 'dict' }
    types_to_process                          = @{ type = 'list' ; elements = 'path' }
    formats_to_process                        = @{ type = 'list' ; elements = 'path' }
    assemblies_to_load                        = @{ type = 'list' ; elements = 'str' }
}

$session_configuration_options = @{
    name                                      = @{ type = 'str' ; required = $true }
    processor_architecure                     = @{ type = 'str'  ; choices = @('amd64', 'x86') }
    access_mode                               = @{ type = 'str' ; choices = @('disabled', 'local', 'remote') }
    use_shared_process                        = @{ type = 'bool' }
    thread_apartment_state                    = @{ type = 'str' ; choices = @('mta', 'sta') }
    thread_options                            = @{ type = 'str' ; choices = @('default', 'resue_thread', 'use_current_thread', 'use_new_thread') }
    startup_script                            = @{ type = 'path' }
    maximum_received_data_size_per_command_mb = @{ type = $type.double }
    maximum_received_object_size_mb           = @{ type = $type.double }
    security_descriptor_sddl                  = @{ type = 'str' }
    run_as_credential_username                = @{ type = 'str' }
    run_as_credential_password                = @{ type = 'str' ; no_log = $true }
}

$behavior_options = @{
    state                                     = @{ type = 'str' ; choices = @('present', 'absent') ; default = 'present' }
    existing_connection_timeout_seconds       = @{ type = 'int' ; default = 0 }
    existing_connection_timeout_action        = @{ type = 'str' ; choices = @('terminate', 'fail') ; default = 'terminate' }
    existing_connection_wait_states           = @{ type = 'list' ; elements = 'str' ; default = @('connected') }
}

$spec = @{
    options = $pssc_options + $session_configuration_options + $behavior_options
    required_together = @(
        @('run_as_credential_username', 'run_as_credential_password')
    )
    supports_check_mode = $true
}

$module = [Ansible.Basic.AnsibleModule]::Create($args, $spec)


# TODO: check for existing connections with timeout
# Get-WSManInstance -ComputerName localhost -ResourceURI shell -Enumerate

function Import-LegacyPowerShellDataFile {
    <#
        .SYNOPSIS
        A pre-PowerShell 5.0 version of Import-PowerShellDataFile

        .DESCRIPTION
        Safely imports a PowerShell Data file in PowerShell versions before 5.0
        when the built-in command was introduced. Non-literal Path support is not included.
    #>
    [CmdletBinding()]
    [OutputType([hashtable])]
    param(
        [Parameter(Mandatory=$true)]
        [Alias('Path')]
        [String]
        $LiteralPath
    )

    End {
        $astloader = [System.Management.Automation.Language.Parser]::ParseFile($LiteralPath, [ref] $null , [ref] $null)
        $ht = $astloader.Find({ param($ast)
             $ast -is [System.Management.Automation.Language.HashtableAst]
        }, $false)
        $ht.SafeGetValue()
    }
}
function ConvertFrom-SnakeCase {
    [CmdletBinding()]
    [OutputType([String])]
    param(
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [String]
        $SnakedString
    )

    Process {
        [regex]::Replace($SnakedString, '^_?.|_.', { param($m) $m.Value.TrimStart('_').ToUpperInvariant() })
    }
}
function ConvertFrom-AnsibleOptions {
    [CmdletBinding()]
    [OutputType([System.Collections.IDictionary])]
    param(
        [Parameter(Mandatory=$true)]
        [System.Collections.IDictionary]
        $Params ,

        [Parameter(Mandatory=$true)]
        [hashtable]
        $OptionSet
    )

    End {
        $ret = @{}
        foreach ($option in $OptionSet.GetEnumerator()) {
            if ($Params.Contains($option.Name)) {
                $raw_name = $option.Name
                switch -Wildcard ($raw_name) {
                    'run_as_credential_*' {
                        $raw_name = $raw_name -replace '_[^_]+$'
                        $name = ConvertFrom-SnakeCase -SnakedString $raw_name
                        if (-not $ret.Contains($name)) {
                            $un = $OptionSet["${raw_name}_username"]
                            $secpw = ConvertTo-SecureString -String $OptionSet["${raw_name}_password"] -AsPlainText -Force
                            $value = New-Object -TypeName PSCredential -ArgumentList $un, $secpw
                            $ret[$name] = $value
                        }
                        break
                    }

                    default {
                        $value = $Params[$raw_name]
                        if ($option.Contains('choices')) {
                            $value = ConvertFrom-SnakeCase -SnakedString $value
                        }
                        $name = ConvertFrom-SnakeCase -SnakedString $raw_name
                        $ret[$name] = $value
                    }
                }
            }
        }

        $ret
    }
}

function Write-GeneratedSessionConfiguration {
    [CmdletBinding()]
    [OutputType([System.IO.FileInfo])]
    param(
        [Parameter(Mandatory=$true)]
        [System.Collections.IDictionary]
        $ParameterSet ,

        [Parameter()]
        [String]
        $OutFile
    )

    End {
        $file = if ($OutFile) {
            $OutFile
        }
        else {
            [System.IO.Path]::GetTempFileName()
        }

        $file = $file -replace '\.pssc$', '.pssc'
        New-PSSessionConfigurationFile -Path $file @ParameterSet
        [System.IO.FileInfo]$file
    }
}
function ConvertTo-WhitespaceNormalized {
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory = $true,
            ValueFromPipeline = $true
        )]
        [String]
        $Value
    )

    Process {
        return $Value
        $Value -replace '\s*?(?:\r?\n)+', "`n"
    }
}

function Compare-ConfigFile {
    [CmdletBinding()]
    [OutputType([bool])]
    param(
        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true)]
        [System.IO.FileInfo]
        $ConfigFilePath ,

        [Parameter(Mandatory=$true)]
        [System.IO.FileInfo]
        $NewConfigFile ,

        [Parameter(Mandatory=$true)]
        [System.Collections.IDictionary]
        $Params
    )

    Process {
        $existing_content   = Import-PowerShellDataFile -LiteralPath $ConfigFilePath.FullName
        $desired_content    = Import-PowerShellDataFile -LiteralPath $NewConfigFile.FullName


    }
}

if (-not (Get-Command -Name 'Microsoft.PowerShell.Utility\Import-PowerShellDataFile' -ErrorAction SilentlyContinue)) {
    New-Alias -Name 'Import-PowerShellDataFile' -Value 'Import-LegacyPowerShellDataFile'
}

$result = @{ }

$existing = Get-PSSessionConfiguration -Name $name -ErrorAction SilentlyContinue

$opt_pssc    = ConvertFrom-AnsibleOptions -Params $module.Params -OptionSet $pssc_options
$opt_session = ConvertFrom-AnsibleOptions -Params $module.Params -OptionSet $session_configuration_options

try {
    if ($opt_pssc.Count) {
        # config file options were passed to the module, so generate a config file from those
        $desired_config = Write-GeneratedSessionConfiguration -ParameterSet $options.pssc -OutFile $module.Params.session_configuration_save_path
    }
    if ($existing) {
        # the endpoint is registered
        if ((Test-Path -LiteralPath $existing.ConfigFilePath)) {
            # the registered endpoint uses a config file
            if ($desired_config) {
                # a desired config file exists, so read the content for comparison
                $desired_content = Get-Content -LiteralPath $desired_config.FullName -Raw | ConvertTo-WhitespaceNormalized

                # then load the config file from the existing, and compare them
                $existing_content = Get-Content -LiteralPath $existing.ConfigFilePath -Raw | ConvertTo-WhitespaceNormalized
                $content_match = $existing_content -ceq $desired_content
            }
            else {
                # existing endpoint has a config file but no config file options were passed, so there is no match
                $content_match = $false
            }
        }
        else {
            # existing endpoint doesn't use a config file, so it's a match if there are also no config options passed
            $content_match = -not $opt_pssc.Count
        }

        ## compare the options that don't get set in the config file (unless credential is supplied, which is always a change)
        $session_match = -not $opt_session.Contains('RunAsCredential')
        foreach ($opt in $opt_session.GetEnumerator()) {
            if (-not $session_match) {
                break
            }
            $session_match = $session_match -and (
                $existing.($opt.Name) -ceq $opt.Value
            )
        }
    }

    $create = $state -eq 'present' -and (-not $existing -or -not $content_match)
    $remove = $existing -and ($state -eq 'absent' -or -not $content_match)
    $session_change = -not $session_match -and $state -ne 'absent'

    $module.Result.changed = $create -or $remove -or $session_change

    if (-not $check_mode) {
        if ($remove) {
            Unregister-PSSessionConfiguration -Name $opt_session.Name -Force
        }

        if ($create) {
            if ($desired_config) {
                $opt_session.Path = $desired_config
            }
            $null = Register-PSSessionConfiguration @opt_session -Force
        }
        elseif ($session_change) {
            $psso = $options.session
            Set-PSSessionConfiguration @psso -Force
        }
    }
}
finally {
    if ($desired_config) {
        Remove-Item -LiteralPath $desired_config -Force
    }
}

Exit-Json -obj $result
