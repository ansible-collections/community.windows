#!/usr/bin/python
# -*- coding: utf-8 -*-
# Copyright: (c) 2020 Sebastian Gruber ,dacoso GmbH All Rights Reserved.
# SPDX-License-Identifier: GPL-3.0-only
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

DOCUMENTATION = r'''
---
module: win_gpo_link
short_description: Link a GroupPolicy to a specific ActiveDirectory OU
description:
- The C(win_gpo_link) module can link GroupPolicy to a specific ActiveDirectory OU.
options:
state:
    description:
    - Specify State 
    type:str
    choices: [ present, absent, query ]
    required: yes
    default: present
path:
    description:
    - Specifies OU for GPO Link
    type:str
    required: yes
gponame:
    description:
    - used by module when creating,quering or removing GPO Link
    - Name of the  GPO
    type:str
    required: yes
enforced:
    description:
    - That the settings of the GPO always take precedence over conflicting settings in GPOs that are linked to lower-level containers.
    - That the settings of the GPO cannot be blocked (by blocking inheritance) at a lower-level Active Directory container.
    type:bool
    Default: no
linkenabled:
    description:
    - Disabling a GPO link does not disable the GPO itself
    type:bool
    Default: yes
order:
    description:
    - Specify the order number of specific GPO
    type:int
log_path:
    description:
    - Specify log file for Debug purposes
notes:
- This must be run on a host that has the GroupPolicy PowerShell module installed.
'''

EXAMPLES = r'''

- name: Create simple GroupPolicy Link
    win_gpo_link:
      state: present
      gponame: mysimpletest
      path: 'OU=Switzerland,OU=Lab Accounts,DC=intern,DC=systemuser,DC=de'

- name: Create GroupPolicy Link enforced
    win_gpo_link:
      state: present
      gponame: mysimpletestmysimpletestenforced
      path: 'OU=Switzerland,OU=Lab Accounts,DC=intern,DC=systemuser,DC=de'
      enforced: yes

- name: Delete GroupPolicy Link enforced
    win_gpo_link:
        state: absent
        gponame: test99
        path: 'OU=Switzerland,OU=Lab Accounts,DC=intern,DC=systemuser,DC=de'

'''