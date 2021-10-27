#!/usr/bin/python
# -*- coding: utf-8 -*-

# Copyright: (c) 2020, Ansible Project
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

DOCUMENTATION = r'''
---
module: win_domain_computer_info
short_description: Gather active diretory information about a computer.
requirements:
  - This module requires Windows Server 2012 or Newer
  - Requires ActiveDirectory module installed on system
description:
  - Gather information about 1 or more computers in Active Directory domain.
options:
  identity:
    description:
      Specifies an Active Directory computer object by providing one of the following property values.
      The identifier in parentheses is the LDAP display name for the attribute.
      The acceptable values for this parameter are:
        - A distinguished name
        - A GUID C(objectGUID)
        - A security identifier C(objectSid)
        - A Security Accounts Manager account name C(sAMAccountName)
    type: str
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
    description:
      - The password for domain targeted
    type: str
  properties:
    description:
      - list of propterties to pass to Get-AdComputer
      - case insensitive
    type: list
    elements: str
    default: ["*"]
  excluded_properties:
    description:
      - list of properties to exclude from return
      - case insensitive
    type: list
    elements: str
    default: ["DeclaredConstructors", "DeclaredMembers", "nTSecurityDescriptor"]
  search_scope:
    description:
      - Specify the scope of when searching for a computer.
      - C(Base) will limit the search to the base object so the maximum number of objects returned is always one. This
        will not search any objects inside a container..
      - C(OneLevel) will search the current path and any immediate objects in that path.
      - C(Subtree) will search the current path and all objects of that path recursively.
    choices:
      - Base
      - OneLevel
      - Subtree
    type: str
  filter:
    description:
      - Specify filter to use with Get-Adcomputer
    type: str
  ldap_filter:
    description:
      - Specify ldap filter to use with Get-Adcomputer
    type: str
  search_base:
    description:
      - Specifies an Active Directory path to search under.
    type: str
seealso:
  - module: ansible.windows.win_domain_object_info
author:
  - Larry Lane (@gamethis)
'''

EXAMPLES = r'''
- name: Install ActiveDirectory Powershell extensions
  ansible.windows.win_feature:
    name: RSAT-AD-PowerShell
    state: present

- name: Install Active Directory Module
  community.windows.win_psmodule:
    name: ActiveDirectory
    state: present

- name: Get info for current computer
  community.windows.win_domain_computer_info:
    identity: "{{ ansible_host }}"
    register: computer_info

- name: Get Computer Info with Properties
  community.windows.win_domain_computer_info:
    identity: "{{ ansible_hostname }}"
    properties:
      - name
      - samaccountname
      - dnshostname
  register: computer_info_with_properties
'''

RETURN = r'''
exists:
  description: Whether any features were found based on the criteria specified.
  returned: always
  type: bool
  sample: true
computers:
  description:
    - 1 or more computer object 
    - return contents depends on I(properties) and rights of user to view the Directory
    - Listed some of the most common below under I(contains)
  returned: When I(exists)
  type: list
  elements: dict
  contains:
    AccountExpirationDate:
      description: Accout Expiration Date
      type: str
    AccountExpires:
      description:
      type: int
    AccountLockoutTime:
      description: Time of Account Lockout
      type: str
    BadLogonCount:
      description: Number of bad loggons
      type: int
    badPasswordTime:
      description: Time of last bad loggon
    CanonicalName:
      description:
      type: str
    Created:
      description: Date created
      type: str
    Description:
      description: discription on computer object
      type: str
    DisplayName:
      description: Displayed name
      type: str
    DistinguishedName:
      description: full cn of computer ie. CN=ANSIBLE-TESTER,OU=Domain Controllers,DC=ansible,DC=test
      type: str
    DNSHostName:
      description: fqdn name of system ie. ansible-tester.ansible.test
      type: str
    Enabled:
      description: Tells if computer object is enabled
      type: bool
    Name:
      description: Name of computer object
      type: str
    PasswordExpired:
      description: Bool to tell if Password is expired
      type: bool
    PasswordLastSet:
      description: Date of last password set
      type: str
    PasswordNeverExpires:
      description: Bool to state if password never expires
      type: bool
    SamAccountName:
      description:
      type: str
    sAMAccountType:
      description:
      type: int
    SID:
      description: Security Identifier
      type: list
      elements: dict
    SIDHistory :
      description:
      type: list
    whenChanged:
      description:
      type: str
    whenCreated:
      description:
      type: str
'''
