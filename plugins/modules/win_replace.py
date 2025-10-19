#!/usr/bin/python
# -*- coding: utf-8 -*-

# Copyright: 2025, Mish Goldenberg (@mishgoldenberg) <golden.mihel@gmail.com>
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

DOCUMENTATION = r'''
---
author:
  - Mish Goldenberg (@mishgoldenberg)
module: win_replace
short_description: Replace text in a Windows file
description:
  - Replaces all occurrences of a regular expression in a text file on Windows.
options:
  path:
    description:
      - Path to the file.
    required: true
    type: str
  regexp:
    description:
      - Regular expression to match.
    required: true
    type: str
  replace:
    description:
      - Replacement text.
    type: str
    default: ''
  backup:
    description:
      - Create backup before modifying the file.
    type: bool
    default: false
'''

EXAMPLES = r'''
- name: Replace text in a file
  community.windows.win_replace:
    path: C:\Temp\file.txt
    regexp: 'foo'
    replace: 'bar'
'''

RETURN = r'''
path:
    description: Path of the file modified
    type: str
    returned: always
changed:
    description: Whether the file was changed
    type: bool
    returned: always
backup_file:
    description: Path to backup file if backup is true
    type: str
    returned: when backup is true
msg:
    description: Result message
    type: str
    returned: always
'''
