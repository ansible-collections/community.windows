#!/usr/bin/python
# -*- coding: utf-8 -*-

# Copyright: (c) 2020, Jamie Magee <jamie.magee@gmail.com>
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

DOCUMENTATION = r'''
---
module: win_winget
short_description: Manage packages using winget
description:
- Manage packages using winget.
- If winget is missing from the system, the module will install it.
options:
  name:
    description:
    - Name of the package to be installed (case sensitive).
    type: str
    required: yes
  state:
    description:
    - State of the package on the system.
    - When C(absent), will ensure the package is not installed.
    - When C(present), will ensure the package is installed.
    type: str
    choices: [ absent, present ]
    default: present
seealso:
- module: chocolatey.chocolatey.win_chocolatey
- name: winget documentation
  description: More information about winget
  link: https://docs.microsoft.com/en-us/windows/package-manager/winget/
- name: Winget CLI repository
  description: GitHub repository for the winget cli
  link: https://github.com/microsoft/winget-cli
- name: Winget manifest repository
  description: GitHub repository for the winget manifests
  link: https://github.com/microsoft/winget-pkgs
author:
- Jamie Magee (@JamieMagee)
'''

EXAMPLES = r'''
- name: Install git
  community.windows.win_winget:
    name: Git.Git
'''
