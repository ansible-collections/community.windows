#!/usr/bin/python
# -*- coding: utf-8 -*-

# Copyright: (c) 2022, Oleg Galushko (@inorangestylee)
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

DOCUMENTATION = r'''
---
module: win_pending_reboot_info
short_description: Gather information about pending reboot state
version_added: '1.12.0'
description:
- Gather information about pending reboot state.
options:
  skip:
    description:
    - List of checks that will be skipped during execution. Skipped check returns C(false)
    type: list
    elements: str
    required: false
    choices:
    - cbs
    - ccm_client
    - computer_rename
    - dsc_lcm
    - dvd_reboot_signal
    - file_rename
    - join_domain
    - server_manager
    - windows_update
seealso:
- module: ansible.windows.win_reboot
- name: Powershell PendingReboot module by Brian Wilhite
  description: Powershell PendingReboot module by Brian Wilhite
  link: https://github.com/bcwilhite/PendingReboot/
- name: How to Check for a Pending Reboot in the Registry (Windows)
  description: Article about pending reboot flags
  link: https://adamtheautomator.com/pending-reboot-registry/
notes:
- C(file_rename) check can be a false positive, because this registry property is used by antivirus programs.
  Recommended to add C(file_rename) to the C(skip) list to avoid false positives.
- Using the C(ccm_client) check can only be successful if target host have the CCM client installed
  in other cases it is recommended to add C(ccm_client) check to the C(skip) list.
author:
- Oleg Galushko (@inorangestylee)
'''

EXAMPLES = r'''
- name: Get pending reboot state
  community.windows.win_pending_reboot_info:
  register: pending_reboot_info

- name: Get pending reboot state (skip ccm client and file_rename)
  community.windows.win_pending_reboot_info:
    skip:
    - ccm_client
    - file_rename
  register: pending_reboot_info2

- name: Reboot server if pending
  ansible.windows.win_reboot:
  when: pending_reboot_info.reboot_required
'''

RETURN = r'''
checks:
    description:
    - a dict of pending reboot checks.
    returned: always
    type: dict
    sample:
      cbs: false
      ccm_client: false
      computer_rename: false
      dsc_lcm: false
      dvd_reboot_signal: false
      file_rename: true
      join_domain: false
      server_manager: true
      windows_update: false
reboot_required:
    description:
    - Overall result of checks. If one of checks is C(true) this value will also be C(true)
    returned: always
    type: bool
    sample: false
'''
