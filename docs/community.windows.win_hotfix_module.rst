.. _community.windows.win_hotfix_module:


****************************
community.windows.win_hotfix
****************************

**Install and uninstalls Windows hotfixes**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Install, uninstall a Windows hotfix.




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
                    <b>hotfix_identifier</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The name of the hotfix as shown in DISM, see examples for details.</div>
                        <div>This or <code>hotfix_kb</code> MUST be set when <code>state=absent</code>.</div>
                        <div>If <code>state=present</code> then the hotfix at <code>source</code> will be validated against this value, if it does not match an error will occur.</div>
                        <div>You can get the identifier by running &#x27;Get-WindowsPackage -Online -PackagePath path-to-cab-in-msu&#x27; after expanding the msu file.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>hotfix_kb</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The name of the KB the hotfix relates to, see examples for details.</div>
                        <div>This or <code>hotfix_identifier</code> MUST be set when <code>state=absent</code>.</div>
                        <div>If <code>state=present</code> then the hotfix at <code>source</code> will be validated against this value, if it does not match an error will occur.</div>
                        <div>Because DISM uses the identifier as a key and doesn&#x27;t refer to a KB in all cases it is recommended to use <code>hotfix_identifier</code> instead.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>source</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">path</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The path to the downloaded hotfix .msu file.</div>
                        <div>This MUST be set if <code>state=present</code> and MUST be a .msu hotfix file.</div>
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
                        <div>Whether to install or uninstall the hotfix.</div>
                        <div>When <code>present</code>, <code>source</code> MUST be set.</div>
                        <div>When <code>absent</code>, <code>hotfix_identifier</code> or <code>hotfix_kb</code> MUST be set.</div>
                </td>
            </tr>
    </table>
    <br/>


Notes
-----

.. note::
   - This must be run on a host that has the DISM powershell module installed and a Powershell version >= 4.
   - This module is installed by default on Windows 8 and Server 2012 and newer.
   - You can manually install this module on Windows 7 and Server 2008 R2 by installing the Windows ADK https://developer.microsoft.com/en-us/windows/hardware/windows-assessment-deployment-kit, see examples to see how to do it with chocolatey.
   - You can download hotfixes from https://www.catalog.update.microsoft.com/Home.aspx.


See Also
--------

.. seealso::

   :ref:`ansible.windows.win_package_module`
      The official documentation on the **ansible.windows.win_package** module.
   :ref:`ansible.windows.win_updates_module`
      The official documentation on the **ansible.windows.win_updates** module.


Examples
--------

.. code-block:: yaml

    - name: Install Windows ADK with DISM for Server 2008 R2
      chocolatey.chocolatey.win_chocolatey:
        name: windows-adk
        version: 8.100.26866.0
        state: present
        install_args: /features OptionId.DeploymentTools

    - name: Install hotfix without validating the KB and Identifier
      community.windows.win_hotfix:
        source: C:\temp\windows8.1-kb3172729-x64_e8003822a7ef4705cbb65623b72fd3cec73fe222.msu
        state: present
      register: hotfix_install

    - ansible.windows.win_reboot:
      when: hotfix_install.reboot_required

    - name: Install hotfix validating KB
      community.windows.win_hotfix:
        hotfix_kb: KB3172729
        source: C:\temp\windows8.1-kb3172729-x64_e8003822a7ef4705cbb65623b72fd3cec73fe222.msu
        state: present
      register: hotfix_install

    - ansible.windows.win_reboot:
      when: hotfix_install.reboot_required

    - name: Install hotfix validating Identifier
      community.windows.win_hotfix:
        hotfix_identifier: Package_for_KB3172729~31bf3856ad364e35~amd64~~6.3.1.0
        source: C:\temp\windows8.1-kb3172729-x64_e8003822a7ef4705cbb65623b72fd3cec73fe222.msu
        state: present
      register: hotfix_install

    - ansible.windows.win_reboot:
      when: hotfix_install.reboot_required

    - name: Uninstall hotfix with Identifier
      community.windows.win_hotfix:
        hotfix_identifier: Package_for_KB3172729~31bf3856ad364e35~amd64~~6.3.1.0
        state: absent
      register: hotfix_uninstall

    - ansible.windows.win_reboot:
      when: hotfix_uninstall.reboot_required

    - name: Uninstall hotfix with KB (not recommended)
      community.windows.win_hotfix:
        hotfix_kb: KB3172729
        state: absent
      register: hotfix_uninstall

    - ansible.windows.win_reboot:
      when: hotfix_uninstall.reboot_required



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
                    <b>identifier</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>success</td>
                <td>
                            <div>The DISM identifier for the hotfix.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">Package_for_KB3172729~31bf3856ad364e35~amd64~~6.3.1.0</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>identifiers</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">list</span>
                       / <span style="color: purple">elements=string</span>
                    </div>
                    <div style="font-style: italic; font-size: small; color: darkgreen">added in 1.10.0</div>
                </td>
                <td>success</td>
                <td>
                            <div>The DISM identifiers for each hotfix in the msu.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">[&#x27;Package_for_KB3172729~31bf3856ad364e35~amd64~~6.3.1.0&#x27;]</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>kb</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>success</td>
                <td>
                            <div>The KB the hotfix relates to.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">KB3172729</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>kbs</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">list</span>
                       / <span style="color: purple">elements=string</span>
                    </div>
                    <div style="font-style: italic; font-size: small; color: darkgreen">added in 1.10.0</div>
                </td>
                <td>success</td>
                <td>
                            <div>The KB for each hotfix in the msu,</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">[&#x27;KB3172729&#x27;]</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>reboot_required</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>success</td>
                <td>
                            <div>Whether a reboot is required for the install or uninstall to finalise.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">True</div>
                </td>
            </tr>
    </table>
    <br/><br/>


Status
------


Authors
~~~~~~~

- Jordan Borean (@jborean93)
