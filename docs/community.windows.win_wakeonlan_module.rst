.. _community.windows.win_wakeonlan_module:


*******************************
community.windows.win_wakeonlan
*******************************

**Send a magic Wake-on-LAN (WoL) broadcast packet**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- The ``win_wakeonlan`` module sends magic Wake-on-LAN (WoL) broadcast packets.
- For non-Windows targets, use the :ref:`community.general.wakeonlan <community.general.wakeonlan_module>` module instead.




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
                    <b>broadcast</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <b>Default:</b><br/><div style="color: blue">"255.255.255.255"</div>
                </td>
                <td>
                        <div>Network broadcast address to use for broadcasting magic Wake-on-LAN packet.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>mac</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                         / <span style="color: red">required</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>MAC address to send Wake-on-LAN broadcast packet for.</div>
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
                        <b>Default:</b><br/><div style="color: blue">7</div>
                </td>
                <td>
                        <div>UDP port to use for magic Wake-on-LAN packet.</div>
                </td>
            </tr>
    </table>
    <br/>


Notes
-----

.. note::
   - This module sends a magic packet, without knowing whether it worked. It always report a change.
   - Only works if the target system was properly configured for Wake-on-LAN (in the BIOS and/or the OS).
   - Some BIOSes have a different (configurable) Wake-on-LAN boot order (i.e. PXE first).


See Also
--------

.. seealso::

   :ref:`community.general.wakeonlan_module`
      The official documentation on the **community.general.wakeonlan** module.


Examples
--------

.. code-block:: yaml

    - name: Send a magic Wake-on-LAN packet to 00:00:5E:00:53:66
      community.windows.win_wakeonlan:
        mac: 00:00:5E:00:53:66
        broadcast: 192.0.2.23

    - name: Send a magic Wake-On-LAN packet on port 9 to 00-00-5E-00-53-66
      community.windows.win_wakeonlan:
        mac: 00-00-5E-00-53-66
        port: 9
      delegate_to: remote_system




Status
------


Authors
~~~~~~~

- Dag Wieers (@dagwieers)
