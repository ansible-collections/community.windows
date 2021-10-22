#!/usr/bin/python
# -*- coding: utf-8 -*-

# Copyright: (c) 2020 VMware, Inc. All Rights Reserved.
# SPDX-License-Identifier: GPL-3.0-only
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

DOCUMENTATION = r'''
---
module: win_domain_ou
short_description: Manage Active Directory Organizational Units
author: ['Joe Zollo (@joezollo)', 'Larry Lane (@gamethis)']
version_added: 1.8.0
requirements:
  - This module requires Windows Server 2012 or Newer
  - Powershell ActiveDirectory Module
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
        I(protected=true), you cannot delete the corresponding object without
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
      - When I(state=present) the module will attempt to create the specified
        OU if it does not already exist.
      - When I(state=absent), the module will remove the specified OU.
      - When I(state=absent) and I(recursive=true), the module will remove all
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
    - The password for the domain you are accessing
  filter:
    type: str
    description: filter for lookup of ou.
    default: '*'
  properties:
    type: dict
    description:
      - Free form dict of properties for the organizational unit. Follows LDAP property names, like C(StreetAddress) or C(PostalCode).
'''

EXAMPLES = r'''
---
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
      StreetAddress: 1155 Perimeter Center West
      country: US
      description: EUC Business Unit
      PostalCode: 30189
  delegate_to: win-ad1.euc.vmware.lab

- name: Ensure OU updated with new properties
  community.windows.win_domain_ou:
    name: WS1Users
    path: DC=euc,DC=vmware,DC=lan
    protected: false
    properties:
      city: Atlanta
      state: Georgia
      managedBy: jzollo@vmware.com
  delegate_to: win-ad1.euc.vmware.lab
'''

RETURN = r'''
path:
  description:
    - Base ou path used by module either when provided I(path=DC=Ansible,DC=Test) or derived by module.
  returned: always
  type: str
  sample:
    path: "DC=ansible,DC=test"
ou:
  description:
    - New/Updated organizational unit parameters
  returned: When I(state=present)
  type: dict
  sample:
    AddedProperties: []
    City: "Sandy Springs"
    Country: null
    DistinguishedName: "OU=VMW Atlanta,DC=ansible,DC=test"
    LinkedGroupPolicyObjects: []
    ManagedBy: null
    ModifiedProperties: []
    Name: "VMW Atlanta"
    ObjectClass: "organizationalUnit"
    ObjectGUID: "3e987e30-93ad-4229-8cd0-cff6a91275e4"
    PostalCode: null
    PropertyCount: 11
    PropertyNames:
      City
      Country
      DistinguishedName
      LinkedGroupPolicyObjects
      ManagedBy
      Name
      ObjectClass
      ObjectGUID
      PostalCode
      State
      StreetAddress
    RemovedProperties: []
    State: "Georgia"
    StreetAddress: "1155 Perimeter Center West"
'''
