#!/usr/bin/python
# -*- coding: utf-8 -*-

# Copyright: (c) 2026, Ansible Project
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

DOCUMENTATION = r"""
---
module: win_log_properties
short_description: Set the properties for an eventlog
description:
  - Set the properties for an eventlog, it is possible to configure if the log should be enabled,
  - the maximum log size and how the log should handle reaching the maximum size.
options:
  name:
    description:
      - The name of the eventlog to configure
    type: str
    required: true
  enabled:
    description:
      - Should the eventlog be enabled
    type: bool
  size:
    description:
      - Sets the max log size, must be larger than 1052672
    type: int
  mode:
    description:
      - Sets how eventlog handles log when it reaches size. This matches the setting in the eventlog
      - properties window and it affect two values, auto_backup and retention.
      - C(overwrite) overwrites oldest logs
      - C(archive) rotates logs and backups old logs
      - C(no_overwrite) logging stops when log is full
    type: str
    choices: [ overwrite, archive, no_overwrite ]
author:
  - Mikael Olofsson (@quiphius)
"""

EXAMPLES = r"""
- name: Enable PrintService Admin log, set size and archive full logs
  win_log_properties:
    name: Microsoft-Windows-PrintService/Admin
    enabled: true
    size: 10485760
    mode: archive

- name: Enable PrintService Operational log
  win_log_properties:
    name: Microsoft-Windows-PrintService/Operational
    enabled: true
"""

RETURN = r"""
"""
