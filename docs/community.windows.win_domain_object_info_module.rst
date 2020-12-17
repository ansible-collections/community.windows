.. _community.windows.win_domain_object_info_module:


****************************************
community.windows.win_domain_object_info
****************************************

**Gather information an Active Directory object**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Gather information about multiple Active Directory object(s).




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
                        <div>The password for <code>domain_username</code>.</div>
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
                        <div>Specified the Active Directory Domain Services instance to connect to.</div>
                        <div>Can be in the form of an FQDN or NetBIOS name.</div>
                        <div>If not specified then the value is based on the default domain of the computer running PowerShell.</div>
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
                        <div>If this is not set then the user that is used for authentication will be the connection user.</div>
                        <div>Ansible will be unable to use the connection user unless auth is Kerberos with credential delegation or CredSSP, or become is used on the task.</div>
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
                </td>
                <td>
                        <div>Specifies a query string using the PowerShell Expression Language syntax.</div>
                        <div>This follows the same rules and formatting as the <code>-Filter</code> parameter for the PowerShell AD cmdlets exception there is no variable substitutions.</div>
                        <div>This is mutually exclusive with <em>identity</em> and <em>ldap_filter</em>.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>identity</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Specifies a single Active Directory object by its distinguished name or its object GUID.</div>
                        <div>This is mutually exclusive with <em>filter</em> and <em>ldap_filter</em>.</div>
                        <div>This cannot be used with either the <em>search_base</em> or <em>search_scope</em> options.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>include_deleted</b>
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
                        <div>Also search for deleted Active Directory objects.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>ldap_filter</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Like <em>filter</em> but this is a tradiitional LDAP query string to filter the objects to return.</div>
                        <div>This is mutually exclusive with <em>filter</em> and <em>identity</em>.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>properties</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">list</span>
                         / <span style="color: purple">elements=string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>A list of properties to return.</div>
                        <div>If a property is <code>*</code>, all properties that have a set value on the AD object will be returned.</div>
                        <div>If a property is valid on the object but not set, it is only returned if defined explicitly in this option list.</div>
                        <div>The properties <code>DistinguishedName</code>, <code>Name</code>, <code>ObjectClass</code>, and <code>ObjectGUID</code> are always returned.</div>
                        <div>Specifying multiple properties can have a performance impact, it is best to only return what is needed.</div>
                        <div>If an invalid property is specified then the module will display a warning for each object it is invalid on.</div>
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
                        <div>Specify the Active Directory path to search for objects in.</div>
                        <div>This cannot be set with <em>identity</em>.</div>
                        <div>By default the search base is the default naming context of the target AD instance which is the DN returned by &quot;(Get-ADRootDSE).defaultNamingContext&quot;.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>search_scope</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>base</li>
                                    <li>one_level</li>
                                    <li>subtree</li>
                        </ul>
                </td>
                <td>
                        <div>Specify the scope of when searching for an object in the <code>search_base</code>.</div>
                        <div><code>base</code> will limit the search to the base object so the maximum number of objects returned is always one. This will not search any objects inside a container..</div>
                        <div><code>one_level</code> will search the current path and any immediate objects in that path.</div>
                        <div><code>subtree</code> will search the current path and all objects of that path recursively.</div>
                        <div>This cannot be set with <em>identity</em>.</div>
                </td>
            </tr>
    </table>
    <br/>


Notes
-----

.. note::
   - The ``sAMAccountType_AnsibleFlags`` and ``userAccountControl_AnsibleFlags`` return property is something set by the module itself as an easy way to view what those flags represent. These properties cannot be used as part of the *filter* or *ldap_filter* and are automatically added if those properties were requested.



Examples
--------

.. code-block:: yaml

    - name: Get all properties for the specified account using its DistinguishedName
      community.windows.win_domain_object_info:
        identity: CN=Username,CN=Users,DC=domain,DC=com
        properties: '*'

    - name: Get the SID for all user accounts as a filter
      community.windows.win_domain_object_info:
        filter: ObjectClass -eq 'user' -and objectCategory -eq 'Person'
        properties:
        - objectSid

    - name: Get the SID for all user accounts as a LDAP filter
      community.windows.win_domain_object_info:
        ldap_filter: (&(objectClass=user)(objectCategory=Person))
        properties:
        - objectSid

    - name: Search all computer accounts in a specific path that were added after February 1st
      community.windows.win_domain_object_info:
        filter: objectClass -eq 'computer' -and whenCreated -gt '20200201000000.0Z'
        properties: '*'
        search_scope: one_level
        search_base: CN=Computers,DC=domain,DC=com



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
                    <b>objects</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">list</span>
                       / <span style="color: purple">elements=dictionary</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>A list of dictionaries that are the Active Directory objects found and the properties requested.</div>
                            <div>The dict&#x27;s keys are the property name and the value is the value for the property.</div>
                            <div>All date properties are return in the ISO 8601 format in the UTC timezone.</div>
                            <div>All SID properties are returned as a dict with the keys <code>Sid</code> as the SID string and <code>Name</code> as the translated SID account name.</div>
                            <div>All byte properties are returned as a base64 string.</div>
                            <div>All security descriptor properties are returned as the SDDL string of that descriptor.</div>
                            <div>The properties <code>DistinguishedName</code>, <code>Name</code>, <code>ObjectClass</code>, and <code>ObjectGUID</code> are always returned.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">[{
      &quot;accountExpires&quot;: 0,
      &quot;adminCount&quot;: 1,
      &quot;CanonicalName&quot;: &quot;domain.com/Users/Administrator&quot;,
      &quot;CN&quot;: &quot;Administrator&quot;,
      &quot;Created&quot;: &quot;2020-01-13T09:03:22.0000000Z&quot;,
      &quot;Description&quot;: &quot;Built-in account for administering computer/domain&quot;,
      &quot;DisplayName&quot;: null,
      &quot;DistinguishedName&quot;: &quot;CN=Administrator,CN=Users,DC=domain,DC=com&quot;,
      &quot;memberOf&quot;: [
        &quot;CN=Group Policy Creator Owners,CN=Users,DC=domain,DC=com&quot;,
        &quot;CN=Domain Admins&quot;,CN=Users,DC=domain,DC=com&quot;
      ],
      &quot;Name&quot;: &quot;Administrator&quot;,
      &quot;nTSecurityDescriptor&quot;: &quot;O:DAG:DAD:PA<em>A;;LCRPLORC;;;AU</em>(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;SY)(A;;CCDCLCSWRPWPLOCRSDRCWDWO;;;BA)&quot;,
      &quot;ObjectCategory&quot;: &quot;CN=Person,CN=Schema,CN=Configuration,DC=domain,DC=com&quot;,
      &quot;ObjectClass&quot;: &quot;user&quot;,
      &quot;ObjectGUID&quot;: &quot;c8c6569e-4688-4f3c-8462-afc4ff60817b&quot;,
      &quot;objectSid&quot;: {
        &quot;Sid&quot;: &quot;S-1-5-21-2959096244-3298113601-420842770-500&quot;,
        &quot;Name&quot;: &quot;DOMAIN\Administrator&quot;
      },
      &quot;sAMAccountName&quot;: &quot;Administrator&quot;,
    }]</div>
                </td>
            </tr>
    </table>
    <br/><br/>


Status
------


Authors
~~~~~~~

- Jordan Borean (@jborean93)
