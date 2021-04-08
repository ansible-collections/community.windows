#!/usr/bin/python
# -*- coding: utf-8 -*-
# Copyright: (c) 2021 Sebastian Gruber ,dacoso GmbH All Rights Reserved.
# SPDX-License-Identifier: GPL-3.0-only
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

DOCUMENTATION = r'''
---
module: win_dhcp_option
short_description: Manage Windows Server DHCP Options
author: Sebastian Gruber (@sgruber94)
version_added: '1.4.0'
requirements:
  - This module requires Windows Server 2012 or Newer
description:
  - Manage Windows Server DHCP Options (IPv4/IPv6)
  - Adds, Removes and Modifies DHCP Options
  - Task should be delegated to a Windows DHCP Server
notes:
  - U(https://docs.microsoft.com/en-us/powershell/module/dhcpserver/set-dhcpserverv4optionvalue)
  - U(https://docs.microsoft.com/en-us/powershell/module/dhcpserver/set-dhcpserverv6optionvalue)
options:
  state:
    description:
      - Specifies the desired state
    type: str
    default: present
    choices: [ present, absent ]
  type:
    description:
    -  When l(type=server), Options will be applied to Server
    -  When l(type=scope), Options will be applied to defined scope
    -  When l(type=reservation), Options will be applied to defined reservation
    type: str
    choices: [ server,scope,reservation ]
    required: yes
  version:
    description:
     - Specify Version from the IP Protocol
    type: str
    default: IPv4
    choices: [ IPv4, IPv6 ]
  scope:
    description:
    - Required if l(type=scope), otherwise ignored.
    - Prefix will be used for IPv6
    type: str
    aliases: [prefix]
  reserved_ip:
    description:
    - Specifies the IPv4/IPv6 address of the reservation for which the option value are set.
    - Required if l(type=reservation), otherwise ignored.
    type: str
  option_id:
    description:
    - Specifies the numeric identifier (ID) of the option for which the value are set.
    - Required if l(type=reservation), otherwise ignored.
    type: int
  value:
    description:
    - Specifies one value to be set for the option.
    type: str
  dns_domain:
    description:
    - Specifies one or more values for the domain search list option.
    type: str
  router:
    description:
    - IPv4 only
    - Specifies one or more values for the router or default gateway option, in IPv4 address format.
    type: str
  vendor_class:
    description:
    - Sets the option value for the specified vendor class
    type: str
  dns_server:
    description:
    - optional for specify DNS Server
    type: str
  computer_name:
    description:
    - optional for specify another Computer
    type: str
  domain_search_list:
    description:
    - optional for specify another Computer
    type: str
  force:
    description:
    - optional for forcing remove,set and add Commands
    type: bool
    default: no
'''

EXAMPLES = r'''
    - name: Add IPv6 Server Option
      community.windows.win_dhcp_option:
          state: present
          version: "IPv6"
          type: "server"
          option_id: 24
          value: "server.ipv6.intern.example.de"

    - name: Add IPv6 Scope Option
      community.windows.win_dhcp_option:
          state: present
          version: "IPv6"
          type: "scope"
          option_id: 24
          value: "scope.ipv6.intern.example.de"
          prefix: "2001:5cc1::"

    - name: Add IPv4 Reservation Option
      community.windows.win_dhcp_option:
          state: present
          version: "IPv4"
          type: "reservation"
          option_id: 15
          value: "reserved.ipv4.intern.example.de"
          reserved_ip: "192.168.222.222"
'''

RETURN = r'''

'''
