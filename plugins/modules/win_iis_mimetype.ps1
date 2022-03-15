#!powershell

# Copyright: (c) 2022 VMware, Inc. All Rights Reserved.
# SPDX-License-Identifier: Internal

#AnsibleRequires -CSharpUtil Ansible.Basic

$spec = @{
    options = @{
        state = @{ type = "str"; default = 'present'; choices = @('present','absent') }
        path = @{ type = "str"; default = 'MACHINE/WEBROOT/APPHOST' }
        mime_type = @{ type = "str"; required = $false }
        extension = @{ type = "str"; required = $true }
        }
    supports_check_mode = $false
}

$module = [Ansible.Basic.AnsibleModule]::Create($args, $spec)

$state = $module.Params.state
$path = $module.Params.path
$mime_type = $module.Params.mime_type
$extension = $module.Params.extension

$default_parms = @{
    Name = 'Collection'
    Filter = '//staticContent'
    PSPath = $path
}

# try to load WebAdministration Module
Try { Import-Module WebAdministration }
Catch { $module.FailJson("Failed to load WebAdministration module: $($_.Exception.Message)", $_) }

# validate user params
# test if site exists
If ($path -ne ('MACHINE/WEBROOT/APPHOST')) {
    $siteArray = ($module.Params.path).Split("\")
    $site = ($siteArray[$siteArray.Count -1])
    $site_check = Get-Website | Where-Object { $_.Name -like $site }
        If (-not $site_check) {
            $module.FailJson("Unable to retrieve website with name $site. $($_.Exception.Message)", $_)
        }
    }
# append dot before extension if missing
If (-not $extension.StartsWith('.')) {
    $extension = ".$extension"
}

# replace backslash if defined
If ($mime_type -and $mime_type.Contains('\')) {
    $mime_type = $mime_type.Replace('\','/')
}

# try to determine if MIME Type extension exists
Try { $extStatus = Get-WebConfigurationProperty @default_parms | Where-Object { $_.fileExtension -eq $extension } }
Catch { $module.FailJson("Failed to determine current state: $($_.Exception.Message)", $_) }

# try to add MIME Type when extension does not exist
If ($state -eq "present") {
    # If fileExtension does not exist
    If (-not $extStatus.fileExtension) {
        Try {
            Add-WebConfigurationProperty @default_parms -Value @{ fileExtension = "$extension" ; mimeType = "$mime_type" }
            $module.Result.changed = $true
        } Catch {
            $module.FailJson("Failed to add MIME type: $($_.Exception.Message)", $_)
        }
    }

# try to set existing MIME Type
    If ($extStatus.mimeType -ne $mime_type) {
        Try {
            Set-WebConfigurationProperty -PSPath $path -Filter "//staticContent/mimeMap[ @fileExtension = '$extension' ]" -Name "mimeType" -Value "$mime_type"
            $module.Result.changed = $true
        } Catch {
            $module.FailJson("Failed to change MIME type: $($_.Exception.Message)", $_)
        }
    }
}

# try to remove MIME Type
If ($extStatus.fileExtension -and $state -eq "absent") {
    Try {
        Remove-WebConfigurationProperty  @default_parms -AtElement @{ fileExtension = "$extension" }
        $module.Result.changed = $true
    } Catch {
        $module.FailJson("Failed to remove MIME type extension: $($_.Exception.Message)", $_)
    }
}

$module.ExitJson()