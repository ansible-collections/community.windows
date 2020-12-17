# Ansible Collection: community.windows

[![Build Status](https://dev.azure.com/ansible/community.windows/_apis/build/status/CI?branchName=main)](https://dev.azure.com/ansible/community.windows/_build/latest?definitionId=23&branchName=main)
[![codecov](https://codecov.io/gh/ansible-collections/community.windows/branch/main/graph/badge.svg)](https://codecov.io/gh/ansible-collections/community.windows)


The `community.windows` collection includes the community plugins supported by Ansible community to help the management of Windows hosts.

<!--start requires_ansible-->
## Ansible version compatibility

This collection has been tested against following Ansible versions: **>=2.10**.

Plugins and modules within a collection may be tested with only specific Ansible versions.
A collection may contain metadata that identifies these versions.
PEP440 is the schema used to describe the versions of Ansible.
<!--end requires_ansible-->


## Included content

<!--start collection content-->
### Lookup plugins
Name | Description
--- | ---
[community.windows.laps_password](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.laps_password_lookup.rst)|Retrieves the LAPS password for a server.

### Modules
Name | Description
--- | ---
[community.windows.psexec](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.psexec_module.rst)|Runs commands on a remote Windows host based on the PsExec model
[community.windows.win_audit_policy_system](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_audit_policy_system_module.rst)|Used to make changes to the system wide Audit Policy
[community.windows.win_audit_rule](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_audit_rule_module.rst)|Adds an audit rule to files, folders, or registry keys
[community.windows.win_auto_logon](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_auto_logon_module.rst)|Adds or Sets auto logon registry keys.
[community.windows.win_certificate_info](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_certificate_info_module.rst)|Get information on certificates from a Windows Certificate Store
[community.windows.win_computer_description](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_computer_description_module.rst)|Set windows description, owner and organization
[community.windows.win_credential](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_credential_module.rst)|Manages Windows Credentials in the Credential Manager
[community.windows.win_data_deduplication](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_data_deduplication_module.rst)|Module to enable Data Deduplication on a volume.
[community.windows.win_defrag](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_defrag_module.rst)|Consolidate fragmented files on local volumes
[community.windows.win_dhcp_lease](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_dhcp_lease_module.rst)|Manage Windows Server DHCP Leases
[community.windows.win_disk_facts](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_disk_facts_module.rst)|Show the attached disks and disk information of the target host
[community.windows.win_disk_image](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_disk_image_module.rst)|Manage ISO/VHD/VHDX mounts on Windows hosts
[community.windows.win_dns_record](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_dns_record_module.rst)|Manage Windows Server DNS records
[community.windows.win_dns_zone](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_dns_zone_module.rst)|Manage Windows Server DNS Zones
[community.windows.win_domain_computer](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_domain_computer_module.rst)|Manage computers in Active Directory
[community.windows.win_domain_group](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_domain_group_module.rst)|Creates, modifies or removes domain groups
[community.windows.win_domain_group_membership](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_domain_group_membership_module.rst)|Manage Windows domain group membership
[community.windows.win_domain_object_info](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_domain_object_info_module.rst)|Gather information an Active Directory object
[community.windows.win_domain_user](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_domain_user_module.rst)|Manages Windows Active Directory user accounts
[community.windows.win_dotnet_ngen](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_dotnet_ngen_module.rst)|Runs ngen to recompile DLLs after .NET  updates
[community.windows.win_eventlog](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_eventlog_module.rst)|Manage Windows event logs
[community.windows.win_eventlog_entry](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_eventlog_entry_module.rst)|Write entries to Windows event logs
[community.windows.win_file_compression](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_file_compression_module.rst)|Alters the compression of files and directories on NTFS partitions.
[community.windows.win_file_version](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_file_version_module.rst)|Get DLL or EXE file build version
[community.windows.win_firewall](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_firewall_module.rst)|Enable or disable the Windows Firewall
[community.windows.win_firewall_rule](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_firewall_rule_module.rst)|Windows firewall automation
[community.windows.win_format](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_format_module.rst)|Formats an existing volume or a new volume on an existing partition on Windows
[community.windows.win_hosts](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_hosts_module.rst)|Manages hosts file entries on Windows.
[community.windows.win_hotfix](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_hotfix_module.rst)|Install and uninstalls Windows hotfixes
[community.windows.win_http_proxy](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_http_proxy_module.rst)|Manages proxy settings for WinHTTP
[community.windows.win_iis_virtualdirectory](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_iis_virtualdirectory_module.rst)|Configures a virtual directory in IIS
[community.windows.win_iis_webapplication](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_iis_webapplication_module.rst)|Configures IIS web applications
[community.windows.win_iis_webapppool](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_iis_webapppool_module.rst)|Configure IIS Web Application Pools
[community.windows.win_iis_webbinding](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_iis_webbinding_module.rst)|Configures a IIS Web site binding
[community.windows.win_iis_website](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_iis_website_module.rst)|Configures a IIS Web site
[community.windows.win_inet_proxy](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_inet_proxy_module.rst)|Manages proxy settings for WinINet and Internet Explorer
[community.windows.win_initialize_disk](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_initialize_disk_module.rst)|Initializes disks on Windows Server
[community.windows.win_lineinfile](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_lineinfile_module.rst)|Ensure a particular line is in a file, or replace an existing line using a back-referenced regular expression
[community.windows.win_mapped_drive](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_mapped_drive_module.rst)|Map network drives for users
[community.windows.win_msg](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_msg_module.rst)|Sends a message to logged in users on Windows hosts
[community.windows.win_net_adapter_feature](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_net_adapter_feature_module.rst)|Enable or disable certain network adapters.
[community.windows.win_netbios](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_netbios_module.rst)|Manage NetBIOS over TCP/IP settings on Windows.
[community.windows.win_nssm](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_nssm_module.rst)|Install a service using NSSM
[community.windows.win_pagefile](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_pagefile_module.rst)|Query or change pagefile configuration
[community.windows.win_partition](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_partition_module.rst)|Creates, changes and removes partitions on Windows Server
[community.windows.win_pester](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_pester_module.rst)|Run Pester tests on Windows hosts
[community.windows.win_power_plan](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_power_plan_module.rst)|Changes the power plan of a Windows system
[community.windows.win_product_facts](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_product_facts_module.rst)|Provides Windows product and license information
[community.windows.win_psexec](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_psexec_module.rst)|Runs commands (remotely) as another (privileged) user
[community.windows.win_psmodule](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_psmodule_module.rst)|Adds or removes a Windows PowerShell module
[community.windows.win_psmodule_info](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_psmodule_info_module.rst)|Gather information about PowerShell Modules
[community.windows.win_psrepository](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_psrepository_module.rst)|Adds, removes or updates a Windows PowerShell repository.
[community.windows.win_psrepository_info](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_psrepository_info_module.rst)|Gather information about PSRepositories
[community.windows.win_psscript](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_psscript_module.rst)|Install and manage PowerShell scripts from a PSRepository
[community.windows.win_psscript_info](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_psscript_info_module.rst)|Gather information about installed PowerShell Scripts
[community.windows.win_pssession_configuration](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_pssession_configuration_module.rst)|Manage PSSession Configurations
[community.windows.win_rabbitmq_plugin](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_rabbitmq_plugin_module.rst)|Manage RabbitMQ plugins
[community.windows.win_rds_cap](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_rds_cap_module.rst)|Manage Connection Authorization Policies (CAP) on a Remote Desktop Gateway server
[community.windows.win_rds_rap](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_rds_rap_module.rst)|Manage Resource Authorization Policies (RAP) on a Remote Desktop Gateway server
[community.windows.win_rds_settings](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_rds_settings_module.rst)|Manage main settings of a Remote Desktop Gateway server
[community.windows.win_region](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_region_module.rst)|Set the region and format settings
[community.windows.win_regmerge](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_regmerge_module.rst)|Merges the contents of a registry file into the Windows registry
[community.windows.win_robocopy](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_robocopy_module.rst)|Synchronizes the contents of two directories using Robocopy
[community.windows.win_route](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_route_module.rst)|Add or remove a static route
[community.windows.win_say](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_say_module.rst)|Text to speech module for Windows to speak messages and optionally play sounds
[community.windows.win_scheduled_task](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_scheduled_task_module.rst)|Manage scheduled tasks
[community.windows.win_scheduled_task_stat](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_scheduled_task_stat_module.rst)|Get information about Windows Scheduled Tasks
[community.windows.win_scoop](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_scoop_module.rst)|Manage packages using Scoop
[community.windows.win_scoop_bucket](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_scoop_bucket_module.rst)|Manage Scoop buckets
[community.windows.win_security_policy](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_security_policy_module.rst)|Change local security policy settings
[community.windows.win_shortcut](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_shortcut_module.rst)|Manage shortcuts on Windows
[community.windows.win_snmp](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_snmp_module.rst)|Configures the Windows SNMP service
[community.windows.win_timezone](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_timezone_module.rst)|Sets Windows machine timezone
[community.windows.win_toast](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_toast_module.rst)|Sends Toast windows notification to logged in users on Windows 10 or later hosts
[community.windows.win_unzip](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_unzip_module.rst)|Unzips compressed files and archives on the Windows node
[community.windows.win_user_profile](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_user_profile_module.rst)|Manages the Windows user profiles.
[community.windows.win_wait_for_process](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_wait_for_process_module.rst)|Waits for a process to exist or not exist before continuing.
[community.windows.win_wakeonlan](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_wakeonlan_module.rst)|Send a magic Wake-on-LAN (WoL) broadcast packet
[community.windows.win_webpicmd](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_webpicmd_module.rst)|Installs packages using Web Platform Installer command-line
[community.windows.win_xml](https://github.com/ansible-collections/community.windows/blob/main/docs/community.windows.win_xml_module.rst)|Manages XML file content on Windows hosts

<!--end collection content-->


## Installation and Usage

### Installing the Collection from Ansible Galaxy

Before using the Windows collection, you need to install it with the `ansible-galaxy` CLI:

    ansible-galaxy collection install community.windows

You can also include it in a `requirements.yml` file and install it via `ansible-galaxy collection install -r requirements.yml` using the format:

```yaml
collections:
- name: community.windows
```


## Contributing to this collection

We welcome community contributions to this collection. If you find problems, please open an issue or create a PR against the [Community Windows collection repository](https://github.com/ansible-collections/community.windows). See [Contributing to Ansible-maintained collections](https://docs.ansible.com/ansible/devel/community/contributing_maintained_collections.html#contributing-maintained-collections) for details.

See [Developing modules for Windows](https://docs.ansible.com/ansible/latest/dev_guide/developing_modules_general_windows.html#developing-modules-general-windows) for specifics on Windows modules.

You can also join us on:

Freenode IRC - ``#ansible-windows`` Freenode channel

See the [Ansible Community Guide](https://docs.ansible.com/ansible/latest/community/index.html) for details on contributing to Ansible.


### Code of Conduct
This collection follows the Ansible project's
[Code of Conduct](https://docs.ansible.com/ansible/devel/community/code_of_conduct.html).
Please read and familiarize yourself with this document.

### Generating plugin docs

Currently module documentation is generated manually using
[add_docs.py](https://github.com/ansible-network/collection_prep/blob/master/add_docs.py). This should be run whenever
there are any major doc changes or additional plugins have been added to ensure a docpage is viewable online in this
repo. The following commands will run the doc generator and create the updated doc pages under [docs](docs).

```bash
# This is the path to the ansible.windows checkout
COLLECTION_PATH=~/ansible_collections/community/windows

cd /tmp
git clone https://github.com/ansible-network/collection_prep.git
cd collection_prep
python add_docs.py -p "${COLLECTION_PATH}"
```


### Testing with `ansible-test`

The `tests` directory contains configuration for running sanity and integration tests using [`ansible-test`](https://docs.ansible.com/ansible/latest/dev_guide/testing_integration.html).

You can run the collection's test suites with the commands:

    ansible-test sanity --docker
    ansible-test windows-integration --docker


## Publishing New Version

The current process for publishing new versions of the Windows Community Collection is manual, and requires a user who has access to the `community` namespace on Ansible Galaxy to publish the build artifact.

* Update `galaxy.yml` with the new version for the collection.
* Rebuild the plugin docs:
    ```bash
    git clone https://github.com/ansible-network/collection_prep.git /tmp/collection_prep
    pip install /tmp/collection_prep
    collection_prep_add_docs --path ./ --branch-name main
    rm -rf /tmp/collection_prep
    ```
* Update the `CHANGELOG`:
  * Make sure you have [`antsibull-changelog`](https://pypi.org/project/antsibull-changelog/) installed `pip install antsibull-changelog`.
  * Make sure there are fragments for all known changes in `changelogs/fragments`.
  * Add a new fragment with the header `release_summary` to give a summary on the release.
  * Run `antsibull-changelog release`.
* Commit the changes and wait for CI to be green
* Build and publish the collection to Galaxy:
    ```bash
    git clone https://github.com/ansible-collections/community.windows.git /tmp/community.windows
    ansible-galaxy collection build /tmp/community.windows --output-path /tmp/community.windows
    ansible-galaxy collection publish $(find /tmp/community.windows -maxdepth 1 -name 'community-windows-*.tar.gz') --token <API_KEY>

After the version is published, verify it exists on the [Windows Community Collection Galaxy page](https://galaxy.ansible.com/community/windows).


## More Information

For more information about Ansible's Windows integration, join the `#ansible-windows` channel on Freenode IRC, and browse the resources in the [Windows Working Group](https://github.com/ansible/community/wiki/Windows) Community wiki page.

- [Ansible Collection overview](https://github.com/ansible-collections/overview)
- [Ansible User guide](https://docs.ansible.com/ansible/latest/user_guide/index.html)
- [Ansible Developer guide](https://docs.ansible.com/ansible/latest/dev_guide/index.html)
- [Ansible Community code of conduct](https://docs.ansible.com/ansible/latest/community/code_of_conduct.html)


## License

GNU General Public License v3.0 or later

See [COPYING](COPYING) to see the full text.
