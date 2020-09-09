#!/usr/bin/python
# -*- coding: utf-8 -*-

# Copyright: (c) 2020, ライトウェルの人 <jiro.higuchi@shi-g.com>
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

# this is a windows documentation stub.  actual code lives in the .ps1
# file of the same name

DOCUMENTATION = r'''
---
module: win_net_adapter_feature
short_description: Enable or disable certain network adapters.
description:
     - Enable or disable ms_tcpip6 of a certain network adapter or all the network adapters.
options:
  interface:
    description:
      - Name of Network Adapter Interface. For example, C(Ethernet0) or C(*).
    type: str
    required: yes
  state:
    description:
      - Specify the state of ms_tcpip6 of interfaces.
    type: str
    choices:
      - enable
      - disable
    required: yes
  componentID:
    description:
      - Specify the below componentID of network adapters.
      - componentID (DisplayName)
      - ms_implat (Microsoft Network Adapter Multiplexor Protocol)
      - ms_lltdio (Link-Layer Topology Discovery Mapper I/O Driver)
      - ms_tcpip6 (Internet Protocol Version 6 (TCP/IPv6))
      - ms_tcpip (Internet Protocol Version 4 (TCP/IPv4))
      - ms_lldp (Microsoft LLDP Protocol Driver)
      - ms_rspndr (Link-Layer Topology Discovery Responder)
      - ms_msclient (Client for Microsoft Networks)
      - ms_pacer (QoS Packet Scheduler)
      - If you'd like to set custom adapters like 'Juniper Network Service', get the I(component_id) by running the C(Get-NetAdapterBinding) cmdlet.
    type: str
    required: yes

author:
  - ライトウェルの人 (@jirolin)
'''


EXAMPLES = r'''
- name: enable multiple interfaces of multiple interfaces
  win_net_adapter_feature:
    interface:
    - 'Ethernet0'
    - 'Ethernet1'
    state: enable
    componentID:
    - ms_tcpip6
    - ms_server

- name: Enable ms_tcpip6 of all the Interface
  win_net_adapter_feature:
    interface: '*'
    state: enable
    componentID:
    - ms_tcpip6

'''
