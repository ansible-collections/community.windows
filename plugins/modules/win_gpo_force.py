#!/usr/bin/python
# -*- coding: utf-8 -*-
# Copyright: (c) 2020 Sebastian Gruber ,dacoso GmbH All Rights Reserved.
# SPDX-License-Identifier: GPL-3.0-only
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

DOCUMENTATION = r'''
---
module: win_gpo_force
short_description: Force GroupPolicy Updates on a specific Organizational Unit(ou)
author: Sebastian Gruber (@sgruber94)
description:
- The C(win_gpo_force) module can force GroupPolicy Updates on a specific Organizational Unit(ou).
- Update the sysvol Folder
options:
mode:
    description:
    - Specify Mode for update
    type:str
    choices: [ forceupdate, sysvolonly ]
    required: yes
    default: sysvolonly
ou:
    description:
    - Required if l(mode=forceupdate)
    - used by module when ou a GroupPolicy
    type:list
log_path:
    description:
    - Specify log file for debug purposes
notes:
- This must be run on a host that has the GroupPolicy PowerShell module installed.
'''

EXAMPLES = r'''

- name: Update sysvol folder on all server
    win_gpo_force:
      mode: forceupdate
      ou: "OU=Clients,OU=switzerland,DC=intern,DC=systemuser,DC=de"

- name: Update sysvol folder on all server
    win_gpo_force:
      mode: sysvolonly

'''