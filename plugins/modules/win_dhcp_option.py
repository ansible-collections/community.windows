#!/usr/bin/python
# -*- coding: utf-8 -*-
# Copyright: (c) 2020 Sebastian Gruber ,dacoso GmbH All Rights Reserved.
# SPDX-License-Identifier: GPL-3.0-only
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

DOCUMENTATION = r'''
---
module: win_dhcp_option
short_description: Manage Windows Server DHCP Options
author: Sebastian Gruber (@sgruber94)
requirements:
  - This module requires Windows Server 2012 or Newer
description:
  - Manage Windows Server DHCP Options (IPv4/IPv6)
  - Adds, Removes and Modifies DHCP Options
  - Task should be delegated to a Windows DHCP Server
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
    required: true
  version:
    description:
     - Specify Version from the IP Protocol
    type: str
    default: IPv4
    choices: [ IPv4, IPv6 ]
    required: true
  scope:
    descrition:
    - Required if l(type=scope), otherwise ignored.
    - Prefix will be used for IPv6
    type: str
    alias: [prefix]
  reservedip:
    descrition:
    - Specifies the IPv4/IPv6 address of the reservation for which the option value are set.
    - Required if l(type=reservation), otherwise ignored.
    type: str
  optionid:
    descrition:
    - Specifies the numeric identifier (ID) of the option for which the value are set.
    - Required if l(type=reservation), otherwise ignored.
    type: int
  value:
    descrition:
    - Specifies one value to be set for the option.
    type: str
  dnsdomain:
    descrition:
    - Specifies one or more values for the domain search list option.
    type: str
  router:
    descrition:
    - IPv4 only
    - Specifies one or more values for the router or default gateway option, in IPv4 address format.
    type: str
  VendorClass:
    descrition:
    - Sets the option value for the specified vendor class
    type: str
  dnsserver:
    descrition:
    - optional for specify DNS Server
    type: str
  computername:
    descrition:
    - optional for specify another Computer
    type: str
  force:
    descrition:
    - optional for forcing remove,set and add Commands
    type: bool
    default: no
'''

EXAMPLES = r'''

      win_dhcp_option:
          state: present
          version: "IPv6"
          type: "server"
          optionid: 24
          value: "server.ipv6.intern.systemuser.de"

      win_dhcp_option:
          state: present
          version: "IPv6"
          type: "scope"
          optionid: 24
          value: "scope.ipv6.intern.systemuser.de"
          prefix: "2001:5cc1::"
    
      win_dhcp_option:
          state: present
          version: "IPv4"
          type: "reservation"
          optionid: 15
          value: "reserved.ipv4.intern.systemuser.de"
          reservedip: "192.168.222.222"
'''

RETURN = r'''

'''
