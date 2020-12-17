.. _community.windows.win_domain_computer_module:


*************************************
community.windows.win_domain_computer
*************************************

**Manage computers in Active Directory**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Create, read, update and delete computers in Active Directory using a windows bridge computer to launch New-ADComputer, Get-ADComputer, Set-ADComputer, Remove-ADComputer and Move-ADObject powershell commands.




Parameters
----------

.. raw:: html

    <table  border=0 cellpadding=0 class="documentation-table">
        <tr>
            <th colspan="1">Parameter</th>
            <th>Choices/<font color="blue">Defaults</font></th>
            <th width="100%">Comments</th>
        </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>description</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <b>Default:</b><br/><div style="color: blue">""</div>
                </td>
                <td>
                        <div>Specifies a description of the object.</div>
                        <div>This parameter sets the value of the Description property for the object.</div>
                        <div>The LDAP display name (ldapDisplayName) for this property is description.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>dns_hostname</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Specifies the fully qualified domain name (FQDN) of the computer.</div>
                        <div>This parameter sets the DNSHostName property for a computer object.</div>
                        <div>The LDAP display name for this property is dNSHostName.</div>
                        <div>Required when <em>state=present</em>.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>domain_password</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The password for <em>username</em>.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>domain_server</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Specifies the Active Directory Domain Services instance to connect to.</div>
                        <div>Can be in the form of an FQDN or NetBIOS name.</div>
                        <div>If not specified then the value is based on the domain of the computer running PowerShell.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>domain_username</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The username to use when interacting with AD.</div>
                        <div>If this is not set then the user Ansible used to log in with will be used instead when using CredSSP or Kerberos with credential delegation.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>enabled</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">boolean</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>no</li>
                                    <li><div style="color: blue"><b>yes</b>&nbsp;&larr;</div></li>
                        </ul>
                </td>
                <td>
                        <div>Specifies if an account is enabled.</div>
                        <div>An enabled account requires a password.</div>
                        <div>This parameter sets the Enabled property for an account object.</div>
                        <div>This parameter also sets the ADS_UF_ACCOUNTDISABLE flag of the Active Directory User Account Control (UAC) attribute.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>name</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                         / <span style="color: red">required</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Specifies the name of the object.</div>
                        <div>This parameter sets the Name property of the Active Directory object.</div>
                        <div>The LDAP display name (ldapDisplayName) of this property is name.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>odj_blob_path</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">-</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The path to the file where the BLOB will be saved. If omitted, a temporary file will be used.</div>
                        <div>If <em>offline_domain_join=output</em> the file will be deleted after its contents are returned.</div>
                        <div>The parent directory for the BLOB file must exist; intermediate directories will not be created.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>offline_domain_join</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li><div style="color: blue"><b>none</b>&nbsp;&larr;</div></li>
                                    <li>output</li>
                                    <li>path</li>
                        </ul>
                </td>
                <td>
                        <div>Provisions a computer in the directory and provides a BLOB file that can be used on the target computer/image to join it to the domain while offline.</div>
                        <div>The <code>none</code> value doesn&#x27;t do any offline join operations.</div>
                        <div><code>output</code> returns the BLOB in output. The BLOB should be treated as secret (it contains the machine password) so use <code>no_log</code> when using this option.</div>
                        <div><code>path</code> preserves the offline domain join BLOB file on the target machine for later use. The path will be returned.</div>
                        <div>If the computer already exists, no BLOB will be created/returned, and the module will operate as it would have without offline domain join.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>ou</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Specifies the X.500 path of the Organizational Unit (OU) or container where the new object is created. Required when <em>state=present</em>.</div>
                        <div>Special characters must be escaped, see <a href='https://docs.microsoft.com/en-us/previous-versions/windows/desktop/ldap/distinguished-names'>Distinguished Names</a> for details.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>sam_account_name</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Specifies the Security Account Manager (SAM) account name of the computer.</div>
                        <div>It maximum is 256 characters, 15 is advised for older operating systems compatibility.</div>
                        <div>The LDAP display name (ldapDisplayName) for this property is sAMAccountName.</div>
                        <div>If ommitted the value is the same as <code>name</code>.</div>
                        <div>Note that all computer SAMAccountNames need to end with a <code>$</code>.</div>
                        <div>If <code>$</code> is omitted, it will be added to the end.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>state</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>absent</li>
                                    <li><div style="color: blue"><b>present</b>&nbsp;&larr;</div></li>
                        </ul>
                </td>
                <td>
                        <div>Specified whether the computer should be <code>present</code> or <code>absent</code> in Active Directory.</div>
                </td>
            </tr>
    </table>
    <br/>


