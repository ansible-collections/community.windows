#!powershell

# Copyright: (c) 2017, Erwan Quelin (@equelin) <erwan.quelin@gmail.com>
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

#AnsibleRequires -CSharpUtil Ansible.Basic

$spec = @{
    options = @{
        output_file = @{ type = "str" }
        output_format = @{ type = "str"; default = "NunitXML" }
        path = @{ type = "str"; required = $true }
        tags = @{ type = "list"; elements = "str" }
        test_parameters = @{ type = "dict" }
        version = @{ type = "str"; aliases = @(, "minimum_version") }
    }
    supports_check_mode = $true
}

$module = [Ansible.Basic.AnsibleModule]::Create($args, $spec)

$output_file = $module.Params.output_file
$output_format = $module.Params.output_format
$path = $module.Params.path
$tags = $module.Params.tags
$test_parameters = $module.Params.test_parameters
$version = $module.Params.version

Try {
    $version = [version]$version
}
Catch {
    $module.FailJson("Value '$version' for parameter 'minimum_version' is not a valid version format")
}

# Make sure path is a real path
Try {
    $path = $path.TrimEnd("\")
    $path = (Get-item -LiteralPath $path).FullName
}
Catch {
    $module.FailJson("Cannot find file or directory: '$path' as it does not exist")
}

# Import Pester module if available
$Pester = 'Pester'

If (-not (Get-Module -Name $Pester -ErrorAction SilentlyContinue)) {
    If (Get-Module -Name $Pester -ListAvailable -ErrorAction SilentlyContinue) {
        Import-Module $Pester
    }
    else {
        $msg = -join @(
            "Cannot find module: $Pester. Check if pester is installed, and if it is not, "
            "install using win_psmodule or chocolatey.chocolatey.win_chocolatey."
        )
        $module.FailJson($msg)
    }
}

# Add actual pester's module version in the ansible's result variable
$Pester_version = (Get-Module -Name $Pester).Version.ToString()
$module.Result.pester_version = $Pester_version

# Test if the Pester module is available with a version greater or equal than the one specified in the $version parameter
If ((-not (Get-Module -Name $Pester -ErrorAction SilentlyContinue | Where-Object { $_.Version -ge $version })) -and ($version)) {
    $module.FailJson("$Pester version is not greater or equal to $version")
}

#Prepare Invoke-Pester parameters depending of the Pester's version.
#Invoke-Pester output deactivation behave differently depending on the Pester's version
$Configuration = @{ }
elseIf ($module.Result.pester_version -ge "4.0.0") {
    $Parameters = @{
        "show" = "none"
    }
}
else {
    $Parameters = @{
        "quiet" = $True
    }
}

$Configuration.Run.PassThru = $Parameters.PassThru = $True
$Configuration.Output.Verbosity = "None"

if ($tags.count) {
    $Configuration.Filter.Tag = $Parameters.Tag = $tags
}

if ($output_file) {
    $Configuration.TestResult.OutputPath = $Parameters.OutputFile = $output_file
    $Configuration.TestResult.OutputFormat = $Parameters.OutputFormat = $output_format
}

# Run Pester tests
If (Test-Path -LiteralPath $path -PathType Leaf) {
    $test_parameters_check_mode_msg = ''
    if ($test_parameters.keys.count) {
        $Parameters.Script = @{Path = $Path ; Parameters = $test_parameters }
        $test_parameters_check_mode_msg = " with $($test_parameters.keys -join ',') parameters"
    }
    else {
        $Parameters.Script = $Path
    }

    if ($module.CheckMode) {
        $module.Result.output = "Run pester test in the file: $path$test_parameters_check_mode_msg"
    }
}
else {
    $Parameters.Script = $path

    if ($module.CheckMode) {
        $module.Result.output = "Run Pester test(s): $path"
    }
}

$InvokeParams = $Parameters
if($module.Result.pester_version -ge "5.0.0"){
    #Use pester Advanced conffiguration object as legacy parameters will be deprecated/removed soon.
    $Configuration.Run.Path = $Path
    $InvokeParams = @{ Configuration = New-PesterConfiguration $Configuration }    
}

if(-not $module.CheckMode){
    $module.Result.output = Invoke-Pester @InvokeParams
    $module.Result.changed = $true
}


$module.ExitJson()
