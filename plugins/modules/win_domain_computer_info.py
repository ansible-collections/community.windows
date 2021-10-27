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
  name:
    description:
      - the C(name) or fqdn name of the computer to get the info for.
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
    default: "*"
  search_scope:
    description:
    - Specify the scope of when searching for a computer.
    - C(base) will limit the search to the base object so the maximum number of objects returned is always one. This
      will not search any objects inside a container..
    - C(one_level) will search the current path and any immediate objects in that path.
    - C(subtree) will search the current path and all objects of that path recursively.
    choices:
    - base
    - one_level
    - subtree
    type: str
  filter:
    description:
    - Specify filter to use with Get-Adcomputer
    type: str
  ldap_filter:
    description:
    - Specify ldap filter to use with Get-Adcomputer
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
    name: "{{ ansible_host }}"
    register: computer_info

- name: Get Computer Info with Properties
  community.windows.win_domain_computer_info:
    name: "{{ ansible_hostname }}"
    properties:
      - name
      - samaccountname
      - dnshostname
  register: computer_info_with_properties
'''

RETURN = r'''
computers:
  AccountExpirationDate:
    description: Accout Expiration Date
    type: str
  AccountExpires:
    description:
    type: int
  AccountLockoutTime:
    description:
    type: str
  AccountNotDelegated:
    description:
    type: bool
  AllowReversiblePasswordEncryption:
    description:
    type: bool
  # AuthenticationPolicy:
  #  description::
  #  type: str
  # AuthenticationPolicySilo:
  # description::
  # BadLogonCount:
  # description::
  # badPasswordTime:
  #  description:
  # badPwdCount:
  #  description:
  CannotChangePassword:
    description:
    type: bool
  CanonicalName:
    description:
    type: str
  Certificates:
    description:
    type: list
  CN:
    description:
    type: str
  codePage:
    description
    type: int
  countryCode:
    description:
    type: int
  Created:
    description:
    type: str
  createTimeStamp:
    description:
    type: str
  Deleted:
    description:
    type: bool
  Description:
    description:
    type: str
  DisplayName:
    description:
    type: str
  DistinguishedName:
    description:
    type: str
  DNSHostName:
    description:
    type: str
  DoesNotRequirePreAuth:
    description:
    type: str
  dSCorePropagationData:
    description:
    type: list
  Enabled:
    description:
    type: bool
  HomedirRequired:
    description:
    type: str
  HomePage:
    description:
    type: str
  instanceType:
    description:
    type: int
  IPv4Address:
    description:
    type: str
  IPv6Address:
    description:
    type: str
  isCriticalSystemObject:
    description:
    type: bool
  isDeleted:
    description:
    type: bool
  # KerberosEncryptionType:
  #   description:
  #   type: str
  LastBadPasswordAttempt:
    description:
    type: str
  LastKnownParent :
    description:
    type: str
  # lastLogoff:
  #  description:
  # type: int
  lastLogon:
    description:
    type: int
  LastLogonDate:
    description:
    type: int
  # lastLogonTimestamp:
  #   description:
  # type: str
  localPolicyFlags:
    description:
    type: int
  Location:
    description:
    type: str
  LockedOut:
    description:
    type: bool
  logonCount:
    description:
    type: int
  ManagedBy:
    description:
    type: str
  MemberOf:
    description:
    type: list
  MNSLogonAccount:
    description:
    type: str
  Modified:
    description:
    type: str
  modifyTimeStamp:
    description:
    type: str
  # msDS_SupportedEncryptionTypes  :
  #   description:
  # msDS_User_Account_Control_Computed :
  #   description:
  Name:
    description:
    type: str
  nTSecurityDescriptor:
    description:
    type: str
  ObjectCategory:
    description:
    type: str
  ObjectClass:
    description:
    type: str
  ObjectGUID:
    description:
    type: str
  objectSid:
    description:
    type: str
  OperatingSystem:
    description:
    type: str
  OperatingSystemHotfix:
    description:
    type: str
  OperatingSystemServicePack:
    description:
    type: str
  OperatingSystemVersion:
    description:
    type: str
  PasswordExpired:
    description:
    type: bool
  PasswordLastSet:
    description:
    type: str
  PasswordNeverExpires:
    description:
    type: bool
  PasswordNotRequired:
    description:
    type: bool
  PrimaryGroup:
    description:
    type: str
  primaryGroupID:
    description:
    type: int
  # PrincipalsAllowedToDelegateToAccount:
  #   description:
  ProtectedFromAccidentalDeletion:
    description:
    type: bool
  pwdLastSet:
    description:
    type: str
  SamAccountName:
    description:
    type: str
  sAMAccountType:
    description:
    type: int
  sDRightsEffective:
    description:
    type: str
  ServiceAccount:
    description:
    type: str
  servicePrincipalName:
    description:
    type: list
  ServicePrincipalNames:
    description:
    type: list
  SID:
    description:
    type: str
  SIDHistory :
    description:
    type: list
  TrustedForDelegation:
    description:
    type: bool
  TrustedToAuthForDelegation:
    description:
    type: bool
  UseDESKeyOnly:
    description:
    type: bool
  userAccountControl:
    description:
    type: str
  userCertificate:
    description:
    type: str
  UserPrincipalName:
    description:
    type: str
  uSNChanged:
    description:
    type: int
  uSNCreated:
    description:
    type: int
  whenChanged:
    description:
    type: str
  whenCreated:
    description:
    type: str
'''
