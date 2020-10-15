#!/usr/bin/python
# -*- coding: utf-8 -*-

# Copyright: 2020, Sakar Mehra (@sakar97) <sakar.mehra@gslab.com>
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

DOCUMENTATION = r'''
---
module: win_ntp
short_description: Manage Windows NTP Server
author: Sakar Mehra (@sakar97)
requirements:
  - This module requires Windows Server 2012R2 or Newer
description:
  - Manage Windows NTP Client
  - Adds, Removes and Modifies NTP Server in windows machine.
options:
  peerlist:
    description:
      - Fully qualified domain name or IP address from which computer obtain timestamp.
    type: list
  type:
    description:
      - Indicates which peers to accept synchronization from.
      - The default value on stand-alone clients and servers is NTP.
    type: str
    choices: [ NTP, NoSync, NT5DS, AllSync ]
  enabled:
    description:
      - Indicates if the NtpClient provider is enabled in the current Time Service.
      - The default value on stand-alone clients and servers is true.
    type: bool
    default: true
  time_zone:
    description:
      - Set the time zone for the ntp server.
    type: str
    default: UTC
  factory_default:
    description:
      - Ntp configuration are set to default with this option.
    type: bool
    default: false
  cross_site_sync_flags:
    description:
      - Determines whether the service chooses synchronization partners outside the domain of the computer.
      - Thsi value is ignored if l(type=NT5DS) is not set.
    type: int
    choices: [ 0, 1, 2 ]
  sync_clock:
    description:
      - It resynchronize its clock as soon as possible.
      - To update the ntp server with new peerlist.
    elements: str
    type: list
    default: time.windows.com,0x9
'''

EXAMPLES = r'''
- name: Enable ntpclient from the machine
  community.windows.win_ntp:
    peerlist: time.google.com
    enabled: true
    type: NTP

- name: Disable the nptclient from the machine
  community.windows.win_ntp:
    peerlist: time.google.com
    enabled: false
    type: NTP

- name: Enable npt service with multiple peers to get sync from
  community.windows.win_ntp:
    enabled: true
    peerlist:
      - time.google.com
      - time.yahoo.com
      - time.apple.com
    type: NTP
    sync_clock: true

- name: Changing the configuration back to defualt
  community.windows.win_ntp:
    factory_default: true

- name: Setting the nt5ds type
  community.windows.win_ntp:
    type: NT5DS
    cross_site_sync_flags: 1
    sync_clock: true
'''

RETURN = r'''
source_name:
    description: Current source of ntp client
    returned: always
    type: str
    sample: time.windows.com,0x9
last_time_sync_seconds:
    description: Last clock time syncronization
    returned: always
    type: int
    sample: 20
synced:
    description: Whether clock syncronization or not
    returned: always
    type: bool
    sample: true
'''
