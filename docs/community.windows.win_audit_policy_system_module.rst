.. _community.windows.win_audit_policy_system_module:


*****************************************
community.windows.win_audit_policy_system
*****************************************

**Used to make changes to the system wide Audit Policy**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Used to make changes to the system wide Audit Policy.




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
                    <b>audit_type</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">list</span>
                         / <span style="color: purple">elements=string</span>
                         / <span style="color: red">required</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>failure</li>
                                    <li>none</li>
                                    <li>success</li>
                        </ul>
                </td>
                <td>
                        <div>The type of event you would like to audit for.</div>
                        <div>Accepts a list. See examples.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>category</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Single string value for the category you would like to adjust the policy on.</div>
                        <div>Cannot be used with <em>subcategory</em>. You must define one or the other.</div>
                        <div>Changing this setting causes all subcategories to be adjusted to the defined <em>audit_type</em>.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>subcategory</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Single string value for the subcategory you would like to adjust the policy on.</div>
                        <div>Cannot be used with <em>category</em>. You must define one or the other.</div>
                </td>
            </tr>
    </table>
    <br/>


Notes
-----

.. note::
   - It is recommended to take a backup of the policies before adjusting them for the first time.
   - See this page for in depth information https://technet.microsoft.com/en-us/library/cc766468.aspx.


See Also
--------

.. seealso::

   :ref:`community.windows.win_audit_rule_module`
      The official documentation on the **community.windows.win_audit_rule** module.


Examples
--------

.. code-block:: yaml

    - name: Enable failure auditing for the subcategory "File System"
      community.windows.win_audit_policy_system:
        subcategory: File System
        audit_type: failure

    - name: Enable all auditing types for the category "Account logon events"
      community.windows.win_audit_policy_system:
        category: Account logon events
        audit_type: success, failure

    - name: Disable auditing for the subcategory "File System"
      community.windows.win_audit_policy_system:
        subcategory: File System
        audit_type: none



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
                    <b>current_audit_policy</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">dictionary</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>details on the policy being targetted</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">{
      &quot;File Share&quot;:&quot;failure&quot;
    }</div>
                </td>
            </tr>
    </table>
    <br/><br/>


Status
------


Authors
~~~~~~~

- Noah Sparks (@nwsparks)
