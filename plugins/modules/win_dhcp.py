#!/usr/bin/python
# -*- coding: utf-8 -*-

# Copyright © 2019 VMware, Inc. All Rights Reserved.
# SPDX-License-Identifier: GPL-3.0-only
# Ansible Module by Joseph Zollo (jzollo@vmware.com)

ANSIBLE_METADATA = {'metadata_version': '1.0',
                    'status': ['preview'],
                    'supported_by': 'community'}

DOCUMENTATION = r'''
---
module: win_dhcp
version_added: '2.10'
short_description: Interacts with Windows DHCP Server in the Client Context
description:
- Interacts with Windows DHCP Server in the Client Context
- Adds or Removes DHCP Leases and Reservations for targeted hosts
- Task should be delegated to a Windows DHCP Server
options:
  type:
    description:
      - The type of DHCP address
    type: str
    default: reservation
    choices: [ reservation, lease ]
  state:
    description:
      - Specifies the desired state of the DHCP lease or reservation
    type: str
    choices: [ present, absent ]
  ip:
    description:
      - The IP address of the client server/computer
    type: str
    required: yes
  scope_id:
    description:
      - Specifies the scope identifier
      - Required when creating a new DHCP reservation/lease
    type: str
  mac:
    description:
      - Specifies the client identifier to be set on the IPv4 address
      - Windows clients use the MAC address as the client ID
      - Linux and other operating systems can use other types of identifiers
    type: str
  duration:
    description:
      - Specifies the duration of the DHCP lease in days
      - The duration value only applies to l(type=lease)
      - Defaults to the duration specified by the DHCP server configuration
    type: int
  dns_hostname:
    description:
      - Specifies the DNS hostname of the client for which the IP address lease is to be added
  dns_regtype:
    description:
      - Indicates the type of DNS record to be registered by the DHCP server service for this lease
      - Defaults to the type specified by the DHCP server configuration
    type: str
    choices: [ aptr, a, noreg ]
  reservation_name:
    description:
      - Specifies the name of the reservation being created
      - Only applicable to l(type=reservation)
    type: str
  description:
    description:
      - Specifies the description for reservation being created
      - Only applicable to l(type=reservation)
    type: str
author:
- Joseph Zollo (@joezollo)
'''

EXAMPLES = r'''
- name: Ensure DHCP reservation exists
  win_dhcp:
    type: reservation
    ip: 192.168.100.205
    scope_id: 192.168.100.0
    mac: 00b18ad15a1f
    dns_hostname: "{{ ansible_inventory }}"
    description: Testing Server
  delegate_to: dhcpserver.vmware.com

- name: Ensure DHCP lease or reservation does not exist
  win_dhcp:
    mac: 00b18ad15a1f
    state: absent
  delegate_to: dhcpserver.vmware.com

- name: Ensure DHCP lease or reservation does not exist
  win_dhcp:
    ip: 192.168.100.205
    state: absent
  delegate_to: dhcpserver.vmware.com

- name: Convert DHCP lease to reservation & update description
  win_dhcp:
    type: reservation
    ip: 192.168.100.205
    description: Testing Server
  delegate_to: dhcpserver.vmware.com

- name: Convert DHCP reservation to lease
  win_dhcp:
    type: lease
    ip: 192.168.100.205
  delegate_to: dhcpserver.vmware.com
'''

RETURN = r'''
lease:
  description: DHCP object parameters
  returned: When l(state=present)
  type: dict
  sample:
    AddressState: InactiveReservation 
    ClientId: 0a-0b-0c-04-05-aa
    Description: Really Fancy
    IPAddress: 172.16.98.230
    Name: null
    ScopeId: 172.16.98.0
'''

from module_utils.basic import AnsibleModule