Notes
-----

.. note::
   - For more information on Offline Domain Join see `the step-by-step guide <https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd392267%28v=ws.10%29>`_.
   - When using the ODJ BLOB to join a computer to the domain, it must be written out to a file.
   - The file must be UTF-16 encoded (in PowerShell this encoding is called ``Unicode``), and it must end in a null character. See examples.
   - The ``djoin.exe`` part of the offline domain join process will not use *domain_server*, *domain_username*, or *domain_password*.


See Also
--------

.. seealso::

   :ref:`ansible.windows.win_domain_module`
      The official documentation on the **ansible.windows.win_domain** module.
   :ref:`ansible.windows.win_domain_controller_module`
      The official documentation on the **ansible.windows.win_domain_controller** module.
   :ref:`community.windows.win_domain_group_module`
      The official documentation on the **community.windows.win_domain_group** module.
   :ref:`ansible.windows.win_domain_membership_module`
      The official documentation on the **ansible.windows.win_domain_membership** module.
   :ref:`community.windows.win_domain_user_module`
      The official documentation on the **community.windows.win_domain_user** module.


Examples
--------

.. code-block:: yaml

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



Return Values
-------------
Common return values are documented `here <https://docs.ansible.com/ansible/latest/reference_appendices/common_return_values.html#common-return-values>`_, the following are the fields unique to this module:

.. raw:: html

    <table border=0 cellpadding=0 class="documentation-table">
        <tr>
            <th colspan="2">Key</th>
            <th>Returned</th>
            <th width="100%">Description</th>
        </tr>
            <tr>
                <td colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>djoin</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">dictionary</span>
                    </div>
                </td>
                <td>when offline_domain_join is True and the computer didn&#x27;t exist</td>
                <td>
                            <div>Information about the invocation of djoin.exe.</div>
                    <br/>
                </td>
            </tr>
                                <tr>
                    <td class="elbow-placeholder">&nbsp;</td>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>invocation</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>The full command line used to call djoin.exe</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">djoin.exe /PROVISION /MACHINE compname /MACHINEOU OU=Hosts,DC=ansible,DC=local /DOMAIN ansible.local /SAVEFILE blobfile.txt</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder">&nbsp;</td>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>rc</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>when not check mode</td>
                <td>
                            <div>The return code from djoin.exe</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">87</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder">&nbsp;</td>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>stderr</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>when not check mode</td>
                <td>
                            <div>The stderr from djoin.exe</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">Invalid input parameter combination.</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder">&nbsp;</td>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>stdout</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>when not check mode</td>
                <td>
                            <div>The stdout from djoin.exe</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">Computer provisioning completed successfully.</div>
                </td>
            </tr>

            <tr>
                <td colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>odj_blob</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>when offline_domain_join is not &#x27;none&#x27; and the computer didn&#x27;t exist</td>
                <td>
                            <div>The offline domain join BLOB. This is an empty string when in check mode or when offline_domain_join is &#x27;path&#x27;.</div>
                            <div>This field contains the base64 encoded raw bytes of the offline domain join BLOB file.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">&lt;a long base64 string&gt;</div>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>odj_blob_file</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>when offline_domain_join is &#x27;path&#x27; and the computer didn&#x27;t exist</td>
                <td>
                            <div>The path to the offline domain join BLOB file on the target host. If odj_blob_path was specified, this will match that path.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">C:\Users\admin\AppData\Local\Temp\e4vxonty.rkb</div>
                </td>
            </tr>
    </table>
    <br/><br/>


Status
------


Authors
~~~~~~~

- Daniel Sánchez Fábregas (@Daniel-Sanchez-Fabregas)
- Brian Scholer (@briantist)
