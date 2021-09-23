===============================
Community Windows Release Notes
===============================

.. contents:: Topics


v1.7.0
======

Minor Changes
-------------

- win_domain_user - Added ``sam_account_name`` to explicitly set the ``sAMAccountName`` property of an object - https://github.com/ansible-collections/community.windows/issues/281

Bugfixes
--------

- win_dns_record - Fix issue when trying to use the ``computer_name`` option - https://github.com/ansible-collections/community.windows/issues/276
- win_domain_user - Fallback to NETBIOS username for password verification check if the UPN is not set - https://github.com/ansible-collections/community.windows/pull/289
- win_initialize_disk - Ensure ``online: False`` doesn't bring the disk online again - https://github.com/ansible-collections/community.windows/pull/268
- win_lineinfile - Fix up diff output with ending newlines - https://github.com/ansible-collections/community.windows/pull/283
- win_region - Fix ``copy_settings`` on a host that has disabled ``reg.exe`` access - https://github.com/ansible-collections/community.windows/issues/287

v1.6.0
======

Minor Changes
-------------

- win_dns_record - Added txt Support
- win_scheduled_task - Added support for setting a ``session_state_change`` trigger by documenting the human friendly values for ``state_change``
- win_scheduled_task_state - Added ``state_change_str`` to the trigger output to give a human readable description of the value

Security Fixes
--------------

- win_psexec - Ensure password is masked in ``psexec_command`` return result - https://github.com/ansible-collections/community.windows/issues/43

v1.5.0
======

Bugfixes
--------

- win_dns_zone - Fix idempotency when using a DNS zone with forwarders - https://github.com/ansible-collections/community.windows/issues/259
- win_domain_group_member - Fix faulty logic when comparing existing group members - https://github.com/ansible-collections/community.windows/issues/256
- win_lineinfile - Avoid stripping the newline at the end of a file - https://github.com/ansible-collections/community.windows/pull/219
- win_product_facts - fixed an issue that the module doesn't correctly convert a product id (https://github.com/ansible-collections/community.windows/pull/251).

v1.4.0
======

Bugfixes
--------

