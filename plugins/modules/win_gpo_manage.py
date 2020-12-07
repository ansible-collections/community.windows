#!/usr/bin/python
# -*- coding: utf-8 -*-
# Copyright: (c) 2020 Sebastian Gruber ,dacoso GmbH All Rights Reserved.
# SPDX-License-Identifier: GPL-3.0-only
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

DOCUMENTATION = r'''
---
module: win_gpo_manage
short_description: Imports,Export,Removes Group Policy on windows hosts
author: Sebastian Gruber (@sgruber94)
description:
- The C(win_gpo_manage) module can manage GroupPolicys on the windows host.
options:
mode:
    description:
    -  When l(type=import), GroupPolicy will be imported from a specific Folder
    -  When l(type=export), GroupPolicy will be exported from to a specific Folder
    -  When l(type=query), GroupPolicy will be query
    -  When l(type=remove), specific GroupPolicy will be removed
    type:str
    choices: [ import, export, query, remove ]
    required: yes
    default: import
folder:
    description:
    - Required if l(type=import) or l(type=export)
    - Specify Folder to Import or Export GroupPolicy
    type: path
    default: C:\GPO
name:
    description:
    - Required if l(type=remove)
    - Specify Name of GroupPolicies that should be deleted
    type:list
override:
    description:
    - if override is set to yes, in mode import all Policy will be overriden
    - if override is set to yes , in mode export, all Policy that are duplicates will be deleted and with the new export replaced
    type: bool
    default: false
log_path:
    description:
    - Specify log file for Debug purposes
    type: str
notes:
- This must be run on a host that has the GroupPolicy PowerShell module installed.
'''

EXAMPLES = r'''
- name: Import GroupPolicys from a Folder
    win_gpo_manage:
      mode: import
      folder: C:\gpo

- name: Export all GroupPolicys to a Folder
    win_gpo_manage:
      mode: export
      folder: C:\gpoexport

- name: Delete specific GroupPolicy
    win_gpo_manage:
      mode: remove
      name: "GPO-1","GPO-2"

- name: Query specific GroupPolicy
    win_gpo_manage:
      mode: query

'''