.. _community.windows.win_security_policy_module:


*************************************
community.windows.win_security_policy
*************************************

**Change local security policy settings**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Allows you to set the local security policies that are configured by SecEdit.exe.




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
                    <b>key</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                         / <span style="color: red">required</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The ini key of the section or policy name to modify.</div>
                        <div>The module will return an error if this key is invalid.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>section</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                         / <span style="color: red">required</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The ini section the key exists in.</div>
                        <div>If the section does not exist then the module will return an error.</div>
                        <div>Example sections to use are &#x27;Account Policies&#x27;, &#x27;Local Policies&#x27;, &#x27;Event Log&#x27;, &#x27;Restricted Groups&#x27;, &#x27;System Services&#x27;, &#x27;Registry&#x27; and &#x27;File System&#x27;</div>
                        <div>If wanting to edit the <code>Privilege Rights</code> section, use the <span class='module'>ansible.windows.win_user_right</span> module instead.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>value</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                         / <span style="color: red">required</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The value for the ini key or policy name.</div>
                        <div>If the key takes in a boolean value then 0 = False and 1 = True.</div>
                </td>
            </tr>
    </table>
    <br/>


Notes
-----

.. note::
   - This module uses the SecEdit.exe tool to configure the values, more details of the areas and keys that can be configured can be found here https://msdn.microsoft.com/en-us/library/bb742512.aspx.
   - If you are in a domain environment these policies may be set by a GPO policy, this module can temporarily change these values but the GPO will override it if the value differs.
   - You can also run ``SecEdit.exe /export /cfg C:\temp\output.ini`` to view the current policies set on your system.
   - When assigning user rights, use the :ref:`ansible.windows.win_user_right <ansible.windows.win_user_right_module>` module instead.


See Also
--------

.. seealso::

   :ref:`ansible.windows.win_user_right_module`
      The official documentation on the **ansible.windows.win_user_right** module.


Examples
--------

.. code-block:: yaml

    - name: Change the guest account name
      community.windows.win_security_policy:
        section: System Access
        key: NewGuestName
        value: Guest Account

    - name: Set the maximum password age
      community.windows.win_security_policy:
        section: System Access
        key: MaximumPasswordAge
        value: 15

    - name: Do not store passwords using reversible encryption
      community.windows.win_security_policy:
        section: System Access
        key: ClearTextPassword
        value: 0

    - name: Enable system events
      community.windows.win_security_policy:
        section: Event Audit
        key: AuditSystemEvents
        value: 1



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
                    <b>import_log</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>secedit.exe /import run and change occurred</td>
                <td>
                            <div>The log of the SecEdit.exe /configure job that configured the local policies. This is used for debugging purposes on failures.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">Completed 6 percent (0/15) \tProcess Privilege Rights area.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>key</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>success</td>
                <td>
                            <div>The key in the section passed to the module to modify.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">NewGuestName</div>
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
                <td>failure with secedit calls</td>
                <td>
                            <div>The return code after a failure when running SecEdit.exe.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">-1</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>section</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>success</td>
                <td>
                            <div>The section passed to the module to modify.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">System Access</div>
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
                <td>failure with secedit calls</td>
                <td>
                            <div>The output of the STDERR buffer after a failure when running SecEdit.exe.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">failed to import security policy</div>
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
                <td>failure with secedit calls</td>
                <td>
                            <div>The output of the STDOUT buffer after a failure when running SecEdit.exe.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">check log for error details</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>value</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>success</td>
                <td>
                            <div>The value passed to the module to modify to.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">Guest Account</div>
                </td>
            </tr>
    </table>
    <br/><br/>


Status
------


Authors
~~~~~~~

- Jordan Borean (@jborean93)
