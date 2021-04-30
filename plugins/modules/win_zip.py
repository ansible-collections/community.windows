#!/usr/bin/python
# -*- coding: utf-8 -*-

# Copyright: (c) 2021, Kento Yagisawa <thel.vadam2485@gmail.com>
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

DOCUMENTATION = r'''
---
module: win_zip
short_description: Compress file or directory as zip archive on the Windows node
description:
- Compress file or directory as zip archive.
- For non-Windows targets, use the M(ansible.builtin.archive) module instead.
requirements:
- PowerShell v5.0 or later
options:
  src:
    description:
      - File or directory path to be zipped (provide absolute path on the target node).
    type: path
    required: yes
  dest:
    description:
      - Destination path of zip file (provide absolute path of zip file on the target node).
    type: path
    required: yes
  overwrite:
    description:
      - If the zip file exists, the task will delete the old zip file then recreate it.
    type: bool
    default: false
notes:
- The maximum file size is 2GB because there's a limitation of the underlying API.
seealso:
- module: ansible.builtin.archive
author:
- Kento Yagisawa (@hiyoko_taisa)
'''

EXAMPLES = r'''
- name: Compress a file
  community.windows.win_zip:
    src: C:\Users\hiyoko\log.txt
    dest: C:\Users\hiyoko\log.zip

- name: Compress a directory
  community.windows.win_zip:
    src: C:\Users\hiyoko\log\
    dest: C:\Users\hiyoko\log.zip

- name: Recreate a zip file when the dest path already exists
  community.windows.win_zip:
    src: C:\Users\hiyoko\log.txt
    dest: C:\Users\hiyoko\log.zip
    overwrite: yes
'''

RETURN = r'''
dest:
    description: The provided destination path
    returned: always
    type: str
    sample: C:\Users\hiyoko\application-error-logs.zip
src:
    description: The provided source path
    returned: always
    type: str
    sample: C:\Users\hiyoko\application-error-logs\
'''
