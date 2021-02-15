.. _community.windows.win_dns_zone_module:


******************************
community.windows.win_dns_zone
******************************

**Manage Windows Server DNS Zones**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Manage Windows Server DNS Zones
- Adds, Removes and Modifies DNS Zones - Primary, Secondary, Forwarder & Stub
- Task should be delegated to a Windows DNS Server



Requirements
------------
The below requirements are needed on the host that executes this module.

- This module requires Windows Server 2012R2 or Newer


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
                    <b>dns_servers</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">list</span>
                         / <span style="color: purple">elements=string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Specifies an list of IP addresses of the primary servers of the zone.</div>
                        <div>DNS queries for a forwarded zone are sent to primary servers.</div>
                        <div>Required if l(type=secondary), l(type=forwarder) or l(type=stub), otherwise ignored.</div>
                        <div>At least one server is required.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>dynamic_update</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>secure</li>
                                    <li>none</li>
                                    <li>nonsecureandsecure</li>
                        </ul>
                </td>
                <td>
                        <div>Specifies how a zone handles dynamic updates.</div>
                        <div>Secure DNS updates are available only for Active Directory-integrated zones.</div>
                        <div>When not specified during new zone creation, Windows will default this to l(none).</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>forwarder_timeout</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Specifies a length of time, in seconds, that a DNS server waits for a remote DNS server to resolve a query.</div>
                        <div>Accepts integer values between 0 and 15.</div>
                        <div>If the provided value is not valid, it will be omitted and a warning will be issued.</div>
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
                        <div>Fully qualified name of the DNS zone.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>replication</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>forest</li>
                                    <li>domain</li>
                                    <li>legacy</li>
                                    <li>none</li>
                        </ul>
                </td>
                <td>
                        <div>Specifies the replication scope for the DNS zone.</div>
                        <div>l(replication=forest) will replicate the DNS zone to all domain controllers in the Active Directory forest.</div>
                        <div>l(replication=domain) will replicate the DNS zone to all domain controllers in the Active Directory domain.</div>
                        <div>l(replication=none) disables Active Directory integration and creates a local file with the name of the zone.</div>
                        <div>This is the equivalent of selecting l(store the zone in Active Directory) in the GUI.</div>
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
                        <div>Specifies the desired state of the DNS zone.</div>
                        <div>When l(state=present) the module will attempt to create the specified DNS zone if it does not already exist.</div>
                        <div>When l(state=absent), the module will remove the specified DNS zone and all subsequent DNS records.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>type</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>primary</li>
                                    <li>secondary</li>
                                    <li>stub</li>
                                    <li>forwarder</li>
                        </ul>
                </td>
                <td>
                        <div>Specifies the type of DNS zone.</div>
                        <div>When l(type=secondary), the DNS server will immediately attempt to perform a zone transfer from the servers in this list. If this initial transfer fails, then the zone will be left in an unworkable state. This module does not verify the initial transfer.</div>
                </td>
            </tr>
    </table>
    <br/>




Examples
--------

.. code-block:: yaml

    - name: Ensure primary zone is present
      community.windows.win_dns_zone:
        name: wpinner.euc.vmware.com
        replication: domain
        type: primary
        state: present

    - name: Ensure DNS zone is absent
      community.windows.win_dns_zone:
        name: jamals.euc.vmware.com
        state: absent

    - name: Ensure forwarder has specific DNS servers
      community.windows.win_dns_zone:
        name: jamals.euc.vmware.com
        type: forwarder
        dns_servers:
          - 10.245.51.100
          - 10.245.51.101
          - 10.245.51.102

    - name: Ensure stub zone has specific DNS servers
      community.windows.win_dns_zone:
        name: virajp.euc.vmware.com
        type: stub
        dns_servers:
          - 10.58.2.100
          - 10.58.2.101

    - name: Ensure stub zone is converted to a secondary zone
      community.windows.win_dns_zone:
        name: virajp.euc.vmware.com
        type: secondary

    - name: Ensure secondary zone is present with no replication
      community.windows.win_dns_zone:
        name: dgemzer.euc.vmware.com
        type: secondary
        replication: none
        dns_servers:
          - 10.19.20.1

    - name: Ensure secondary zone is converted to a primary zone
      community.windows.win_dns_zone:
        name: dgemzer.euc.vmware.com
        type: primary
        replication: none
        dns_servers:
          - 10.19.20.1

    - name: Ensure primary DNS zone is present without replication
      community.windows.win_dns_zone:
        name: basavaraju.euc.vmware.com
        replication: none
        type: primary

    - name: Ensure primary DNS zone has nonsecureandsecure dynamic updates enabled
      community.windows.win_dns_zone:
        name: basavaraju.euc.vmware.com
        replication: none
        dynamic_update: nonsecureandsecure
        type: primary

    - name: Ensure DNS zone is absent
      community.windows.win_dns_zone:
        name: marshallb.euc.vmware.com
        state: absent

    - name: Ensure DNS zones are absent
      community.windows.win_dns_zone:
        name: "{{ item }}"
        state: absent
      loop:
        - jamals.euc.vmware.com
        - dgemzer.euc.vmware.com
        - wpinner.euc.vmware.com
        - marshallb.euc.vmware.com
        - basavaraju.euc.vmware.com



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
                    <b>zone</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">dictionary</span>
                    </div>
                </td>
                <td>When l(state=present)</td>
                <td>
                            <div>New/Updated DNS zone parameters</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">{&#x27;name&#x27;: None, &#x27;type&#x27;: None, &#x27;dynamic_update&#x27;: None, &#x27;reverse_lookup&#x27;: None, &#x27;forwarder_timeout&#x27;: None, &#x27;paused&#x27;: None, &#x27;shutdown&#x27;: None, &#x27;zone_file&#x27;: None, &#x27;replication&#x27;: None, &#x27;dns_servers&#x27;: None}</div>
                </td>
            </tr>
    </table>
    <br/><br/>


Status
------


Authors
~~~~~~~

- Joe Zollo (@joezollo)
