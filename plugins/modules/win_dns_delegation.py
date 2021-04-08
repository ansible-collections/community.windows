#!/usr/bin/python
# -*- coding: utf-8 -*-
# Copyright: (c) 2021 Sebastian Gruber(@sgruber94) ,dacoso GmbH All Rights Reserved.
# SPDX-License-Identifier: GPL-3.0-only
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

DOCUMENTATION = r'''
---
module: win_dns_delegation
short_description: Manage Windows Server DNS Zone Delegations
author: Sebastian Gruber (@sgruber94)
version_added: '1.4.0'
requirements:
  - This module requires Windows Server 2012R2 or Newer
  - This module requires PowerShell Module DNSServer(https://docs.microsoft.com/en-us/powershell/module/dnsserver/?view=win10-ps)
description:
  - Adds, Removes a DNS Zone Delegation
  - Task should be delegated to a Windows DNS Server
seealso:
  - module: community.windows.win_dns_record
  - module: community.windows.win_dns_zone
options:
  name:
    description:
      - Fully qualified name of the DNS zone that will be delegated.
    type: str
    required: true
  parent_zone:
    description:
      - Fully qualified name of the main DNS zone.
    type: str
    required: true
  state:
    description:
      - Specifies the desired state of the DNS zone delegation.
      - When l(state=present) the module will attempt to create the specified
        DNS zone delegation, if it does not already exist.
      - When l(state=absent), the module will remove the specified DNS
        zone delegation and all mentioned dns records.
    type: str
    default: present
    choices: [ present, absent ]
  name_server:
    description:
      - Specifies the NameServer for that DNS zone.
      - DNS queries for a delegated zone are sent to these IPAddress.
      - Required if l(state=present), otherwise ignored.
    type: str
  ip_address:
    description:
      - Specifies an list of IP addresses of the main NameServer of the zone.
      - Required if l(state=present), otherwise ignored.
    elements: str
    type: list
'''

EXAMPLES = r'''
    - name: ADD | DNS Zone Delegation
      community.windows.win_dns_delegation:
          state: present
          parent_zone: "example.com"
          name: "testlab"
          name_server: "ns.example.com"
          ip_address: 192.168.111.1

    - name: Remove | DNS Zone Delegation
      community.windows.win_dns_delegation:
          state: absent
          parent_zone: "example.com"
          name: "testlab2"
'''

RETURN = r'''
'''
