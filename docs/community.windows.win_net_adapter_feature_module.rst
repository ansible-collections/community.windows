.. _community.windows.win_net_adapter_feature_module:


*****************************************
community.windows.win_net_adapter_feature
*****************************************

**Enable or disable certain network adapters.**


Version added: 1.2.0

.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Enable or disable some network components of a certain network adapter or all the network adapters.




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
                    <b>component_id</b>
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
                        <div>Specify the below component_id of network adapters.</div>
                        <div>component_id (DisplayName)</div>
                        <div><code>ms_implat</code> (Microsoft Network Adapter Multiplexor Protocol)</div>
                        <div><code>ms_lltdio</code> (Link-Layer Topology Discovery Mapper I/O Driver)</div>
                        <div><code>ms_tcpip6</code> (Internet Protocol Version 6 (TCP/IPv6))</div>
                        <div><code>ms_tcpip</code> (Internet Protocol Version 4 (TCP/IPv4))</div>
                        <div><code>ms_lldp</code> (Microsoft LLDP Protocol Driver)</div>
                        <div><code>ms_rspndr</code> (Link-Layer Topology Discovery Responder)</div>
                        <div><code>ms_msclient</code> (Client for Microsoft Networks)</div>
                        <div><code>ms_pacer</code> (QoS Packet Scheduler)</div>
                        <div>If you&#x27;d like to set custom adapters like &#x27;Juniper Network Service&#x27;, get the <em>component_id</em> by running the <code>Get-NetAdapterBinding</code> cmdlet.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>interface</b>
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
                        <div>Name of Network Adapter Interface. For example, <code>Ethernet0</code> or <code>*</code>.</div>
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
                                    <li><div style="color: blue"><b>enabled</b>&nbsp;&larr;</div></li>
                                    <li>disabled</li>
                        </ul>
                </td>
                <td>
                        <div>Specify the state of ms_tcpip6 of interfaces.</div>
                </td>
            </tr>
    </table>
    <br/>




Examples
--------

.. code-block:: yaml

    - name: enable multiple interfaces of multiple interfaces
      community.windows.win_net_adapter_feature:
        interface:
        - 'Ethernet0'
        - 'Ethernet1'
        state: enabled
        component_id:
        - ms_tcpip6
        - ms_server

    - name: Enable ms_tcpip6 of all the Interface
      community.windows.win_net_adapter_feature:
        interface: '*'
        state: enabled
        component_id:
        - ms_tcpip6




Status
------


Authors
~~~~~~~

- ライトウェルの人 (@jirolin)
