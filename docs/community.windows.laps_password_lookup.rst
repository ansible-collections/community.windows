.. _community.windows.laps_password_lookup:


*******************************
community.windows.laps_password
*******************************

**Retrieves the LAPS password for a server.**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- This lookup returns the LAPS password set for a server from the Active Directory database.
- See https://github.com/jborean93/ansible-lookup-laps_password for more information around installing pre-requisites and testing.



Requirements
------------
The below requirements are needed on the local Ansible controller node that executes this lookup.

- python-ldap


Parameters
----------

.. raw:: html

    <table  border=0 cellpadding=0 class="documentation-table">
        <tr>
            <th colspan="1">Parameter</th>
            <th>Choices/<font color="blue">Defaults</font></th>
                <th>Configuration</th>
            <th width="100%">Comments</th>
        </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>_terms</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                         / <span style="color: red">required</span>
                    </div>
                </td>
                <td>
                </td>
                    <td>
                    </td>
                <td>
                        <div>The host name to retrieve the LAPS password for.</div>
                        <div>This is the <code>Common Name (CN</code>) of the host.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>allow_plaintext</b>
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
                    </td>
                <td>
                        <div>When set to <code>yes</code>, will allow traffic to be sent unencrypted.</div>
                        <div>It is highly recommended to not touch this to avoid any credentials being exposed over the network.</div>
                        <div>Use <code>scheme=ldaps</code>, <code>auth=gssapi</code>, or <code>start_tls=yes</code> to ensure the traffic is encrypted.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>auth</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>simple</li>
                                    <li><div style="color: blue"><b>gssapi</b>&nbsp;&larr;</div></li>
                        </ul>
                </td>
                    <td>
                    </td>
                <td>
                        <div>The type of authentication to use when connecting to the Active Directory server</div>
                        <div>When using <code>simple</code>, the <em>username</em> and <em>password</em> options must be set. If not using <code>scheme=ldaps</code> or <code>start_tls=True</code> then these credentials are exposed in plaintext in the network traffic.</div>
                        <div>It is recommended ot use <code>gssapi</code> as it will encrypt the traffic automatically.</div>
                        <div>When using <code>gssapi</code>, run <code>kinit</code> before running Ansible to get a valid Kerberos ticket.</div>
                        <div>You cannot use <code>gssapi</code> when either <code>scheme=ldaps</code> or <code>start_tls=True</code> is set.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>ca_cert</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                    <td>
                    </td>
                <td>
                        <div>The path to a CA certificate PEM file to use for certificate validation.</div>
                        <div>Certificate validation is used when <code>scheme=ldaps</code> or <code>start_tls=yes</code>.</div>
                        <div>This may fail on hosts with an older OpenLDAP install like MacOS, this will have to be updated before reinstalling python-ldap to get working again.</div>
                        <div style="font-size: small; color: darkgreen"><br/>aliases: cacert_file</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>domain</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                         / <span style="color: red">required</span>
                    </div>
                </td>
                <td>
                </td>
                    <td>
                    </td>
                <td>
                        <div>The domain to search in to retrieve the LAPS password.</div>
                        <div>This could either be a Windows domain name visible to the Ansible controller from DNS or a specific domain controller FQDN.</div>
                        <div>Supports either just the domain/host name or an explicit LDAP URI with the domain/host already filled in.</div>
                        <div>If the URI is set, <em>port</em> and <em>scheme</em> are ignored.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>password</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                    <td>
                    </td>
                <td>
                        <div>The password for <code>username</code>.</div>
                        <div>Required when <code>username</code> is set.</div>
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
                </td>
                    <td>
                    </td>
                <td>
                        <div>The LDAP port to communicate over.</div>
                        <div>If <em>kdc</em> is already an LDAP URI then this is ignored.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>scheme</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">-</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li><div style="color: blue"><b>ldap</b>&nbsp;&larr;</div></li>
                                    <li>ldaps</li>
                        </ul>
                </td>
                    <td>
                    </td>
                <td>
                        <div>The LDAP scheme to use.</div>
                        <div>When using <code>ldap</code>, it is recommended to set <code>auth=gssapi</code>, or <code>start_tls=yes</code>, otherwise traffic will be in plaintext.</div>
                        <div>The Active Directory host must be configured for <code>ldaps</code> with a certificate before it can be used.</div>
                        <div>If <em>kdc</em> is already an LDAP URI then this is ignored.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>search_base</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                    <td>
                    </td>
                <td>
                        <div>Changes the search base used when searching for the host in Active Directory.</div>
                        <div>Will default to search in the <code>defaultNamingContext</code> of the Active Directory server.</div>
                        <div>If multiple matches are found then a more explicit search_base is required so only 1 host is found.</div>
                        <div>If searching a larger Active Directory database, it is recommended to narrow the search_base for performance reasons.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>start_tls</b>
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
                    </td>
                <td>
                        <div>When <code>scheme=ldap</code>, will use the StartTLS extension to encrypt traffic sent over the wire.</div>
                        <div>This requires the Active Directory to be set up with a certificate that supports StartTLS.</div>
                        <div>This is ignored when <code>scheme=ldaps</code> as the traffic is already encrypted.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
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
                    </td>
                <td>
                        <div>Required when using <code>auth=simple</code>.</div>
                        <div>The username to authenticate with.</div>
                        <div>Recommended to use the username in the UPN format, e.g. <code>username@DOMAIN.COM</code>.</div>
                        <div>This is required when <code>auth=simple</code> and is not supported when <code>auth=gssapi</code>.</div>
                        <div>Call <code>kinit</code> outside of Ansible if <code>auth=gssapi</code> is required.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>validate_certs</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>never</li>
                                    <li>allow</li>
                                    <li>try</li>
                                    <li><div style="color: blue"><b>demand</b>&nbsp;&larr;</div></li>
                        </ul>
                </td>
                    <td>
                    </td>
                <td>
                        <div>When using <code>scheme=ldaps</code> or <code>start_tls=yes</code>, this controls the certificate validation behaviour.</div>
                        <div><code>demand</code> will fail if no certificate or an invalid certificate is provided.</div>
                        <div><code>try</code> will fail for invalid certificates but will continue if no certificate is provided.</div>
                        <div><code>allow</code> will request and check a certificate but will continue even if it is invalid.</div>
                        <div><code>never</code> will not request a certificate from the server so no validation occurs.</div>
                </td>
            </tr>
    </table>
    <br/>


