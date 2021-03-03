.. _community.windows.win_dns_record_module:


********************************
community.windows.win_dns_record
********************************

**Manage Windows Server DNS records**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Manage DNS records within an existing Windows Server DNS zone.



Requirements
------------
The below requirements are needed on the host that executes this module.

- This module requires Windows 8, Server 2012, or newer.


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
                    <b>computer_name</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Specifies a DNS server.</div>
                        <div>You can specify an IP address or any value that resolves to an IP address, such as a fully qualified domain name (FQDN), host name, or NETBIOS name.</div>
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
                        <div>The name of the record.</div>
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
                    <div style="font-style: italic; font-size: small; color: darkgreen">added in 1.0.0</div>
                </td>
                <td>
                </td>
                <td>
                        <div>The port number of the record.</div>
                        <div>Required when <code>type=SRV</code>.</div>
                        <div>Supported only for <code>type=SRV</code>.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>priority</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">integer</span>
                    </div>
                    <div style="font-style: italic; font-size: small; color: darkgreen">added in 1.0.0</div>
                </td>
                <td>
                </td>
                <td>
                        <div>The priority number for each service in SRV record.</div>
                        <div>Required when <code>type=SRV</code>.</div>
                        <div>Supported only for <code>type=SRV</code>.</div>
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
                        <div>Whether the record should exist or not.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>ttl</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>
                        <b>Default:</b><br/><div style="color: blue">3600</div>
                </td>
                <td>
                        <div>The &quot;time to live&quot; of the record, in seconds.</div>
                        <div>Ignored when <code>state=absent</code>.</div>
                        <div>Valid range is 1 - 31557600.</div>
                        <div>Note that an Active Directory forest can specify a minimum TTL, and will dynamically &quot;round up&quot; other values to that minimum.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
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
                                    <li>A</li>
                                    <li>AAAA</li>
                                    <li>CNAME</li>
                                    <li>NS</li>
                                    <li>PTR</li>
                                    <li>SRV</li>
                        </ul>
                </td>
                <td>
                        <div>The type of DNS record to manage.</div>
                        <div><code>SRV</code> was added in the 1.0.0 release of this collection.</div>
                        <div><code>NS</code> was added in the 1.1.0 release of this collection.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>value</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">list</span>
                         / <span style="color: purple">elements=string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The value(s) to specify. Required when <code>state=present</code>.</div>
                        <div>When <code>type=PTR</code> only the partial part of the IP should be given.</div>
                        <div>Multiple values can be passed when <code>type=NS</code></div>
                        <div style="font-size: small; color: darkgreen"><br/>aliases: values</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>weight</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">integer</span>
                    </div>
                    <div style="font-style: italic; font-size: small; color: darkgreen">added in 1.0.0</div>
                </td>
                <td>
                </td>
                <td>
                        <div>Weightage given to each service record in SRV record.</div>
                        <div>Required when <code>type=SRV</code>.</div>
                        <div>Supported only for <code>type=SRV</code>.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>zone</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                         / <span style="color: red">required</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The name of the zone to manage (eg <code>example.com</code>).</div>
                        <div>The zone must already exist.</div>
                </td>
            </tr>
    </table>
    <br/>




Examples
--------

.. code-block:: yaml

    # Demonstrate creating a matching A and PTR record.

    - name: Create database server record
      community.windows.win_dns_record:
        name: "cgyl1404p.amer.example.com"
        type: "A"
        value: "10.1.1.1"
        zone: "amer.example.com"

    - name: Create matching PTR record
      community.windows.win_dns_record:
        name: "1.1.1"
        type: "PTR"
        value: "db1"
        zone: "10.in-addr.arpa"

    # Demonstrate replacing an A record with a CNAME

    - name: Remove static record
      community.windows.win_dns_record:
        name: "db1"
        type: "A"
        state: absent
        zone: "amer.example.com"

    - name: Create database server alias
      community.windows.win_dns_record:
        name: "db1"
        type: "CNAME"
        value: "cgyl1404p.amer.example.com"
        zone: "amer.example.com"

    # Demonstrate creating multiple A records for the same name

    - name: Create multiple A record values for www
      community.windows.win_dns_record:
        name: "www"
        type: "A"
        values:
          - 10.0.42.5
          - 10.0.42.6
          - 10.0.42.7
        zone: "example.com"

    # Demonstrates a partial update (replace some existing values with new ones)
    # for a pre-existing name

    - name: Update www host with new addresses
      community.windows.win_dns_record:
        name: "www"
        type: "A"
        values:
          - 10.0.42.5  # this old value was kept (others removed)
          - 10.0.42.12  # this new value was added
        zone: "example.com"

    # Demonstrate creating a SRV record

    - name: Creating a SRV record with port number and priority
      community.windows.win_dns_record:
        name: "test"
        priority: 5
        port: 995
        state: present
        type: "SRV"
        weight: 2
        value: "amer.example.com"
        zone: "example.com"

    # Demonstrate creating a NS record with multiple values

    - name: Creating NS record
      community.windows.win_dns_record:
        name: "ansible.prog"
        state: present
        type: "NS"
        values:
          - 10.0.0.1
          - 10.0.0.2
          - 10.0.0.3
          - 10.0.0.4
        zone: "example.com"




Status
------


Authors
~~~~~~~

- John Nelson (@johnboy2)
