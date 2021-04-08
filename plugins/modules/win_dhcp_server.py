#!/usr/bin/python
# -*- coding: utf-8 -*-
# Copyright: (c) 2021 Sebastian Gruber (@sgruber94),dacoso GmbH All Rights Reserved.
# SPDX-License-Identifier: GPL-3.0-only
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

DOCUMENTATION = r'''
---
module: win_dhcp_server
short_description: Manage Windows DHCP Server
author: Sebastian Gruber (@sgruber94)
version_added: '1.4.0'
description:
  - Manage Windows Server DHCP  (IPv4/IPv6)
  - Adds, Removes and Modifies DHCP Scopes and exclusions
  - Task should be delegated to a Windows DHCP Server
requirements:
  - This module requires Windows Server 2012 or Newer
  - PowerShell Module L(DhcpServer,https://docs.microsoft.com/en-us/powershell/module/dhcpserver/?view=win10-ps)
seealso:
  - module: community.windows.win_dhcp_lease
  - module: community.windows.win_dhcp_option
options:
  state:
    description:
      - Specifies the desired state
    type: str
    default: present
    choices: [ present, absent ]
  type:
    description:
      - Type that should be added
      - When l(type=scope), Scope will be added/removed to DHCP Server
      - When l(type=exclusion), Exclusion will be added/removed to selected DHCP scope
    type: str
    choices: [ scope, exclusion ]
    required: true
  version:
    description:
      - Specify Version from the IP Protocol
    type: str
    default: IPv4
    choices: [ IPv4, IPv6 ]
  scope:
    description:
      - Required if l(type=scope), otherwise ignored.
    type: str
    aliases: [prefix]
  valid_lifetime:
    description:
      - defines valid Life Time for IPv6
      - This time span is equal to or greater than the Preferred Lifetime also assigned to the scope.
      - Required if l(version=IPv6) and l(type=scope), otherwise ignored.
    type: str
    default: "0.04:00:00"
  preferred_lifetime:
    description:
      - defines Preferred Life Time for IPv6
      - This time span is equal to or less than the valid lifetime also assigned to the scope.
      - Required if l(version=IPv6) and l(type=scope), otherwise ignored.
    type: str
    default: "0.02:00:00"
  scope_state:
    description:
      - Specify if a scope is Active or Inactive
      - Required if l(type=scope), otherwise ignored.
    type: str
    default: Active
    choices: [ Active, InActive ]
  name:
    description:
      - Specify Scope Name
    type: str
    required: true
  dhcp_server:
    description:
      - optional for specify a DHCP Server
    type: str
  start_range:
    description:
      - optional, defines Startrange for IPv4 Addressspace
    type: str
  end_range:
    description:
      - optional, defines Endrange for IPv4 Addressspace
    type: str
  subnet_mask:
    description:
      - optional, defines Subnetmask for IPv4 Addressspace
    type: str
  force:
    description:
      - optional for forcing remove,set and add Commands
    type: bool
    default: no
'''

EXAMPLES = r'''
    - name: ADD | DHCP IPv4 Scope
      community.windows.win_dhcp_server:
          state: present
          version: "IPv4"
          type: "scope"
          name: "DHCP - Test Scope - IPv4"
          scope: "192.168.222.0"
          start_range: "192.168.222.1"
          end_range: "192.168.222.250"
          scope_state: InActive
          subnet_mask: "255.255.255.0"

    - name: ADD | DHCP IPv6 Scope
      community.windows.win_dhcp_server:
          state: present
          version: "IPv6"
          type: "scope"
          name: "DHCP - Test Scope - IPv6"
          prefix: "2001:5cc1::"
          valid_lifetime: "0.04:00:00"
          preferred_lifetime: "0.02:00:00"
'''

RETURN = r'''

'''
