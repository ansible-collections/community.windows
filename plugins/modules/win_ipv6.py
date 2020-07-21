#!/usr/bin/python
# -*- coding: utf-8 -*-

# Copyright: (c) 2020, ライトウェルの人 <jiro.higuchi@shi-g.com>
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

# this is a windows documentation stub.  actual code lives in the .ps1
# file of the same name

DOCUMENTATION = r'''
---
module: win_ipv6
short_description: Enable or disable ms_tcpip6 of a certain network adapter or all the network adapters
description:
     - Enable or disable ms_tcpip6 of a certain network adapter or all the network adapters.
options:
  interface:
    description:
      - Name of Network Adapter Interface. For example, 'Ethernet0' or '*'.
    type: str
    required: yes
    version_added: "2.10"
  state:
    description:
      - Specify the state of ms_tcpip6 of interfaces.
    type: str
    choices:
      - enable
      - disable
    required: yes
    version_added: "2.9"

author:
  - ライトウェルの人 (@jirolin)
'''


EXAMPLES = r'''
- name: Disable ms_tcpip6 of Interface "Ethernet0" 
  win_ipv6:
    interface: 'Ethernet0'
    status: disable

- name: Enable ms_tcpip6 of all the Interface
  win_ipv6:
    interface: '*'
    status: enable

'''

