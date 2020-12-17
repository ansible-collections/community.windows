.. _community.windows.win_domain_group_module:


**********************************
community.windows.win_domain_group
**********************************

**Creates, modifies or removes domain groups**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Creates, modifies or removes groups in Active Directory.
- For local groups, use the :ref:`ansible.windows.win_group <ansible.windows.win_group_module>` module instead.




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
                    <b>attributes</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">dictionary</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>A dict of custom LDAP attributes to set on the group.</div>
                        <div>This can be used to set custom attributes that are not exposed as module parameters, e.g. <code>mail</code>.</div>
                        <div>See the examples on how to format this parameter.</div>
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
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>distribution</li>
                                    <li>security</li>
                        </ul>
                </td>
                <td>
                        <div>The category of the group, this is the value to assign to the LDAP <code>groupType</code> attribute.</div>
                        <div>If a new group is created then <code>security</code> will be used by default.</div>
                </td>
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
                </td>
                <td>
                        <div>The value to be assigned to the LDAP <code>description</code> attribute.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>display_name</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The value to assign to the LDAP <code>displayName</code> attribute.</div>
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
                        <div>The password for <code>username</code>.</div>
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
                        <div>If this is not set then the user Ansible used to log in with will be used instead.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>ignore_protection</b>
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
                        <div>Will ignore the <code>ProtectedFromAccidentalDeletion</code> flag when deleting or moving a group.</div>
                        <div>The module will fail if one of these actions need to occur and this value is set to <code>no</code>.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>managed_by</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The value to be assigned to the LDAP <code>managedBy</code> attribute.</div>
                        <div>This value can be in the forms <code>Distinguished Name</code>, <code>objectGUID</code>, <code>objectSid</code> or <code>sAMAccountName</code>, see examples for more details.</div>
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
                        <div>The name of the group to create, modify or remove.</div>
                        <div>This value can be in the forms <code>Distinguished Name</code>, <code>objectGUID</code>, <code>objectSid</code> or <code>sAMAccountName</code>, see examples for more details.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>organizational_unit</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The full LDAP path to create or move the group to.</div>
                        <div>This should be the path to the parent object to create or move the group to.</div>
                        <div>See examples for details of how this path is formed.</div>
                        <div style="font-size: small; color: darkgreen"><br/>aliases: ou, path</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>protect</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">boolean</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>no</li>
                                    <li>yes</li>
                        </ul>
                </td>
                <td>
                        <div>Will set the <code>ProtectedFromAccidentalDeletion</code> flag based on this value.</div>
                        <div>This flag stops a user from deleting or moving a group to a different path.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>scope</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>domainlocal</li>
                                    <li>global</li>
                                    <li>universal</li>
                        </ul>
                </td>
                <td>
                        <div>The scope of the group.</div>
                        <div>If <code>state=present</code> and the group doesn&#x27;t exist then this must be set.</div>
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
                        <div>If <code>state=present</code> this module will ensure the group is created and is configured accordingly.</div>
                        <div>If <code>state=absent</code> this module will delete the group if it exists</div>
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

   :ref:`ansible.windows.win_domain_module`
      The official documentation on the **ansible.windows.win_domain** module.
   :ref:`ansible.windows.win_domain_controller_module`
      The official documentation on the **ansible.windows.win_domain_controller** module.
   :ref:`community.windows.win_domain_computer_module`
      The official documentation on the **community.windows.win_domain_computer** module.
   :ref:`ansible.windows.win_domain_membership_module`
      The official documentation on the **ansible.windows.win_domain_membership** module.
   :ref:`community.windows.win_domain_user_module`
      The official documentation on the **community.windows.win_domain_user** module.
   :ref:`ansible.windows.win_group_module`
      The official documentation on the **ansible.windows.win_group** module.
   :ref:`ansible.windows.win_group_membership_module`
      The official documentation on the **ansible.windows.win_group_membership** module.


Examples
--------

.. code-block:: yaml

    - name: Ensure the group Cow exists using sAMAccountName
      community.windows.win_domain_group:
        name: Cow
        scope: global
        path: OU=groups,DC=ansible,DC=local

    - name: Ensure the group Cow doesn't exist using the Distinguished Name
      community.windows.win_domain_group:
        name: CN=Cow,OU=groups,DC=ansible,DC=local
        state: absent

    - name: Delete group ignoring the protection flag
      community.windows.win_domain_group:
        name: Cow
        state: absent
        ignore_protection: yes

    - name: Create group with delete protection enabled and custom attributes
      community.windows.win_domain_group:
        name: Ansible Users
        scope: domainlocal
        category: security
        attributes:
          mail: helpdesk@ansible.com
          wWWHomePage: www.ansible.com
        ignore_protection: yes

    - name: Change the OU of a group using the SID and ignore the protection flag
      community.windows.win_domain_group:
        name: S-1-5-21-2171456218-3732823212-122182344-1189
        scope: global
        organizational_unit: OU=groups,DC=ansible,DC=local
        ignore_protection: yes

    - name: Add managed_by user
      community.windows.win_domain_group:
        name: Group Name Here
        managed_by: Domain Admins

    - name: Add group and specify the AD domain services to use for the create
      community.windows.win_domain_group:
        name: Test Group
        domain_username: user@CORP.ANSIBLE.COM
        domain_password: Password01!
        domain_server: corp-DC12.corp.ansible.com
        scope: domainlocal



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
                    <b>attributes</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">dictionary</span>
                    </div>
                </td>
                <td>group exists and attributes are set on the module invocation</td>
                <td>
                            <div>Custom attributes that were set by the module. This does not show all the custom attributes rather just the ones that were set by the module.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">{&#x27;mail&#x27;: &#x27;helpdesk@ansible.com&#x27;, &#x27;wWWHomePage&#x27;: &#x27;www.ansible.com&#x27;}</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>canonical_name</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>group exists</td>
                <td>
                            <div>The canonical name of the group.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">ansible.local/groups/Cow</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>category</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>group exists</td>
                <td>
                            <div>The Group type value of the group, i.e. Security or Distribution.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">Security</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>created</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">boolean</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Whether a group was created</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">True</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>description</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>group exists</td>
                <td>
                            <div>The Description of the group.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">Group Description</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>display_name</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>group exists</td>
                <td>
                            <div>The Display name of the group.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">Users who connect through RDP</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>distinguished_name</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>group exists</td>
                <td>
                            <div>The full Distinguished Name of the group.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">CN=Cow,OU=groups,DC=ansible,DC=local</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>group_scope</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>group exists</td>
                <td>
                            <div>The Group scope value of the group.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">Universal</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>guid</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>group exists</td>
                <td>
                            <div>The guid of the group.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">512a9adb-3fc0-4a26-9df0-e6ea1740cf45</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>managed_by</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>group exists</td>
                <td>
                            <div>The full Distinguished Name of the AD object that is set on the managedBy attribute.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">CN=Domain Admins,CN=Users,DC=ansible,DC=local</div>
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
                <td>group exists</td>
                <td>
                            <div>The name of the group.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">Cow</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>protected_from_accidental_deletion</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">boolean</span>
                    </div>
                </td>
                <td>group exists</td>
                <td>
                            <div>Whether the group is protected from accidental deletion.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">True</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>sid</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>group exists</td>
                <td>
                            <div>The Security ID of the group.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">S-1-5-21-2171456218-3732823212-122182344-1189</div>
                </td>
            </tr>
    </table>
    <br/><br/>


Status
------


Authors
~~~~~~~

- Jordan Borean (@jborean93)
