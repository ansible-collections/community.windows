#!/usr/bin/python
# -*- coding: utf-8 -*-

# Copyright: (c) 2015, Sam Liu <sam.liu@activenetwork.com>
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

DOCUMENTATION = r'''
---
module: win_file_version
short_description: Get DLL or EXE file build version
description:
  - Get DLL or EXE file build version.
notes:
  - This module will always return no change.
options:
  path:
    description:
      - File to get version.
      - Always provide absolute path.
    type: path
    required: yes
seealso:
- module: ansible.windows.win_file
author:
- Sam Liu (@SamLiu79)
'''

EXAMPLES = r'''
- name: Get acm instance version
  community.windows.win_file_version:
    path: C:\Windows\System32\cmd.exe
  register: exe_file_version

- debug:
    msg: '{{ exe_file_version }}'
'''

RETURN = r'''
changed:
    description: Whether anything was changed
    returned: always
    type: bool
    sample: true
win_file_version:
    description: dictionary containing all the version data
    returned: success
    type: complex
    contains:
        file_build_part:
          description: build number of the file.
          returned: no error
          type: str
        file_major_part:
          description: the major part of the version number.
          returned: no error
          type: str
        file_minor_part:
          description: the minor part of the version number of the file.
          returned: no error
          type: str
        file_private_part:
          description: file private part number.
          returned: no error
          type: str
        file_version:
          description: File version number..
          returned: no error
          type: str
        path:
          description: file path
          returned: always
          type: str
        product_version:
          description: The version of the product this file is distributed with.
          returned: no error
          type: str
          sample: "0.34.0+6fb2e41a0452b5e976c84c17722b6f8d91972cfd"
'''
