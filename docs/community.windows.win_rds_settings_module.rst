.. _community.windows.win_rds_settings_module:


**********************************
community.windows.win_rds_settings
**********************************

**Manage main settings of a Remote Desktop Gateway server**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Configure general settings of a Remote Desktop Gateway server.



Requirements
------------
The below requirements are needed on the host that executes this module.

- Windows Server 2008R2 (6.1) or higher.
- The Windows Feature "RDS-Gateway" must be enabled.


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
                    <b>certificate_hash</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Certificate hash (thumbprint) for the Remote Desktop Gateway server. The certificate hash is the unique identifier for the certificate.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>enable_only_messaging_capable_clients</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">boolean</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>no</li>
                                    <li>yes</li>
                        </ul>
                </td>
                <td>
                        <div>If enabled, only clients that support logon messages and administrator messages can connect.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>max_connections</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The maximum number of connections allowed.</div>
                        <div>If set to <code>0</code>, no new connections are allowed.</div>
                        <div>If set to <code>-1</code>, the number of connections is unlimited.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>ssl_bridging</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>https_http</li>
                                    <li>https_https</li>
                                    <li>none</li>
                        </ul>
                </td>
                <td>
                        <div>Specifies whether to use SSL Bridging.</div>
                        <div><code>none</code>: no SSL bridging.</div>
                        <div><code>https_http</code>: HTTPS-HTTP bridging.</div>
                        <div><code>https_https</code>: HTTPS-HTTPS bridging.</div>
                </td>
            </tr>
    </table>
    <br/>



See Also
--------

.. seealso::

   :ref:`community.windows.win_rds_cap_module`
      The official documentation on the **community.windows.win_rds_cap** module.
   :ref:`community.windows.win_rds_rap_module`
      The official documentation on the **community.windows.win_rds_rap** module.
   :ref:`community.windows.win_rds_settings_module`
      The official documentation on the **community.windows.win_rds_settings** module.


Examples
--------

.. code-block:: yaml

    - name: Configure the Remote Desktop Gateway
      community.windows.win_rds_settings:
        certificate_hash: B0D0FA8408FC67B230338FCA584D03792DA73F4C
        max_connections: 50
      notify:
        - Restart TSGateway service




Status
------


Authors
~~~~~~~

- Kevin Subileau (@ksubileau)
