#!/usr/bin/python
# -*- coding: utf-8 -*-
# Copyright: (c) 2021 Sebastian Gruber ,dacoso GmbH All Rights Reserved.
# SPDX-License-Identifier: GPL-3.0-only
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

DOCUMENTATION = r'''
---
module: win_gpo_manage
short_description: Imports,Export,Removes Group Policy on windows hosts
author: Sebastian Gruber (@sgruber94)
description:
  - The C(win_gpo_manage) module can manage GroupPolicys on the windows host.
requirements:
  - PowerShell Module GroupPolicy (https://docs.microsoft.com/en-us/powershell/module/grouppolicy)
seealso:
  - module: community.windows.win_gpo_force
  - module: community.windows.win_gpo_link
options:
  mode:
    description:
      - When l(type=import), GroupPolicy will be imported from a specific Folder
      - When l(type=export), GroupPolicy will be exported from to a specific Folder
      - When l(type=query), GroupPolicy will be query
      - When l(type=remove), is set then I(name) must also be set. Deletes GPO
    type: str
    choices:
      - import
      - export
      - query
      - remove
    required: yes
  folder:
    description:
      - Required if l(type=import) or l(type=export)
      - Specify Folder to Import or Export GroupPolicy
    type: path
    default: C:\GPO
  name:
    description:
      - Required if l(type=remove) is set.
      - Specify Name of GroupPolicies that should be deleted
    elements: str
    type: list
  override:
    description:
      - if override is set to yes, in mode import all Policy will be overriden
      - if override is set to yes , in mode export, all Policy that are duplicates will be deleted and with the new export replaced
    type: bool
    default: no
'''

EXAMPLES = r'''
- name: Import GroupPolicys from a Folder
  community.windows.win_gpo_manage:
    mode: import
    folder: C:\gpo

- name: Export all GroupPolicys to a Folder
  community.windows.win_gpo_manage:
    mode: export
    folder: C:\gpoexport

- name: Delete specific GroupPolicy
  community.windows.win_gpo_manage:
    mode: remove
    name: '"GPO-1","GPO-2"'

- name: Query specific GroupPolicy
  community.windows.win_gpo_manage:
    mode: query

'''

RETURN = r'''
query_result:
    description: Object of all GPOs in the system
    returned: always
    type: dict
'''
