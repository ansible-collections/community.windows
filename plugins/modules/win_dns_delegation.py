#!/usr/bin/python
# -*- coding: utf-8 -*-
# Copyright: (c) 2020 Sebastian Gruber ,dacoso GmbH All Rights Reserved.
# SPDX-License-Identifier: GPL-3.0-only
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

DOCUMENTATION = r'''
---
module: win_dns_delegation
short_description: Manage Windows Server DNS Zone Delegations
author: Sebastian Gruber (@sgruber94)
requirements:
  - This module requires Windows Server 2012R2 or Newer
description:
  - Adds, Removes a DNS Zone Delegation
  - Task should be delegated to a Windows DNS Server
options:
  name:
    description:
      - Fully qualified name of the DNS zone that will be delegated.
    type: str
    required: true
  zone:
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
  NameServer:
    description:
      - Specifies the NameServer for that DNS zone.
      - DNS queries for a delegated zone are sent to these IPAddress.
      - Required if l(state=present), otherwise ignored.
    type: str
  IPAddress:
    description:
      - Specifies an list of IP addresses of the main NameServer of the zone.
      - Required if l(state=present), otherwise ignored.
    elements: str
    type: list
'''

EXAMPLES = r'''
    - name: ADD | DNS Zone Delegation
      win_dns_delegation:
          state: present
          zone: "example.com"
          name: "testlab"
          NameServer: "ns.example.com"
          IPAddress: 192.168.111.1

    - name: Remove | DNS Zone Delegation
      win_dns_delegation:
          state: absent
          zone: "example.com"
          name: "testlab2"
'''

RETURN = r'''
'''
