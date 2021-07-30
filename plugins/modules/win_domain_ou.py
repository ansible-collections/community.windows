#!/usr/bin/python
# -*- coding: utf-8 -*-

# Copyright: (c) 2020 VMware, Inc. All Rights Reserved.
# SPDX-License-Identifier: GPL-3.0-only
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

DOCUMENTATION = r'''
---
module: win_domain_ou
short_description: Manage Active Directory Organizational Units
author: Joe Zollo (@joezollo), Larry Lane (@gamethis)
requirements:
  - This module requires Windows Server 2012 or Newer
description:
  - Manage Active Directory Organizational Units
  - Adds, Removes and Modifies Active Directory Organizational Units
  - Task should be delegated to a Windows Active Directory Domain Controller
options:
  name:
    description:
      - The name of the Organizational Unit
    type: str
    required: true
  protected:
    description:
      - Indicates whether to prevent the object from being deleted. When this
        l(protected=true), you cannot delete the corresponding object without
        changing the value of the property.
    type: bool
    default: false
  path:
    description:
      - Specifies the X.500 path of the OU or container where the new object is
        created.
      - defaults to adding ou at base of domain connected to.
    type: str
    required: false
  state:
    description:
      - Specifies the desired state of the OU.
      - When l(state=present) the module will attempt to create the specified
        OU if it does not already exist.
      - When l(state=absent), the module will remove the specified OU.
      - When l(state=absent) and l(recursive=true), the module will remove all
        the OU and all child OU's.
    type: str
    default: present
    choices: [ present, absent ]
  recursive:
    description:
      - Removes the OU and any child items it contains.
      - You must specify this parameter to remove an OU that is not empty.
    type: bool
    default: false
  domain_server:
    description:
    - Specifies the Active Directory Domain Services instance to connect to.
    - Can be in the form of an FQDN or NetBIOS name.
    - If not specified then the value is based on the domain of the computer
      running PowerShell.
    type: str
  domain_username:
    description:
    - The username to use when interacting with AD.
    - If this is not set then the user Ansible used to log in with will be
      used instead when using CredSSP or Kerberos with credential delegation.
    type: str
  domain_password:
    type: str
    description:
    - The password for the domain you are accessig
    
  filter:
    type: str
    description: filter for lookup of ou.
    default: '*'
  properties:
    type: dict
    description:
      - Defines specific LDAP properties for the organizational unit.
'''

EXAMPLES = r'''
- name: Ensure OU is present & protected
  community.windows.win_domain_ou:
    name: AnsibleFest
    state: present

- name: Ensure OU is present & protected
  community.windows.win_domain_ou:
    name: EUC Users
    path: "DC=euc,DC=vmware,DC=lan"
    state: present
    protected: true
  delegate_to: win-ad1.euc.vmware.lab

- name: Ensure OU is absent
  community.windows.win_domain_ou:
    name: EUC Users
    path: "DC=euc,DC=vmware,DC=lan"
    state: absent
  delegate_to: win-ad1.euc.vmware.lab

- name: Ensure OU is present with specific properties
  community.windows.win_domain_ou:
    name: WS1Users
    path: "CN=EUC Users,DC=euc,DC=vmware,DC=lan"
    protected: true
    properties:
      city: Sandy Springs
      state: Georgia
      street_address: 1155 Perimeter Center West
      country: US
      description: EUC Business Unit
      postal_code: 30189
  delegate_to: win-ad1.euc.vmware.lab

- name: Ensure OU updated with new properties
  community.windows.win_domain_ou:
    name: WS1Users
    path: DC=euc,DC=vmware,DC=lan
    protected: false
    properties:
      city: Atlanta
      state: Georgia
      managed_by: jzollo@vmware.com
  delegate_to: win-ad1.euc.vmware.lab
'''

RETURN = r'''
ou:
  description: New/Updated organizational unit parameters
  returned: When l(state=present)
  type: dict
  sample:
    name:
    guid:
    distinguished_name:
    canonoical_name:
    created:
    modified:
    protected:
    properties:
      display_name:
      description:
      city:
      street_address:
      postal_code:
      country:
      managed_by:
'''
