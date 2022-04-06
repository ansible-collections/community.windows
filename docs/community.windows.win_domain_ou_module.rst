.. _community.windows.win_domain_ou_module:


*******************************
community.windows.win_domain_ou
*******************************

**Manage Active Directory Organizational Units**


Version added: 1.8.0

.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Manage Active Directory Organizational Units
- Adds, Removes and Modifies Active Directory Organizational Units
- Task should be delegated to a Windows Active Directory Domain Controller



Requirements
------------
The below requirements are needed on the host that executes this module.

- This module requires Windows Server 2012 or Newer
- Powershell ActiveDirectory Module


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
                        <div>The password for the domain you are accessing</div>
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
                    <b>filter</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <b>Default:</b><br/><div style="color: blue">"*"</div>
                </td>
                <td>
                        <div>filter for lookup of ou.</div>
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
                        <div>The name of the Organizational Unit</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>path</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Specifies the X.500 path of the OU or container where the new object is created.</div>
                        <div>defaults to adding ou at base of domain connected to.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>properties</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">dictionary</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Free form dict of properties for the organizational unit. Follows LDAP property names, like <code>StreetAddress</code> or <code>PostalCode</code>.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>protected</b>
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
                        <div>Indicates whether to prevent the object from being deleted. When this <em>protected=true</em>, you cannot delete the corresponding object without changing the value of the property.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>recursive</b>
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
                        <div>Removes the OU and any child items it contains.</div>
                        <div>You must specify this parameter to remove an OU that is not empty.</div>
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
                                    <li><div style="color: blue"><b>present</b>&nbsp;&larr;</div></li>
                                    <li>absent</li>
                        </ul>
                </td>
                <td>
                        <div>Specifies the desired state of the OU.</div>
                        <div>When <em>state=present</em> the module will attempt to create the specified OU if it does not already exist.</div>
                        <div>When <em>state=absent</em>, the module will remove the specified OU.</div>
                        <div>When <em>state=absent</em> and <em>recursive=true</em>, the module will remove all the OU and all child OU&#x27;s.</div>
                </td>
            </tr>
    </table>
    <br/>




Examples
--------

.. code-block:: yaml

    ---
    - name: Ensure OU is present & protected
      community.windows.win_domain_ou:
        name: AnsibleFest
        state: present

    - name: Ensure OU is present & protected
      community.windows.win_domain_ou:
        name: EUC Users
        path: "DC=euc,DC=vmware,DC=lan"
        state: present
        protected: true
      delegate_to: win-ad1.euc.vmware.lab

    - name: Ensure OU is absent
      community.windows.win_domain_ou:
        name: EUC Users
        path: "DC=euc,DC=vmware,DC=lan"
        state: absent
      delegate_to: win-ad1.euc.vmware.lab

    - name: Ensure OU is present with specific properties
      community.windows.win_domain_ou:
        name: WS1Users
        path: "CN=EUC Users,DC=euc,DC=vmware,DC=lan"
        protected: true
        properties:
          city: Sandy Springs
          state: Georgia
          StreetAddress: 1155 Perimeter Center West
          country: US
          description: EUC Business Unit
          PostalCode: 30189
      delegate_to: win-ad1.euc.vmware.lab

    - name: Ensure OU updated with new properties
      community.windows.win_domain_ou:
        name: WS1Users
        path: DC=euc,DC=vmware,DC=lan
        protected: false
        properties:
          city: Atlanta
          state: Georgia
          managedBy: jzollo@vmware.com
      delegate_to: win-ad1.euc.vmware.lab



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
                    <b>ou</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">dictionary</span>
                    </div>
                </td>
                <td>When <em>state=present</em></td>
                <td>
                            <div>New/Updated organizational unit parameters</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">{&#x27;AddedProperties&#x27;: [], &#x27;City&#x27;: &#x27;Sandy Springs&#x27;, &#x27;Country&#x27;: None, &#x27;DistinguishedName&#x27;: &#x27;OU=VMW Atlanta,DC=ansible,DC=test&#x27;, &#x27;LinkedGroupPolicyObjects&#x27;: [], &#x27;ManagedBy&#x27;: None, &#x27;ModifiedProperties&#x27;: [], &#x27;Name&#x27;: &#x27;VMW Atlanta&#x27;, &#x27;ObjectClass&#x27;: &#x27;organizationalUnit&#x27;, &#x27;ObjectGUID&#x27;: &#x27;3e987e30-93ad-4229-8cd0-cff6a91275e4&#x27;, &#x27;PostalCode&#x27;: None, &#x27;PropertyCount&#x27;: 11, &#x27;PropertyNames&#x27;: &#x27;City Country DistinguishedName LinkedGroupPolicyObjects ManagedBy Name ObjectClass ObjectGUID PostalCode State StreetAddress&#x27;, &#x27;RemovedProperties&#x27;: [], &#x27;State&#x27;: &#x27;Georgia&#x27;, &#x27;StreetAddress&#x27;: &#x27;1155 Perimeter Center West&#x27;}</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>path</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Base ou path used by module either when provided <em>path=DC=Ansible,DC=Test</em> or derived by module.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">{&#x27;path&#x27;: &#x27;DC=ansible,DC=test&#x27;}</div>
                </td>
            </tr>
    </table>
    <br/><br/>


Status
------


Authors
~~~~~~~

- Joe Zollo (@joezollo)
- Larry Lane (@gamethis)
