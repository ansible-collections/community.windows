.. _community.windows.psexec_module:


************************
community.windows.psexec
************************

**Runs commands on a remote Windows host based on the PsExec model**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Runs a remote command from a Linux host to a Windows host without WinRM being set up.
- Can be run on the Ansible controller to bootstrap Windows hosts to get them ready for WinRM.



Requirements
------------
The below requirements are needed on the host that executes this module.

- pypsexec
- smbprotocol[kerberos] for optional Kerberos authentication


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
                    <b>arguments</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Any arguments as a single string to use when running the executable.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>asynchronous</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">boolean</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li><div style="color: blue"><b>no</b>&nbsp;&larr;</div></li>
                                    <li>yes</li>
                        </ul>
                </td>
                <td>
                        <div>Will run the command as a detached process and the module returns immediately after starting the process while the process continues to run in the background.</div>
                        <div>The <em>stdout</em> and <em>stderr</em> return values will be null when this is set to <code>yes</code>.</div>
                        <div>The <em>stdin</em> option does not work with this type of process.</div>
                        <div>The <em>rc</em> return value is not set when this is <code>yes</code></div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>connection_password</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The password for <em>connection_user</em>.</div>
                        <div>Required if the Kerberos requirements are not installed or the username is a local account to the Windows host.</div>
                        <div>Can be omitted to use a Kerberos principal ticket for the principal set by <em>connection_user</em> if the Kerberos library is installed and the ticket has already been retrieved with the <code>kinit</code> command before.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>connection_timeout</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>
                        <b>Default:</b><br/><div style="color: blue">60</div>
                </td>
                <td>
                        <div>The timeout in seconds to wait when receiving the initial SMB negotiate response from the server.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>connection_username</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The username to use when connecting to the remote Windows host.</div>
                        <div>This user must be a member of the <code>Administrators</code> group of the Windows host.</div>
                        <div>Required if the Kerberos requirements are not installed or the username is a local account to the Windows host.</div>
                        <div>Can be omitted to use the default Kerberos principal ticket in the local credential cache if the Kerberos library is installed.</div>
                        <div>If <em>process_username</em> is not specified, then the remote process will run under a Network Logon under this account.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>encrypt</b>
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
                        <div>Will use SMB encryption to encrypt the SMB messages sent to and from the host.</div>
                        <div>This requires the SMB 3 protocol which is only supported from Windows Server 2012 or Windows 8, older versions like Windows 7 or Windows Server 2008 (R2) must set this to <code>no</code> and use no encryption.</div>
                        <div>When setting to <code>no</code>, the packets are in plaintext and can be seen by anyone sniffing the network, any process options are included in this.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>executable</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                         / <span style="color: red">required</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The executable to run on the Windows host.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>hostname</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                         / <span style="color: red">required</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The remote Windows host to connect to, can be either an IP address or a hostname.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>integrity_level</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>limited</li>
                                    <li><div style="color: blue"><b>default</b>&nbsp;&larr;</div></li>
                                    <li>elevated</li>
                        </ul>
                </td>
                <td>
                        <div>The integrity level of the process when <em>process_username</em> is defined and is not equal to <code>System</code>.</div>
                        <div>When <code>default</code>, the default integrity level based on the system setup.</div>
                        <div>When <code>elevated</code>, the command will be run with Administrative rights.</div>
                        <div>When <code>limited</code>, the command will be forced to run with non-Administrative rights.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>interactive</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">boolean</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li><div style="color: blue"><b>no</b>&nbsp;&larr;</div></li>
                                    <li>yes</li>
                        </ul>
                </td>
                <td>
                        <div>Will run the process as an interactive process that shows a process Window of the Windows session specified by <em>interactive_session</em>.</div>
                        <div>The <em>stdout</em> and <em>stderr</em> return values will be null when this is set to <code>yes</code>.</div>
                        <div>The <em>stdin</em> option does not work with this type of process.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>interactive_session</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>
                        <b>Default:</b><br/><div style="color: blue">0</div>
                </td>
                <td>
                        <div>The Windows session ID to use when displaying the interactive process on the remote Windows host.</div>
                        <div>This is only valid when <em>interactive</em> is <code>yes</code>.</div>
                        <div>The default is <code>0</code> which is the console session of the Windows host.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>load_profile</b>
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
                        <div>Runs the remote command with the user&#x27;s profile loaded.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>port</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>
                        <b>Default:</b><br/><div style="color: blue">445</div>
                </td>
                <td>
                        <div>The port that the remote SMB service is listening on.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>priority</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>above_normal</li>
                                    <li>below_normal</li>
                                    <li>high</li>
                                    <li>idle</li>
                                    <li><div style="color: blue"><b>normal</b>&nbsp;&larr;</div></li>
                                    <li>realtime</li>
                        </ul>
                </td>
                <td>
                        <div>Set the command&#x27;s priority on the Windows host.</div>
                        <div>See <a href='https://msdn.microsoft.com/en-us/library/windows/desktop/ms683211.aspx'>https://msdn.microsoft.com/en-us/library/windows/desktop/ms683211.aspx</a> for more details.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>process_password</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The password for <em>process_username</em>.</div>
                        <div>Required if <em>process_username</em> is defined and not <code>System</code>.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>process_timeout</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>
                        <b>Default:</b><br/><div style="color: blue">0</div>
                </td>
                <td>
                        <div>The timeout in seconds that is placed upon the running process.</div>
                        <div>A value of <code>0</code> means no timeout.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>process_username</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The user to run the process as.</div>
                        <div>This can be set to run the process under an Interactive logon of the specified account which bypasses limitations of a Network logon used when this isn&#x27;t specified.</div>
                        <div>If omitted then the process is run under the same account as <em>connection_username</em> with a Network logon.</div>
                        <div>Set to <code>System</code> to run as the builtin SYSTEM account, no password is required with this account.</div>
                        <div>If <em>encrypt</em> is <code>no</code>, the username and password are sent as a simple XOR scrambled byte string that is not encrypted. No special tools are required to get the username and password just knowledge of the protocol.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>show_ui_on_logon_screen</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">boolean</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li><div style="color: blue"><b>no</b>&nbsp;&larr;</div></li>
                                    <li>yes</li>
                        </ul>
                </td>
                <td>
                        <div>Shows the process UI on the Winlogon secure desktop when <em>process_username</em> is <code>System</code>.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>stdin</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Data to send on the stdin pipe once the process has started.</div>
                        <div>This option has no effect when <em>interactive</em> or <em>asynchronous</em> is <code>yes</code>.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>working_directory</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <b>Default:</b><br/><div style="color: blue">"C:\\Windows\\System32"</div>
                </td>
                <td>
                        <div>Changes the working directory set when starting the process.</div>
                </td>
            </tr>
    </table>
    <br/>


