#!powershell

# Copyright: (c) 2022 VMware, Inc. All Rights Reserved.
# SPDX-License-Identifier: Internal

#AnsibleRequires -CSharpUtil Ansible.Basic

$spec = @{
    options = @{
        path = @{ type = "str"; default = 'MACHINE/WEBROOT/APPHOST' }
        mime_type = @{ type = "str" }
        extension = @{ type = "str" }
        }
}

$module = [Ansible.Basic.AnsibleModule]::Create($args, $spec)

$path = $module.Params.path
$mime_type = $module.Params.mime_type
$extension = $module.Params.extension

$default_parms = @{
    Name = 'Collection'
    Filter = '//staticContent'
    PSPath = $path
}

Function Get-MimeType {
    param($Object)
    $results = @()
    $Object | ForEach-Object {
        $results += @{
            extension          = $_.fileExtension
            mime_type          = $_.mimeType
            path               = $path
        }
    }
    return $results
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
If ($extension -and -not $extension.StartsWith('.')) {
    $extension = ".$extension"
}

# replace backslash if defined
If ($mime_type -and $mime_type.Contains('\')) {
    $mime_type = $mime_type.Replace('\','/')
}

if ($extension) {
    Try {
        $all = Get-WebConfigurationProperty @default_parms | Where-Object { $_.fileExtension -eq $extension }
        $module.Result.mimetypes = @(Get-MimeType -Object $all)
    } Catch {
        $module.FailJson("Failed to retrieve properties of extension: $($_.Exception.Message)", $_) }
}

if ($mime_type) {
    Try {
        $all = Get-WebConfigurationProperty @default_parms | Where-Object { $_.mimeType -eq $mime_type }
        $module.Result.mimetypes = @(Get-MimeType -Object $all)
    } Catch {
        $module.FailJson("Failed to retrieve properties of MIME type: $($_.Exception.Message)", $_) }
}

if (-not $extension -And -not $mime_type) {
    Try {
        $all = Get-WebConfigurationProperty @default_parms
        $module.Result.mimetypes = @(Get-MimeType -Object $all)
    } Catch {
        $module.FailJson("Failed to retrieve all MIME types: $($_.Exception.Message)", $_) }
}

$module.ExitJson()