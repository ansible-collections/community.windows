.. _community.windows.win_dhcp_lease_module:


********************************
community.windows.win_dhcp_lease
********************************

**Manage Windows Server DHCP Leases**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Manage Windows Server DHCP Leases (IPv4 Only)
- Adds, Removes and Modifies DHCP Leases and Reservations
- Task should be delegated to a Windows DHCP Server



Requirements
------------
The below requirements are needed on the host that executes this module.

- This module requires Windows Server 2012 or Newer


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
                    <b>description</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Specifies the description for reservation being created.</div>
                        <div>Only applicable to l(type=reservation).</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>dns_hostname</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Specifies the DNS hostname of the client for which the IP address lease is to be added.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>dns_regtype</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li><div style="color: blue"><b>aptr</b>&nbsp;&larr;</div></li>
                                    <li>a</li>
                                    <li>noreg</li>
                        </ul>
                </td>
                <td>
                        <div>Indicates the type of DNS record to be registered by the DHCP. server service for this lease.</div>
                        <div>l(a) results in an A record being registered.</div>
                        <div>l(aptr) results in both A and PTR records to be registered.</div>
                        <div>l(noreg) results in no DNS records being registered.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>duration</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Specifies the duration of the DHCP lease in days.</div>
                        <div>The duration value only applies to l(type=lease).</div>
                        <div>Defaults to the duration specified by the DHCP server configuration.</div>
                        <div>Only applicable to l(type=lease).</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>ip</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The IPv4 address of the client server/computer.</div>
                        <div>This is a required parameter, if l(mac) is not set.</div>
                        <div>Can be used to identify an existing lease/reservation, instead of l(mac).</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>mac</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Specifies the client identifier to be set on the IPv4 address.</div>
                        <div>This is a required parameter, if l(ip) is not set.</div>
                        <div>Windows clients use the MAC address as the client ID.</div>
                        <div>Linux and other operating systems can use other types of identifiers.</div>
                        <div>Can be used to identify an existing lease/reservation, instead of l(ip).</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>reservation_name</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Specifies the name of the reservation being created.</div>
                        <div>Only applicable to l(type=reservation).</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>scope_id</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Specifies the scope identifier as defined by the DHCP server.</div>
                        <div>This is a required parameter, if l(state=present) and the reservation or lease doesn&#x27;t already exist. Not required if updating an existing lease or reservation.</div>
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
                        <div>Specifies the desired state of the DHCP lease or reservation.</div>
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
                                    <li><div style="color: blue"><b>reservation</b>&nbsp;&larr;</div></li>
                                    <li>lease</li>
                        </ul>
                </td>
                <td>
                        <div>The type of DHCP address.</div>
                        <div>Leases expire as defined by l(duration).</div>
                        <div>When l(duration) is not specified, the server default is used.</div>
                        <div>Reservations are permanent.</div>
                </td>
            </tr>
    </table>
    <br/>




Examples
--------

.. code-block:: yaml

    - name: Ensure DHCP reservation exists
      community.windows.win_dhcp_lease:
        type: reservation
        ip: 192.168.100.205
        scope_id: 192.168.100.0
        mac: 00:B1:8A:D1:5A:1F
        dns_hostname: "{{ ansible_inventory }}"
        description: Testing Server

    - name: Ensure DHCP lease or reservation does not exist
      community.windows.win_dhcp_lease:
        mac: 00:B1:8A:D1:5A:1F
        state: absent

    - name: Ensure DHCP lease or reservation does not exist
      community.windows.win_dhcp_lease:
        ip: 192.168.100.205
        state: absent

    - name: Convert DHCP lease to reservation & update description
      community.windows.win_dhcp_lease:
        type: reservation
        ip: 192.168.100.205
        description: Testing Server

    - name: Convert DHCP reservation to lease
      community.windows.win_dhcp_lease:
        type: lease
        ip: 192.168.100.205



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
                    <b>lease</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">dictionary</span>
                    </div>
                </td>
                <td>When l(state=present)</td>
                <td>
                            <div>New/Updated DHCP object parameters</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">{&#x27;address_state&#x27;: &#x27;InactiveReservation&#x27;, &#x27;client_id&#x27;: &#x27;0a-0b-0c-04-05-aa&#x27;, &#x27;description&#x27;: &#x27;Really Fancy&#x27;, &#x27;ip_address&#x27;: &#x27;172.16.98.230&#x27;, &#x27;name&#x27;: None, &#x27;scope_id&#x27;: &#x27;172.16.98.0&#x27;}</div>
                </td>
            </tr>
    </table>
    <br/><br/>


Status
------


Authors
~~~~~~~

- Joe Zollo (@joezollo)