- win_domain_group_membership - Handle timeouts when dealing with group with lots of members - https://github.com/ansible-collections/community.windows/pull/204
- win_domain_user - Make sure a password is set to change when it is marked as password needs to be changed before logging in - https://github.com/ansible-collections/community.windows/issues/223
- win_domain_user - fix reporting on user when running in check mode - https://github.com/ansible-collections/community.windows/pull/248
- win_lineinfile - Fix crash when using ``insertbefore`` and ``insertafter`` at the same time - https://github.com/ansible-collections/community.windows/issues/220
- win_partition - Fix gtp_type setting in win_partition - https://github.com/ansible-collections/community.windows/issues/241
- win_psmodule - Makes sure ``-AllowClobber`` is used when updating pre-requisites if requested - https://github.com/ansible-collections/community.windows/issues/42
- win_pssession_configuration - the ``async_poll`` option was not actually used and polling mode was always used with the default poll delay; this change also formally disables ``async_poll=0`` (https://github.com/ansible-collections/community.windows/pull/212).
- win_wait_for_process - Fix bug when specifying multiple ``process_name_exact`` values - https://github.com/ansible-collections/community.windows/issues/203

New Modules
-----------

- win_feature_info - Gather information about Windows features

v1.3.0
======

Minor Changes
-------------

- Extend win_domain_computer adding managedBy parameter.

Bugfixes
--------

- win_firewall_rule - Ensure ``service: any`` is set to match any service instead of the literal service called ``any`` as per the docs
- win_scoop - Make sure we enable TLS 1.2 when installing scoop
- win_xml - Fix ``PropertyNotFound`` exception when creating a new attribute - https://github.com/ansible-collections/community.windows/issues/166

New Modules
-----------

- win_psrepository_copy - Copies registered PSRepositories to other user profiles

v1.2.0
======

Minor Changes
-------------

- win_nssm - added new parameter 'app_environment' for managing service environment.
- win_scheduled_task - validate task name against invalid characters (https://github.com/ansible-collections/community.windows/pull/168)
- win_scheduled_task_stat - add check mode support (https://github.com/ansible-collections/community.windows/pull/167)

Bugfixes
--------

- win_partition - fix size comparison errors when size specified in bytes (https://github.com/ansible-collections/community.windows/pull/159)
- win_security_policy - read config file with correct encoding to avoid breaking non-ASCII chars
- win_security_policy - strip of null char added by secedit for ``LegalNoticeText`` so the existing value is preserved

New Modules
-----------

- win_net_adapter_feature - Enable or disable certain network adapters.

v1.1.0
======

Minor Changes
-------------

- win_dns_record - Support NS record creation,modification and deletion
- win_firewall - Support defining the default inbound and outbound action of traffic in Windows firewall.
- win_psrepository - Added the ``proxy`` option that defines the proxy to use for the repository being managed

v1.0.0
======

Minor Changes
-------------

- win_dns_record - Added support for managing ``SRV`` records
- win_firewall_rule - Support editing rules by the group it belongs to
- win_firewall_rule - Support editing rules that have a duplicated name

Breaking Changes / Porting Guide
--------------------------------

- win_pester - no longer runs all ``*.ps1`` file in the directory specified due to it executing potentially unknown scripts. It will follow the default behaviour of only running tests for files that are like ``*.tests.ps1`` which is built into Pester itself.

Removed Features (previously deprecated)
----------------------------------------

- win_psexec - removed the deprecated ``extra_opts`` option.

Bugfixes
--------

- win_scoop - add checks for globally installed packages for better idempotency checks

New Modules
-----------

- win_scoop_bucket - Manage Scoop buckets

v0.2.0
======

Release Summary
---------------

This is the first proper release of the ``community.windows`` collection on 2020-07-18.
The changelog describes all changes made to the modules and plugins included in this collection since Ansible 2.9.0.


Minor Changes
-------------

- win_disk_facts - Set output array order to be by disk number property - https://github.com/ansible/ansible/issues/63998
- win_domain_computer - ``sam_account_name`` with missing ``$`` will have it added automatically (https://github.com/ansible-collections/community.windows/pull/93)
- win_domain_computer - add support for offline domain join (https://github.com/ansible-collections/community.windows/pull/93)
- win_domain_group_membership - Add multi-domain forest support - https://github.com/ansible/ansible/issues/59829
- win_domain_user - Added the ``identity`` module option to explicitly set the identity of the user when searching for it - https://github.com/ansible/ansible/issues/45298
- win_firewall- Change req check from wmf version to cmdlets presence - https://github.com/ansible/ansible/issues/63003
- win_firewall_rule - add parameter to support ICMP Types and Codes (https://github.com/ansible/ansible/issues/46809)
- win_iis_webapplication - add new options ``connect_as``, ``username``, ``password``.
- win_iis_webapplication - now uses the current application pool of the website instead of the DefaultAppPool if none was specified.
- win_nssm - Implement additional parameters - (https://github.com/ansible/ansible/issues/62620)
- win_pester - Only execute ``*.tests.ps1`` in ``path`` to match the default behaviour in Pester - https://github.com/ansible/ansible/issues/55736

Removed Features (previously deprecated)
----------------------------------------

- win_disk_image - removed the deprecated return value ``mount_path`` in favour of ``mount_paths``.

Bugfixes
--------

- **security issue** win_unzip - normalize paths in archive to ensure extracted files do not escape from the target directory (CVE-2020-1737)
- psexec - Fix issue where the Kerberos package was not detected as being available.
- psexec - Fix issue where the ``interactive`` option was not being passed down to the library.
- win_credential - Fix issue that errors when trying to add a ``name`` with wildcards.
- win_domain_computer - Fix idempotence checks when ``sAMAccountName`` is different from ``name``
- win_domain_computer - Honour the explicit domain server and credentials when moving or removing a computer object - https://github.com/ansible/ansible/pull/63093
- win_domain_user - Better handle cases when getting a new user's groups fail - https://github.com/ansible/ansible/issues/54331
- win_format - Idem not working if file exist but same fs (https://github.com/ansible/ansible/issues/58302)
- win_format - fixed issue where module would not change allocation unit size (https://github.com/ansible/ansible/issues/56961)
- win_iis_webapppool - Do not try and set attributes in check mode when the pool did not exist
- win_iis_website - Actually restart the site when ``state=restarted`` - https://github.com/ansible/ansible/issues/63828
- win_partition - Fix invalid variable name causing a failure on checks - https://github.com/ansible/ansible/issues/62401
- win_partition - don't resize partitions if size difference is < 1 MiB
- win_timezone - Allow for _dstoff timezones
- win_unzip - Fix support for paths with square brackets not being detected properly
