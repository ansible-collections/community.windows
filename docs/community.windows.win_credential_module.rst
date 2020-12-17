.. _community.windows.win_credential_module:


********************************
community.windows.win_credential
********************************

**Manages Windows Credentials in the Credential Manager**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Used to create and remove Windows Credentials in the Credential Manager.
- This module can manage both standard username/password credentials as well as certificate credentials.




Parameters
----------

.. raw:: html

    <table  border=0 cellpadding=0 class="documentation-table">
        <tr>
            <th colspan="2">Parameter</th>
            <th>Choices/<font color="blue">Defaults</font></th>
            <th width="100%">Comments</th>
        </tr>
            <tr>
                <td colspan="2">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>alias</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Adds an alias for the credential.</div>
                        <div>Typically this is the NetBIOS name of a host if <em>name</em> is set to the DNS name.</div>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>attributes</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">list</span>
                         / <span style="color: purple">elements=dictionary</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>A list of dicts that set application specific attributes for a credential.</div>
                        <div>When set, existing attributes will be compared to the list as a whole, any differences means all attributes will be replaced.</div>
                </td>
            </tr>
                                <tr>
                    <td class="elbow-placeholder"></td>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>data</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The value for the attribute.</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>data_format</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>base64</li>
                                    <li><div style="color: blue"><b>text</b>&nbsp;&larr;</div></li>
                        </ul>
                </td>
                <td>
                        <div>Controls the input type for <em>data</em>.</div>
                        <div>If <code>text</code>, <em>data</em> is a text string that is UTF-16LE encoded to bytes.</div>
                        <div>If <code>base64</code>, <em>data</em> is a base64 string that is base64 decoded to bytes.</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
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
                        <div>The key for the attribute.</div>
                        <div>This is not a unique identifier as multiple attributes can have the same key.</div>
                </td>
            </tr>

            <tr>
                <td colspan="2">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>comment</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>A user defined comment for the credential.</div>
                </td>
            </tr>
            <tr>
                <td colspan="2">
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
                        <div>The target that identifies the server or servers that the credential is to be used for.</div>
                        <div>If the value can be a NetBIOS name, DNS server name, DNS host name suffix with a wildcard character (<code>*</code>), a NetBIOS of DNS domain name that contains a wildcard character sequence, or an asterisk.</div>
                        <div>See <code>TargetName</code> in <a href='https://docs.microsoft.com/en-us/windows/desktop/api/wincred/ns-wincred-_credentiala'>https://docs.microsoft.com/en-us/windows/desktop/api/wincred/ns-wincred-_credentiala</a> for more details on what this value can be.</div>
                        <div>This is used with <em>type</em> to produce a unique credential.</div>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>persistence</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>enterprise</li>
                                    <li><div style="color: blue"><b>local</b>&nbsp;&larr;</div></li>
                        </ul>
                </td>
                <td>
                        <div>Defines the persistence of the credential.</div>
                        <div>If <code>local</code>, the credential will persist for all logons of the same user on the same host.</div>
                        <div><code>enterprise</code> is the same as <code>local</code> but the credential is visible to the same domain user when running on other hosts and not just localhost.</div>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>secret</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The secret for the credential.</div>
                        <div>When omitted, then no secret is used for the credential if a new credentials is created.</div>
                        <div>When <em>type</em> is a password type, this is the password for <em>username</em>.</div>
                        <div>When <em>type</em> is a certificate type, this is the pin for the certificate.</div>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>secret_format</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>base64</li>
                                    <li><div style="color: blue"><b>text</b>&nbsp;&larr;</div></li>
                        </ul>
                </td>
                <td>
                        <div>Controls the input type for <em>secret</em>.</div>
                        <div>If <code>text</code>, <em>secret</em> is a text string that is UTF-16LE encoded to bytes.</div>
                        <div>If <code>base64</code>, <em>secret</em> is a base64 string that is base64 decoded to bytes.</div>
                </td>
            </tr>
            <tr>
                <td colspan="2">
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
                        <div>When <code>absent</code>, the credential specified by <em>name</em> and <em>type</em> is removed.</div>
                        <div>When <code>present</code>, the credential specified by <em>name</em> and <em>type</em> is removed.</div>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>type</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                         / <span style="color: red">required</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>domain_certificate</li>
                                    <li>domain_password</li>
                                    <li>generic_certificate</li>
                                    <li>generic_password</li>
                        </ul>
                </td>
                <td>
                        <div>The type of credential to store.</div>
                        <div>This is used with <em>name</em> to produce a unique credential.</div>
                        <div>When the type is a <code>domain</code> type, the credential is used by Microsoft authentication packages like Negotiate.</div>
                        <div>When the type is a <code>generic</code> type, the credential is not used by any particular authentication package.</div>
                        <div>It is recommended to use a <code>domain</code> type as only authentication providers can access the secret.</div>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>update_secret</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li><div style="color: blue"><b>always</b>&nbsp;&larr;</div></li>
                                    <li>on_create</li>
                        </ul>
                </td>
                <td>
                        <div>When <code>always</code>, the secret will always be updated if they differ.</div>
                        <div>When <code>on_create</code>, the secret will only be checked/updated when it is first created.</div>
                        <div>If the secret cannot be retrieved and this is set to <code>always</code>, the module will always result in a change.</div>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>username</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>When <em>type</em> is a password type, then this is the username to store for the credential.</div>
                        <div>When <em>type</em> is a credential type, then this is the thumbprint as a hex string of the certificate to use.</div>
                        <div>When <code>type=domain_password</code>, this should be in the form of a Netlogon (DOMAIN\Username) or a UPN (username@DOMAIN).</div>
                        <div>If using a certificate thumbprint, the certificate must exist in the <code>CurrentUser\My</code> certificate store for the executing user.</div>
                </td>
            </tr>
    </table>
    <br/>


Notes
-----

.. note::
   - This module requires to be run with ``become`` so it can access the user's credential store.
   - There can only be one credential per host and type. if a second credential is defined that uses the same host and type, then the original credential is overwritten.


See Also
--------

.. seealso::

   :ref:`ansible.windows.win_user_right_module`
      The official documentation on the **ansible.windows.win_user_right** module.
   :ref:`ansible.windows.win_whoami_module`
      The official documentation on the **ansible.windows.win_whoami** module.


Examples
--------

.. code-block:: yaml

    - name: Create a local only credential
      community.windows.win_credential:
        name: server.domain.com
        type: domain_password
        username: DOMAIN\username
        secret: Password01
        state: present

    - name: Remove a credential
      community.windows.win_credential:
        name: server.domain.com
        type: domain_password
        state: absent

    - name: Create a credential with full values
      community.windows.win_credential:
        name: server.domain.com
        type: domain_password
        alias: server
        username: username@DOMAIN.COM
        secret: Password01
        comment: Credential for server.domain.com
        persistence: enterprise
        attributes:
        - name: Source
          data: Ansible
        - name: Unique Identifier
          data: Y3VzdG9tIGF0dHJpYnV0ZQ==
          data_format: base64

    - name: Create a certificate credential
      community.windows.win_credential:
        name: '*.domain.com'
        type: domain_certificate
        username: 0074CC4F200D27DC3877C24A92BA8EA21E6C7AF4
        state: present

    - name: Create a generic credential
      community.windows.win_credential:
        name: smbhost
        type: generic_password
        username: smbuser
        secret: smbuser
        state: present

    - name: Remove a generic credential
      community.windows.win_credential:
        name: smbhost
        type: generic_password
        state: absent




Status
------


Authors
~~~~~~~

- Jordan Borean (@jborean93)
