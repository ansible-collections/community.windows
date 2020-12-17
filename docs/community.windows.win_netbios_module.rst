.. _community.windows.win_netbios_module:


*****************************
community.windows.win_netbios
*****************************

**Manage NetBIOS over TCP/IP settings on Windows.**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Enables or disables NetBIOS on Windows network adapters.
- Can be used to protect a system against NBT-NS poisoning and avoid NBNS broadcast storms.
- Settings can be applied system wide or per adapter.




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
                    <b>adapter_names</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">list</span>
                         / <span style="color: purple">elements=string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>List of adapter names for which to manage NetBIOS settings. If this option is omitted then configuration is applied to all adapters on the system.</div>
                        <div>The adapter name used is the connection caption in the Network Control Panel or via <code>Get-NetAdapter</code>, eg <code>Ethernet 2</code>.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>state</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                         / <span style="color: red">required</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>enabled</li>
                                    <li>disabled</li>
                                    <li>default</li>
                        </ul>
                </td>
                <td>
                        <div>Whether NetBIOS should be enabled, disabled, or default (use setting from DHCP server or if static IP address is assigned enable NetBIOS).</div>
                </td>
            </tr>
    </table>
    <br/>


Notes
-----

.. note::
   - Changing NetBIOS settings does not usually require a reboot and will take effect immediately.
   - UDP port 137/138/139 will no longer be listening once NetBIOS is disabled.



Examples
--------

.. code-block:: yaml

    - name: Disable NetBIOS system wide
      community.windows.win_netbios:
        state: disabled

    - name: Disable NetBIOS on Ethernet2
      community.windows.win_netbios:
        state: disabled
        adapter_names:
          - Ethernet2

    - name: Enable NetBIOS on Public and Backup adapters
      community.windows.win_netbios:
        state: enabled
        adapter_names:
          - Public
          - Backup

    - name: Set NetBIOS to system default on all adapters
      community.windows.win_netbios:
        state: default



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
                    <b>reboot_required</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">boolean</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Boolean value stating whether a system reboot is required.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">True</div>
                </td>
            </tr>
    </table>
    <br/><br/>


Status
------


Authors
~~~~~~~

- Thomas Moore (@tmmruk)
