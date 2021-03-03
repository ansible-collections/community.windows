.. _community.windows.win_audit_rule_module:


********************************
community.windows.win_audit_rule
********************************

**Adds an audit rule to files, folders, or registry keys**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Used to apply audit rules to files, folders or registry keys.
- Once applied, it will begin recording the user who performed the operation defined into the Security Log in the Event viewer.
- The behavior is designed to ignore inherited rules since those cannot be adjusted without first disabling the inheritance behavior. It will still print inherited rules in the output though for debugging purposes.




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
                    <b>audit_flags</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">list</span>
                         / <span style="color: red">required</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>Failure</li>
                                    <li>Success</li>
                        </ul>
                </td>
                <td>
                        <div>Defines whether to log on failure, success, or both.</div>
                        <div>To log both define as comma separated list &quot;Success, Failure&quot;.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>inheritance_flags</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">list</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>ContainerInherit</li>
                                    <li>ObjectInherit</li>
                        </ul>
                        <b>Default:</b><br/><div style="color: blue">"ContainerInherit,ObjectInherit"</div>
                </td>
                <td>
                        <div>Defines what objects inside of a folder or registry key will inherit the settings.</div>
                        <div>If you are setting a rule on a file, this value has to be changed to <code>none</code>.</div>
                        <div>For more information on the choices see MSDN PropagationFlags enumeration at <a href='https://msdn.microsoft.com/en-us/library/system.security.accesscontrol.inheritanceflags.aspx'>https://msdn.microsoft.com/en-us/library/system.security.accesscontrol.inheritanceflags.aspx</a>.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>path</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">path</span>
                         / <span style="color: red">required</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Path to the file, folder, or registry key.</div>
                        <div>Registry paths should be in Powershell format, beginning with an abbreviation for the root such as, <code>HKLM:\Software</code>.</div>
                        <div style="font-size: small; color: darkgreen"><br/>aliases: dest, destination</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>propagation_flags</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">-</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li><div style="color: blue"><b>None</b>&nbsp;&larr;</div></li>
                                    <li>InherityOnly</li>
                                    <li>NoPropagateInherit</li>
                        </ul>
                </td>
                <td>
                        <div>Propagation flag on the audit rules.</div>
                        <div>This value is ignored when the path type is a file.</div>
                        <div>For more information on the choices see MSDN PropagationFlags enumeration at <a href='https://msdn.microsoft.com/en-us/library/system.security.accesscontrol.propagationflags.aspx'>https://msdn.microsoft.com/en-us/library/system.security.accesscontrol.propagationflags.aspx</a>.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>rights</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">list</span>
                         / <span style="color: red">required</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Comma separated list of the rights desired. Only required for adding a rule.</div>
                        <div>If <em>path</em> is a file or directory, rights can be any right under MSDN FileSystemRights <a href='https://msdn.microsoft.com/en-us/library/system.security.accesscontrol.filesystemrights.aspx'>https://msdn.microsoft.com/en-us/library/system.security.accesscontrol.filesystemrights.aspx</a>.</div>
                        <div>If <em>path</em> is a registry key, rights can be any right under MSDN RegistryRights <a href='https://msdn.microsoft.com/en-us/library/system.security.accesscontrol.registryrights.aspx'>https://msdn.microsoft.com/en-us/library/system.security.accesscontrol.registryrights.aspx</a>.</div>
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
                        <div>Whether the rule should be <code>present</code> or <code>absent</code>.</div>
                        <div>For absent, only <em>path</em>, <em>user</em>, and <em>state</em> are required.</div>
                        <div>Specifying <code>absent</code> will remove all rules matching the defined <em>user</em>.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>user</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                         / <span style="color: red">required</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The user or group to adjust rules for.</div>
                </td>
            </tr>
    </table>
    <br/>



See Also
--------

.. seealso::

   :ref:`community.windows.win_audit_policy_system_module`
      The official documentation on the **community.windows.win_audit_policy_system** module.


Examples
--------

.. code-block:: yaml

    - name: Add filesystem audit rule for a folder
      community.windows.win_audit_rule:
        path: C:\inetpub\wwwroot\website
        user: BUILTIN\Users
        rights: write,delete,changepermissions
        audit_flags: success,failure
        inheritance_flags: ContainerInherit,ObjectInherit

    - name: Add filesystem audit rule for a file
      community.windows.win_audit_rule:
        path: C:\inetpub\wwwroot\website\web.config
        user: BUILTIN\Users
        rights: write,delete,changepermissions
        audit_flags: success,failure
        inheritance_flags: None

    - name: Add registry audit rule
      community.windows.win_audit_rule:
        path: HKLM:\software
        user: BUILTIN\Users
        rights: delete
        audit_flags: 'success'

    - name: Remove filesystem audit rule
      community.windows.win_audit_rule:
        path: C:\inetpub\wwwroot\website
        user: BUILTIN\Users
        state: absent

    - name: Remove registry audit rule
      community.windows.win_audit_rule:
        path: HKLM:\software
        user: BUILTIN\Users
        state: absent



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
                    <b>current_audit_rules</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">dictionary</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>The current rules on the defined <em>path</em></div>
                            <div>Will return &quot;No audit rules defined on <em>path</em>&quot;</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">{
      &quot;audit_flags&quot;: &quot;Success&quot;,
      &quot;user&quot;: &quot;Everyone&quot;,
      &quot;inheritance_flags&quot;: &quot;False&quot;,
      &quot;is_inherited&quot;: &quot;False&quot;,
      &quot;propagation_flags&quot;: &quot;None&quot;,
      &quot;rights&quot;: &quot;Delete&quot;
    }</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>path_type</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>The type of <em>path</em> being targetted.</div>
                            <div>Will be one of file, directory, registry.</div>
                    <br/>
                </td>
            </tr>
    </table>
    <br/><br/>


Status
------


Authors
~~~~~~~

- Noah Sparks (@nwsparks)
