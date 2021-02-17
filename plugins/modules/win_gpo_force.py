#!/usr/bin/python
# -*- coding: utf-8 -*-
# Copyright: (c) 2021 Sebastian Gruber(@sgruber94) ,dacoso GmbH All Rights Reserved.
# SPDX-License-Identifier: GPL-3.0-only
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

DOCUMENTATION = r'''
---
module: win_gpo_force
short_description: Force GroupPolicy Updates on a specific Organizational Unit(ou)
description:
- The C(win_gpo_force) module can force GroupPolicy Updates on a specific Organizational Unit(ou).
- Update the sysvol Folder

author: Sebastian Gruber (@sgruber94)
options:
  mode:
    description:
      - Specify Mode for Update GPO
    choices:
      - forceupdate
      - sysvolonly
    required: yes
    default: sysvolonly
    type: str
  ou:
    description:
     - Required if l(mode=forceupdate)
     - used by module when ou a GroupPolicy
    type: str
    aliases:
      - organizational_unit 
notes:
  - This Module requires PowerShell Module GroupPolicy & Windows Feature RSAT-DFS-Mgmt-Con
'''

EXAMPLES = r'''
- name: Update sysvol folder on all server
  win_gpo_force:
      mode: forceupdate
      ou: "OU=Clients,OU=switzerland,DC=intern,DC=foo,DC=de"

- name: Update sysvol folder on all server
  win_gpo_force:
      mode: sysvolonly
'''

RETURN = r'''
#
'''