#!/usr/bin/python
# -*- coding: utf-8 -*-

# Copyright: (c) 2020, Brian Scholer (@briantist)
# Copyright: (c) 2017, AMTEGA - Xunta de Galicia
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

ANSIBLE_METADATA = {'metadata_version': '1.1',
                    'status': ['preview'],
                    'supported_by': 'community'}

DOCUMENTATION = r'''
---
module: win_domain_computer
short_description: Manage computers in Active Directory
description:
  - Create, read, update and delete computers in Active Directory using a
    windows bridge computer to launch New-ADComputer, Get-ADComputer,
    Set-ADComputer, Remove-ADComputer and Move-ADObject powershell commands.
options:
  name:
    description:
      - Specifies the name of the object.
      - This parameter sets the Name property of the Active Directory object.
      - The LDAP display name (ldapDisplayName) of this property is name.
    type: str
    required: true
  sam_account_name:
    description:
      - Specifies the Security Account Manager (SAM) account name of the
        computer.
      - It maximum is 256 characters, 15 is advised for older
        operating systems compatibility.
      - The LDAP display name (ldapDisplayName) for this property is sAMAccountName.
      - If ommitted the value is the same as C(name).
      - Note that all computer SAMAccountNames need to end with a C($).
      - If C($) is omitted, it will be added to the end.
    type: str
  enabled:
    description:
      - Specifies if an account is enabled.
      - An enabled account requires a password.
      - This parameter sets the Enabled property for an account object.
      - This parameter also sets the ADS_UF_ACCOUNTDISABLE flag of the
        Active Directory User Account Control (UAC) attribute.
    type: bool
    default: yes
  ou:
    description:
      - Specifies the X.500 path of the Organizational Unit (OU) or container
        where the new object is created. Required when I(state=present).
      - Special characters must be escaped, see U(https://docs.microsoft.com/en-us/previous-versions/windows/desktop/ldap/distinguished-names)
    type: str
  description:
    description:
      - Specifies a description of the object.
      - This parameter sets the value of the Description property for the object.
      - The LDAP display name (ldapDisplayName) for this property is description.
    type: str
    default: ''
  dns_hostname:
    description:
      - Specifies the fully qualified domain name (FQDN) of the computer.
      - This parameter sets the DNSHostName property for a computer object.
      - The LDAP display name for this property is dNSHostName.
      - Required when I(state=present).
    type: str
  domain_username:
    description:
    - The username to use when interacting with AD.
    - If this is not set then the user Ansible used to log in with will be
      used instead when using CredSSP or Kerberos with credential delegation.
    type: str
  domain_password:
    description:
    - The password for I(username).
    type: str
  domain_server:
    description:
    - Specifies the Active Directory Domain Services instance to connect to.
    - Can be in the form of an FQDN or NetBIOS name.
    - If not specified then the value is based on the domain of the computer
      running PowerShell.
    type: str
  state:
    description:
      - Specified whether the computer should be C(present) or C(absent) in
        Active Directory.
    type: str
    choices: [ absent, present ]
    default: present
  offline_domain_join:
    description:
      - Provisions a computer in the directory and provides a BLOB file that can be used on the target computer/image to join it to the domain while offline.
      - If the computer already exists, no BLOB will be created/returned, and the module will operate as it would have without offline domain join.
    type: bool
  odj_return_blob:
    description:
      - Returns the BLOB in the module output. Note that the BLOB should be treated as a secret, as it contains the machine password.
      - The module should be called with C(no_log) when using this option.
      - The BLOB file contains a terminating null character which will not be included. See Notes.
  odj_blob_path:
    description:
      - The path to the file where the BLOB will be saved.
      - Required when I(offline_domain_join=True) and I(odj_return_blob=False).
      - If using I(odj_return_blob=True) this can be omitted, and a temporary file will be used and then destroyed.
      - If I(odj_return_blob=True) and this is specified, it will be used and file will remain.
notes:
  - "For more information on Offline Domain Join
    see U(https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd392267(v=ws.10))"
  - When using the ODJ BLOB to join a computer to the domain, it must be written out to a file.
  - The file must be UTF-16 encoded (in PowerShell this encoding is called C(Unicode)), and it must end in a null character. See examples.
  - The C(djoin.exe) part of the offline domain join process will not use I(domain_server), I(domain_username), or I(domain_password).
seealso:
- module: win_domain
- module: win_domain_controller
- module: win_domain_group
- module: win_domain_membership
- module: win_domain_user
author:
- Daniel Sánchez Fábregas (@Daniel-Sanchez-Fabregas)
- Brian Scholer (@briantist)
'''

EXAMPLES = r'''
  - name: Add linux computer to Active Directory OU using a windows machine
    community.windows.win_domain_computer:
      name: one_linux_server
      sam_account_name: linux_server$
      dns_hostname: one_linux_server.my_org.local
      ou: "OU=servers,DC=my_org,DC=local"
      description: Example of linux server
      enabled: yes
      state: present
    delegate_to: my_windows_bridge.my_org.local

  - name: Remove linux computer from Active Directory using a windows machine
    community.windows.win_domain_computer:
      name: one_linux_server
      state: absent
    delegate_to: my_windows_bridge.my_org.local

  - name: Provision a computer for offline domain join
    community.windows.win_domain_computer:
      name: newhost
      dns_hostname: newhost.ansible.local
      ou: 'OU=A great\, big organizational unit name,DC=ansible,DC=local'
      state: present
      offline_domain_join: yes
      odj_return_blob: yes
    register: computer_status
    delegate_to: windc.ansible.local

  - name: Join a workgroup computer to the domain
    vars:
      target_blob_file: 'C:\ODJ\blob.txt'
    ansible.windows.win_shell: |
      # add terminating null character to BLOB
      $blob = "{{ computer_status.odj_blob }}`0"
      $blob | Set-Content -LiteralPath '{{ target_blob_file }}' -Encoding Unicode -Force
      & djoin.exe --% /RequestODJ /LoadFile "{{ target_blob_file }}" /LocalOS /WindowsPath "%SystemRoot%"

  - name: Restart to complete domain join
    ansible.windows.win_restart:
'''

RETURN = r'''
odj_blob:
  description: The offline domain join BLOB. This is an empty string when in check mode or when odj_return_blob is False.
  returned: when offline_domain_join is True and the computer didn't exist
  type: str
  sample: <a long base64 string>
djoin:
  description: Information about the invocation of djoin.exe.
  returned: when offline_domain_join is True and the computer didn't exist
  type: dict
  contains:
    invocation:
      description: The full command line used to call djoin.exe
      type: str
      returned: always
      sample: djoin.exe /PROVISION /MACHINE compname /MACHINEOU OU=Hosts,DC=ansible,DC=local /DOMAIN ansible.local /SAVEFILE blobfile.txt
    rc:
      description: The return code from djoin.exe
      type: int
      returned: when not check mode
      sample: 87
    stdout:
      description: The stdout from djoin.exe
      type: str
      returned: when not check mode
      sample: Computer provisioning completed successfully.
    stderr:
      description: The stderr from djoin.exe
      type: str
      returned: when not check mode
      sample: Invalid input parameter combination.
'''