Notes
-----

.. note::
   - This module requires the Windows host to have SMB configured and enabled, and port 445 opened on the firewall.
   - This module will wait until the process is finished unless *asynchronous* is ``yes``, ensure the process is run as a non-interactive command to avoid infinite hangs waiting for input.
   - The *connection_username* must be a member of the local Administrator group of the Windows host. For non-domain joined hosts, the ``LocalAccountTokenFilterPolicy`` should be set to ``1`` to ensure this works, see https://support.microsoft.com/en-us/help/951016/description-of-user-account-control-and-remote-restrictions-in-windows.
   - For more information on this module and the various host requirements, see https://github.com/jborean93/pypsexec.


See Also
--------

.. seealso::

   :ref:`ansible.builtin.raw_module`
      The official documentation on the **ansible.builtin.raw** module.
   :ref:`ansible.windows.win_command_module`
      The official documentation on the **ansible.windows.win_command** module.
   :ref:`community.windows.win_psexec_module`
      The official documentation on the **community.windows.win_psexec** module.
   :ref:`ansible.windows.win_shell_module`
      The official documentation on the **ansible.windows.win_shell** module.


Examples
--------

.. code-block:: yaml

    - name: Run a cmd.exe command
      community.windows.psexec:
        hostname: server
        connection_username: username
        connection_password: password
        executable: cmd.exe
        arguments: /c echo Hello World

    - name: Run a PowerShell command
      community.windows.psexec:
        hostname: server.domain.local
        connection_username: username@DOMAIN.LOCAL
        connection_password: password
        executable: powershell.exe
        arguments: Write-Host Hello World

    - name: Send data through stdin
      community.windows.psexec:
        hostname: 192.168.1.2
        connection_username: username
        connection_password: password
        executable: powershell.exe
        arguments: '-'
        stdin: |
          Write-Host Hello World
          Write-Error Error Message
          exit 0

    - name: Run the process as a different user
      community.windows.psexec:
        hostname: server
        connection_user: username
        connection_password: password
        executable: whoami.exe
        arguments: /all
        process_username: anotheruser
        process_password: anotherpassword

    - name: Run the process asynchronously
      community.windows.psexec:
        hostname: server
        connection_username: username
        connection_password: password
        executable: cmd.exe
        arguments: /c rmdir C:\temp
        asynchronous: yes

    - name: Use Kerberos authentication for the connection (requires smbprotocol[kerberos])
      community.windows.psexec:
        hostname: host.domain.local
        connection_username: user@DOMAIN.LOCAL
        executable: C:\some\path\to\executable.exe
        arguments: /s

    - name: Disable encryption to work with WIndows 7/Server 2008 (R2)
      community.windows.psexec:
        hostanme: windows-pc
        connection_username: Administrator
        connection_password: Password01
        encrypt: no
        integrity_level: elevated
        process_username: Administrator
        process_password: Password01
        executable: powershell.exe
        arguments: (New-Object -ComObject Microsoft.Update.Session).CreateUpdateInstaller().IsBusy

    - name: Download and run ConfigureRemotingForAnsible.ps1 to setup WinRM
      community.windows.psexec:
        hostname: '{{ hostvars[inventory_hostname]["ansible_host"] | default(inventory_hostname) }}'
        connection_username: '{{ ansible_user }}'
        connection_password: '{{ ansible_password }}'
        encrypt: yes
        executable: powershell.exe
        arguments: '-'
        stdin: |
          $ErrorActionPreference = "Stop"
          $sec_protocols = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::SystemDefault
          $sec_protocols = $sec_protocols -bor [Net.SecurityProtocolType]::Tls12
          [Net.ServicePointManager]::SecurityProtocol = $sec_protocols
          $url = "https://github.com/ansible/ansible/raw/devel/examples/scripts/ConfigureRemotingForAnsible.ps1"
          Invoke-Expression ((New-Object Net.WebClient).DownloadString($url))
          exit
      delegate_to: localhost



