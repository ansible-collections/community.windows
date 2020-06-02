#!/usr/bin/python
# -*- coding: utf-8 -*-

# Copyright: (c) 2020, Jamie Magee <jamie.magee@gmail.com>
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

ANSIBLE_METADATA = {'metadata_version': '1.1',
                    'status': ['preview'],
                    'supported_by': 'community'}

DOCUMENTATION = r'''
---
module: win_scoop
short_description: Manage packages using Scoop
description:
- Manage packages using Scoop.
- If Scoop is missing from the system, the module will install it.
options:
  arch:
    description:
    - Force Scoop to install the package of a specific process architecture.
    type: str
    choices: [ 32bit, 64bit ]
  global:
    description:
    - Install the app globally
    type: bool
    default: no
  independent:
    description:
    - Don't install dependencies automatically
    type: bool
    default: no
  name:
    description:
    - Name of the package(s) to be installed.
    type: list
    elements: str
    required: yes
  no_cache:
    description:
    - Don't use the download cache
    type: bool
    default: no
  purge:
    description:
    - Remove all persistent data
    type: bool
    default: no
  skip:
    description:
    - Skip hash validation
    type: bool
    default: no
  state:
    description:
    - State of the package on the system.
    - When C(absent), will ensure the package is not installed.
    - When C(present), will ensure the package is installed.
    type: str
    choices: [ absent, present ]
    default: present
seealso:
- module: win_chocolatey
- name: Scoop website
  description: More information about Scoop
  link: https://scoop.sh
- name: Scoop installer repository
  description: GitHub repository for the Scoop installer
  link: https://github.com/lukesampson/scoop
- name: Scoop main bucket
  description: GitHub repository for the main bucket
  link: https://github.com/ScoopInstaller/Main
author:
- Jamie Magee (@JamieMagee)
'''

EXAMPLES = r'''
- name: Install jq.
  win_scoop:
    name: jq
'''