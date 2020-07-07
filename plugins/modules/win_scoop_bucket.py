#!/usr/bin/python
# -*- coding: utf-8 -*-

# Copyright: (c) 2020, Jamie Magee <jamie.magee@gmail.com>
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

ANSIBLE_METADATA = {'metadata_version': '1.1',
                    'status': ['preview'],
                    'supported_by': 'community'}

DOCUMENTATION = r'''
---
module: win_scoop_bucket
short_description: Manage Scoop buckets
description:
- Manage Scoop buckets
- If Scoop is missing from the system, the module will install it.
requirements:
- git
options:
  name:
    description:
    - Name of the Scoop bucket.
    type: str
    required: yes
  repo:
    description:
    - Git repository that contains the scoop bucket
    type: str
  state:
    description:
    - State of the Scoop bucket.
    - When C(absent), will ensure the package is not installed.
    - When C(present), will ensure the package is installed.
    type: str
    choices: [ absent, present ]
    default: present
seealso:
- module: win_scoop
- name: Scoop website
  description: More information about Scoop
  link: https://scoop.sh
- name: Scoop directory
  description: A directory of buckets for the scoop package manager for Windows
  link: https://rasa.github.io/scoop-directory/
author:
- Jamie Magee (@JamieMagee)
'''

EXAMPLES = r'''
- name: Add the extras bucket
  win_scoop_bucket:
    name: extras

- name: Remove the versions bucket
  win_scoop_bucket:
    name: versions
    state: absent

- name: Add a custom bucket
  win_scoop_bucket:
    name: my-bucket
    repo: https://github.com/example/my-bucket
'''