Return Values
-------------
Common return values are documented `here <https://docs.ansible.com/ansible/latest/reference_appendices/common_return_values.html#common-return-values>`_, the following are the fields unique to this module:

.. raw:: html

    <table border=0 cellpadding=0 class="documentation-table">
        <tr>
            <th colspan="1">Key</th>
            <th>Returned</th>
            <th width="100%">Description</th>
        </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>msg</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>module failed</td>
                <td>
                            <div>Any exception details when trying to run the process</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">Received exception from remote PAExec service: Failed to start &quot;invalid.exe&quot;. The system cannot find the file specified. [Err=0x2, 2]</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>pid</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>success and asynchronous is &#x27;yes&#x27;</td>
                <td>
                            <div>The process ID of the asynchronous process that was created</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">719</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>rc</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>success and asynchronous is &#x27;no&#x27;</td>
                <td>
                            <div>The return code of the remote process</div>
                    <br/>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>stderr</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>success and interactive or asynchronous is &#x27;no&#x27;</td>
                <td>
                            <div>The stderr from the remote process</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">Error [10] running process</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>stdout</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>success and interactive or asynchronous is &#x27;no&#x27;</td>
                <td>
                            <div>The stdout from the remote process</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">Hello World</div>
                </td>
            </tr>
    </table>
    <br/><br/>


Status
------


Authors
~~~~~~~

- Jordan Borean (@jborean93)
