#!/usr/bin/python
# -*- coding: utf-8 -*-

# Copyright: (c) 2020, Brian Scholer (@briantist)
# Copyright: (c) 2017, AMTEGA - Xunta de Galicia
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

DOCUMENTATION = r'''
---
module: win_domain_computer
short_description: Manage computers in Active Directory
description:
  - Create, read, update and delete computers in Active Directory using a
    windows bridge computer to launch New-ADComputer, Get-ADComputer,
    Set-ADComputer, Remove-ADComputer and Move-ADObject powershell commands.
deprecated:
  removed_in: 3.0.0
  why: This module has been moved into the C(microsoft.ad) collection.
  alternative: Use the M(microsoft.ad.computer) module instead.
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
      - "Special characters must be escaped,
        see L(Distinguished Names,https://docs.microsoft.com/en-us/previous-versions/windows/desktop/ldap/distinguished-names) for details."
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
  managed_by:
    description:
    - The value to be assigned to the LDAP C(managedBy) attribute.
    - This value can be in the forms C(Distinguished Name), C(objectGUID),
      C(objectSid) or C(sAMAccountName), see examples for more details.
    type: str
    version_added: '1.3.0'
  offline_domain_join:
    description:
      - Provisions a computer in the directory and provides a BLOB file that can be used on the target computer/image to join it to the domain while offline.
      - The C(none) value doesn't do any offline join operations.
      - C(output) returns the BLOB in output. The BLOB should be treated as secret (it contains the machine password) so use C(no_log) when using this option.
      - C(path) preserves the offline domain join BLOB file on the target machine for later use. The path will be returned.
      - If the computer already exists, no BLOB will be created/returned, and the module will operate as it would have without offline domain join.
    type: str
    choices:
      - none
      - output
      - path
    default: none
  odj_blob_path:
    description:
      - The path to the file where the BLOB will be saved. If omitted, a temporary file will be used.
      - If I(offline_domain_join=output) the file will be deleted after its contents are returned.
      - The parent directory for the BLOB file must exist; intermediate directories will not be created.
notes:
  - "For more information on Offline Domain Join
    see L(the step-by-step guide,https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd392267%28v=ws.10%29)."
  - When using the ODJ BLOB to join a computer to the domain, it must be written out to a file.
  - The file must be UTF-16 encoded (in PowerShell this encoding is called C(Unicode)), and it must end in a null character. See examples.
  - The C(djoin.exe) part of the offline domain join process will not use I(domain_server), I(domain_username), or I(domain_password).
  - This must be run on a host that has the ActiveDirectory powershell module installed.
seealso:
- module: ansible.windows.win_domain
- module: ansible.windows.win_domain_controller
- module: community.windows.win_domain_group
- module: ansible.windows.win_domain_membership
- module: community.windows.win_domain_user
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
      $blob = [Convert]::FromBase64String('{{ computer_status.odj_blob }}')
      [IO.File]::WriteAllBytes('{{ target_blob_file }}', $blob)
      & djoin.exe --% /RequestODJ /LoadFile '{{ target_blob_file }}' /LocalOS /WindowsPath "%SystemRoot%"

  - name: Restart to complete domain join
    ansible.windows.win_restart:
'''

RETURN = r'''
odj_blob:
  description:
    - The offline domain join BLOB. This is an empty string when in check mode or when offline_domain_join is 'path'.
    - This field contains the base64 encoded raw bytes of the offline domain join BLOB file.
  returned: when offline_domain_join is not 'none' and the computer didn't exist
  type: str
  sample: <a long base64 string>
odj_blob_file:
  description: The path to the offline domain join BLOB file on the target host. If odj_blob_path was specified, this will match that path.
  returned: when offline_domain_join is 'path' and the computer didn't exist
  type: str
  sample: 'C:\Users\admin\AppData\Local\Temp\e4vxonty.rkb'
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
