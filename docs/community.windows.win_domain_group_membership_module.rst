.. _community.windows.win_domain_group_membership_module:


*********************************************
community.windows.win_domain_group_membership
*********************************************

**Manage Windows domain group membership**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Allows the addition and removal of domain users and domain groups from/to a domain group.




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
                    <b>members</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">list</span>
                         / <span style="color: purple">elements=string</span>
                         / <span style="color: red">required</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>A list of members to ensure are present/absent from the group.</div>
                        <div>The given names must be a SamAccountName of a user, group, service account, or computer.</div>
                        <div>For computers, you must add &quot;$&quot; after the name; for example, to add &quot;Mycomputer&quot; to a group, use &quot;Mycomputer$&quot; as the member.</div>
                        <div>If the member object is part of another domain in a multi-domain forest, you must add the domain and &quot;\&quot; in front of the name.</div>
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
                        <div>Name of the domain group to manage membership on.</div>
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
                                    <li>pure</li>
                        </ul>
                </td>
                <td>
                        <div>Desired state of the members in the group.</div>
                        <div>When <code>state</code> is <code>pure</code>, only the members specified will exist, and all other existing members not specified are removed.</div>
                </td>
            </tr>
    </table>
    <br/>


Notes
-----

.. note::
   - This must be run on a host that has the ActiveDirectory powershell module installed.


See Also
--------

.. seealso::

   :ref:`community.windows.win_domain_user_module`
      The official documentation on the **community.windows.win_domain_user** module.
   :ref:`community.windows.win_domain_group_module`
      The official documentation on the **community.windows.win_domain_group** module.


Examples
--------

.. code-block:: yaml

    - name: Add a domain user/group to a domain group
      community.windows.win_domain_group_membership:
        name: Foo
        members:
          - Bar
        state: present

    - name: Remove a domain user/group from a domain group
      community.windows.win_domain_group_membership:
        name: Foo
        members:
          - Bar
        state: absent

    - name: Ensure only a domain user/group exists in a domain group
      community.windows.win_domain_group_membership:
        name: Foo
        members:
          - Bar
        state: pure

    - name: Add a computer to a domain group
      community.windows.win_domain_group_membership:
        name: Foo
        members:
          - DESKTOP$
        state: present

    - name: Add a domain user/group from another Domain in the multi-domain forest to a domain group
      community.windows.win_domain_group_membership:
        domain_server: DomainAAA.cloud
        name: GroupinDomainAAA
        members:
          - DomainBBB.cloud\UserInDomainBBB
        state: Present



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
                    <b>added</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">list</span>
                    </div>
                </td>
                <td>success and <code>state</code> is <code>present</code> or <code>pure</code></td>
                <td>
                            <div>A list of members added when <code>state</code> is <code>present</code> or <code>pure</code>; this is empty if no members are added.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">[&#x27;UserName&#x27;, &#x27;GroupName&#x27;]</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>members</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">list</span>
                    </div>
                </td>
                <td>success</td>
                <td>
                            <div>A list of all domain group members at completion; this is empty if the group contains no members.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">[&#x27;UserName&#x27;, &#x27;GroupName&#x27;]</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>name</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>The name of the target domain group.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">Domain-Admins</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>removed</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">list</span>
                    </div>
                </td>
                <td>success and <code>state</code> is <code>absent</code> or <code>pure</code></td>
                <td>
                            <div>A list of members removed when <code>state</code> is <code>absent</code> or <code>pure</code>; this is empty if no members are removed.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">[&#x27;UserName&#x27;, &#x27;GroupName&#x27;]</div>
                </td>
            </tr>
    </table>
    <br/><br/>


Status
------


Authors
~~~~~~~

- Marius Rieder (@jiuka)
