#!powershell

# Copyright: (c) 2022, DataDope (@datadope-io)
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

#AnsibleRequires -CSharpUtil Ansible.Basic

$spec = @{
    options = @{
        gather_current_user = @{ type = 'bool'; default = $true }
        gather_external_users = @{ type = 'bool'; default = $false }
    }
    supports_check_mode = $true
}

$module = [Ansible.Basic.AnsibleModule]::Create($args, $spec)

$gather_current_user = $module.Params.gather_current_user
$gather_external_users = $module.Params.gather_external_users

# Structure of the response the script will return
$ansibleFacts = @{
    packages = @{}
}

# Check if the current system is 64-bit or 32-bit
$is64Bit = [System.Environment]::Is64BitOperatingSystem

# Build the list of registry paths to check based on the OS architecture
if ($is64Bit) {
    $software_paths = @{
        x86 = "SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
        AMD64 = "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*"
    }
}
else {
    $software_paths = @{
        x86 = "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*"
    }
}

function Get-RegistryPathPackage {
    param(
        [String]$base_path
    )

    $packages = @()

    $software_paths.GetEnumerator() | ForEach-Object {
        $arch = $_.Name
        $arch_path = $_.Value
        Get-ItemProperty -Path "$base_path\$arch_path" | ForEach-Object {
            $_ | Add-Member -NotePropertyName Architecture -NotePropertyValue $arch
            $packages += $_
        }
    }

    return $packages
}

function Get-InstalledPackage {
    # Acknowledge if the current user is an Administrator
    $current_user = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    $privileged_run = $current_user.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

    # Empty array to store packages
    $packages = @()

    # Gather global software
    $packages += Get-RegistryPathPackage("Registry::HKEY_LOCAL_MACHINE")

    # Gather current user software
    if ($gather_current_user) {
        $packages += Get-RegistryPathPackage("Registry::\HKEY_CURRENT_USER")
    }

    # Gather external users software
    if ($gather_external_users) {
        if ($privileged_run) {
            # Dynamic registry mount from https://xkln.net/blog/please-stop-using-win32product-to-find-installed-software-alternatives-inside/
            $AllProfiles = Get-CimInstance Win32_UserProfile | Select-Object LocalPath, SID, Loaded, Special | Where-Object { $_.SID -like "S-1-5-21-*" }
            $MountedProfiles = $AllProfiles | Where-Object { $_.Loaded -eq $true }
            $UnmountedProfiles = $AllProfiles | Where-Object { $_.Loaded -eq $false }

            # Process mounted registries
            $MountedProfiles | ForEach-Object {
                $packages += Get-RegistryPathPackage("Registry::\HKEY_USERS\$($_.SID)")
            }

            # Process unmounted registries
            $UnmountedProfiles | ForEach-Object {
                $Hive = "$($_.LocalPath)\NTUSER.DAT"
                if (Test-Path $Hive) {
                    # Mount the registry
                    REG LOAD HKU\temp $Hive

                    $packages += Get-RegistryPathPackage("Registry::\HKEY_USERS\temp")

                    # Run manual GC to allow hive to be unmounted
                    [GC]::Collect()
                    [GC]::WaitForPendingFinalizers()

                    # Unmount the registry
                    REG UNLOAD HKU\temp

                }
                else {
                    $module.warn("Unable to access registry hive at: %s" % ($Hive))
                }
            }
        }
        else {
            $module.warn("Unable to gather external users as the current user is not an Administrator")
        }
    }

    return $packages
}

try {
    # Gather the packages excluding unnecessary powershell attributes
    Get-InstalledPackage | Select-Object -Property * -ExcludeProperty PSPath, PSParentPath, PSChildName, PSDrive, PSProvider | ForEach-Object {
        # Ignore packages without DisplayName
        if ($null -ne $_.DisplayName) {
            # Add DisplayName as key so multiple versions of the same package can be grouped (following ansible.builtin.package_facts schema)
            if (!$ansibleFacts.packages.ContainsKey($_.DisplayName)) {
                $ansibleFacts.packages.Add($_.DisplayName, @())
            }
            # display_name is renamed to name so the ansible.builtin.package_facts schema is followed
            # Version is replaced with DisplayVersion in the field version, since DisplayVersion is more consistent with VersionMajor, VersionMinor,
            # and Version is a product of both, but less legible than DisplayVersion (also, Version is not always present and is inconsistent with
            # the ansible.builtin.package_facts version field format)
            # Further information about the Version field composition can be found here:
            # https://stackoverflow.com/questions/10752450/convert-version-number-in-registry-to-system-version/30607120#30607120
            $ansibleFacts.packages[$_.DisplayName] += @{
                arch = $_.Architecture
                authorized_cdf_prefix = $_.AuthorizedCDFPrefix
                comments = $_.Comments
                contact = $_.Contact
                estimated_size = $_.EstimatedSize
                help_link = $_.HelpLink
                help_telephone = $_.HelpTelephone
                install_date = $_.InstallDate
                install_location = $_.InstallLocation
                install_source = $_.InstallSource
                language = $_.Language
                modify_path = $_.ModifyPath
                name = $_.DisplayName
                no_repair = $_.NoRepair
                publisher = $_.Publisher
                readme = $_.Readme
                size = $_.Size
                source = 'windows_registry'
                system_component = $_.SystemComponent
                uninstall_string = $_.UninstallString
                url_info_about = $_.URLInfoAbout
                url_update_info = $_.URLUpdateInfo
                vendor = $_.Vendor
                version = $_.DisplayVersion
                version_major = $_.VersionMajor
                version_minor = $_.VersionMinor
                windows_installer = $_.WindowsInstaller
            }
        }
    }
}
catch {
    $module.FailJson("An error occurred while retrieving package facts: $($_.Exception.Message)", $_)
}

$module.Result.ansible_facts = $ansibleFacts
$module.ExitJson()
