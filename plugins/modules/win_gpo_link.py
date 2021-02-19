#!/usr/bin/python
# -*- coding: utf-8 -*-
# Copyright: (c) 2021 Sebastian Gruber ,dacoso GmbH All Rights Reserved.
# SPDX-License-Identifier: GPL-3.0-only
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

DOCUMENTATION = r'''
---
module: win_gpo_link
author: Sebastian Gruber (@sgruber94)
short_description: Link a GroupPolicy to a specific ActiveDirectory OU
description:
- The C(win_gpo_link) module can link GroupPolicy to a specific ActiveDirectory OU.
requirements:
  - PowerShell Module GroupPolicy (https://docs.microsoft.com/en-us/powershell/module/grouppolicy)
  - PowerShell Module activedirectory (https://docs.microsoft.com/en-us/powershell/module/activedirectory)
seealso:
  - module: community.windows.win_gpo_force
  - module: community.windows.win_gpo_manage
notes:
  - This must be run on a host that has the GroupPolicy PowerShell module installed.
options:
  state:
    description:
      - Specify State
    type: str
    choices:
      - present
      - absent
      - query
    default: present
  path:
    description:
      - Specifies OU for GPO Link
    elements: str
    type: list
    required: yes
  gponame:
    description:
      - used by module when creating,quering or removing GPO Link
      - Name of the GPO
    type: str
    required: yes
  enforced:
    description:
      - That the settings of the GPO always take precedence over conflicting settings in GPOs that are linked to lower-level containers.
      - That the settings of the GPO cannot be blocked (by blocking inheritance) at a lower-level Active Directory container.
    type: bool
    default: no
  linkenabled:
    description:
      - Disabling a GPO link does not disable the GPO itself
    type: bool
    default: yes
  order:
    description:
      - Specify the order number of specific GPO
    type: int
  domain:
    description:
      - Specify the GPO domain
    type: str
'''

EXAMPLES = r'''

- name: Create simple GroupPolicy Link
  community.windows.win_gpo_link:
    state: present
    gponame: mysimpletest
    path: 'OU=Switzerland,OU=Lab Accounts,DC=intern,DC=example,DC=de'

- name: Create GroupPolicy Link enforced
  community.windows.win_gpo_link:
    state: present
    gponame: mysimpletestmysimpletestenforced
    path: 'OU=Switzerland,OU=Lab Accounts,DC=intern,DC=example,DC=de'
    enforced: yes

- name: Delete GroupPolicy Link enforced
  community.windows.win_gpo_link:
    state: absent
    gponame: test99
    path: 'OU=Switzerland,OU=Lab Accounts,DC=intern,DC=example,DC=de'

'''