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
- .NET Framework 4.5 or later
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

'''