Notes
-----

.. note::
   - If a host was found but had no LAPS password attribute ``ms-Mcs-AdmPwd``, the lookup will fail.
   - Due to the sensitive nature of the data travelling across the network, it is highly recommended to run with either ``auth=gssapi``, ``scheme=ldaps``, or ``start_tls=yes``.
   - Failing to run with one of the above settings will result in the account credentials as well as the LAPS password to be sent in plaintext.
   - Some scenarios may not work when running on a host with an older OpenLDAP install like MacOS. It is recommended to install the latest OpenLDAP version and build python-ldap against this, see https://keathmilligan.net/python-ldap-and-macos for more information.



Examples
--------

.. code-block:: yaml

    # This isn't mandatory but it is a way to call kinit from within Ansible before calling the lookup
    - name: call kinit to retrieve Kerberos token
      expect:
        command: kinit username@ANSIBLE.COM
        responses:
          (?i)password: SecretPass1
      no_log: True

    - name: Get the LAPS password using Kerberos auth, relies on kinit already being called
      set_fact:
        ansible_password: "{{ lookup('community.windows.laps_password', 'SERVER', domain='dc01.ansible.com') }}"

    - name: Specific the domain host using an explicit LDAP URI
      set_fact:
        ansible_password: "{{ lookup('community.windows.laps_password', 'SERVER', domain='ldap://ansible.com:389') }}"

    - name: Use Simple auth over LDAPS
      set_fact:
        ansible_password: "{{ lookup('community.windows.laps_password', 'server',
                                     domain='dc01.ansible.com',
                                     auth='simple',
                                     scheme='ldaps',
                                     username='username@ANSIBLE.COM',
                                     password='SuperSecret123') }}"

    - name: Use Simple auth with LDAP and StartTLS
      set_fact:
        ansible_password: "{{ lookup('community.windows.laps_password', 'app01',
                                     domain='dc01.ansible.com',
                                     auth='simple',
                                     start_tls=True,
                                     username='username@ANSIBLE.COM',
                                     password='SuperSecret123') }}"

    - name: Narrow down the search base to a an OU
      set_fact:
        ansible_password: "{{ lookup('community.windows.laps_password', 'sql10',
                                     domain='dc01.ansible.com',
                                     search_base='OU=Databases,DC=ansible,DC=com') }}"

    - name: Set certificate file to use when validating the TLS certificate
      set_fact:
        ansible_password: "{{ lookup('community.windows.laps_password', 'windows-pc',
                                     domain='dc01.ansible.com',
                                     start_tls=True,
                                     ca_cert='/usr/local/share/certs/ad.pem') }}"



Return Values
-------------
Common return values are documented `here <https://docs.ansible.com/ansible/latest/reference_appendices/common_return_values.html#common-return-values>`_, the following are the fields unique to this lookup:

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
                    <b>_raw</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td></td>
                <td>
                            <div>The LAPS password(s) for the host(s) requested.</div>
                    <br/>
                </td>
            </tr>
    </table>
    <br/><br/>


Status
------


Authors
~~~~~~~

- Jordan Borean (@jborean93)


.. hint::
    Configuration entries for each entry type have a low to high priority order. For example, a variable that is lower in the list will override a variable that is higher up.
