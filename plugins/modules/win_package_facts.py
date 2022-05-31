#!/usr/bin/python
# -*- coding: utf-8 -*-

# Copyright: (c) 2022, DataDope (@datadope-io)
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

DOCUMENTATION = r'''
---
module: win_package_facts
version_added: '1.11.0'
short_description: Gather the facts of the packages of the machine
description:
    - Gather the information of the packages of the machine.
    - Supports x32 and x64 systems.
    - The module goal is to replicate the functionality of the linux module
      package_facts, maintaining the format of the said module.
options:
  gather_current_user:
    description:
      - Establish if the current user packages should be gathered, in addition to
        the system-wide packages.
    type: bool
    default: true
  gather_external_users:
    description:
      - Establish if the other users packages should be gathered, in addition to
        the system-wide packages. This option mounts other users registries if they
        are not logged in, so it should be used with care, since it could have impact
        on the system. Also, this option requires the user to be an administrator.
    type: bool
    default: false
notes:
- The external users registries are unmounted after the information is gathered.
- The value of each key of packages is a list of dicts, since multiple versions of the
  same package can be installed while maintaining the name of the package.
- The generated data (packages) and the fields within follows the package_facts schema
  to achieve compatibility with the said module output, even though this module is
  capable of extracting additional information about the system packages.
seealso:
- module: ansible.builtin.package_facts
author:
- David Nieto (@david-ns)
'''

EXAMPLES = r'''
- name: Gather system packages facts
  community.windows.win_package_facts:

- name: Gather system and current user packages facts
  community.windows.win_package_facts:
    gather_current_user: true

- name: Gather system and external users packages facts
  community.windows.win_package_facts:
    gather_external_users: true

- name: Gather system, current user and external users packages facts
  community.windows.win_package_facts:
    gather_current_user: true
    gather_external_users: true
'''

RETURN = r'''
packages:
    description: List of dicts with the detected packages
    returned: success
    type: list
    elements: dict
    sample: [
        {
            "psqlODBC 13.00.0000": [
                {
                    "arch": "AMD64",
                    "authorized_cdf_prefix": null,
                    "comments": "ODBC drivers for PostgreSQL, packaged by EnterpriseDB",
                    "contact": "",
                    "estimated_size": 13676,
                    "help_link": "",
                    "help_telephone": null,
                    "install_date": "20220215",
                    "install_location": "C:\\Program Files\\PostgreSQL\\psqlODBC",
                    "install_source": null,
                    "language": null,
                    "modify_path": null,
                    "name": "psqlODBC 13.00.0000",
                    "no_repair": "1",
                    "publisher": "EnterpriseDB",
                    "readme": null,
                    "size": null,
                    "source": "windows_registry",
                    "system_component": null,
                    "uninstall_string": "\"C:\\Program Files\\PostgreSQL\\psqlODBC\\uninstall-psqlodbc.exe\"",
                    "url_info_about": "",
                    "url_update_info": null,
                    "vendor": null,
                    "version": "13.00.0000-2",
                    "version_major": 13,
                    "version_minor": 0,
                    "windows_installer": null
                }
            ]
        }
    ]
'''
