.. _community.windows.win_http_proxy_module:


********************************
community.windows.win_http_proxy
********************************

**Manages proxy settings for WinHTTP**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Used to set, remove, or import proxy settings for Windows HTTP Services ``WinHTTP``.
- WinHTTP is a framework used by applications or services, typically .NET applications or non-interactive services, to make web requests.




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
                    <b>bypass</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">list</span>
                         / <span style="color: purple">elements=string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>A list of hosts that will bypass the set proxy when being accessed.</div>
                        <div>Use <code>&lt;local&gt;</code> to match hostnames that are not fully qualified domain names. This is useful when needing to connect to intranet sites using just the hostname.</div>
                        <div>Omit, set to null or an empty string/list to remove the bypass list.</div>
                        <div>If this is set then <em>proxy</em> must also be set.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>proxy</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">raw</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>A string or dict that specifies the proxy to be set.</div>
                        <div>If setting a string, should be in the form <code>hostname</code>, <code>hostname:port</code>, or <code>protocol=hostname:port</code>.</div>
                        <div>If the port is undefined, the default port for the protocol in use is used.</div>
                        <div>If setting a dict, the keys should be the protocol and the values should be the hostname and/or port for that protocol.</div>
                        <div>Valid protocols are <code>http</code>, <code>https</code>, <code>ftp</code>, and <code>socks</code>.</div>
                        <div>Omit, set to null or an empty string to remove the proxy settings.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>source</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>ie</li>
                        </ul>
                </td>
                <td>
                        <div>Instead of manually specifying the <em>proxy</em> and/or <em>bypass</em>, set this to import the proxy from a set source like Internet Explorer.</div>
                        <div>Using <code>ie</code> will import the Internet Explorer proxy settings for the current active network connection of the current user.</div>
                        <div>Only IE&#x27;s proxy URL and bypass list will be imported into WinHTTP.</div>
                        <div>This is like running <code>netsh winhttp import proxy source=ie</code>.</div>
                        <div>The value is imported when the module runs and will not automatically be updated if the IE configuration changes in the future. The module will have to be run again to sync the latest changes.</div>
                </td>
            </tr>
    </table>
    <br/>


Notes
-----

.. note::
   - This is not the same as the proxy settings set in Internet Explorer, also known as ``WinINet``; use the :ref:`community.windows.win_inet_proxy <community.windows.win_inet_proxy_module>` module to manage that instead.
   - These settings are set system wide and not per user, it will require Administrative privileges to run.


See Also
--------

.. seealso::

   :ref:`community.windows.win_inet_proxy_module`
      The official documentation on the **community.windows.win_inet_proxy** module.


Examples
--------

.. code-block:: yaml

    - name: Set a proxy to use for all protocols
      community.windows.win_http_proxy:
        proxy: hostname

    - name: Set a proxy with a specific port with a bypass list
      community.windows.win_http_proxy:
        proxy: hostname:8080
        bypass:
        - server1
        - server2
        - <local>

    - name: Set the proxy based on the IE proxy settings
      community.windows.win_http_proxy:
        source: ie

    - name: Set a proxy for specific protocols
      community.windows.win_http_proxy:
        proxy:
          http: hostname:8080
          https: hostname:8443

    - name: Set a proxy for specific protocols using a string
      community.windows.win_http_proxy:
        proxy: http=hostname:8080;https=hostname:8443
        bypass: server1,server2,<local>

    - name: Remove any proxy settings
      community.windows.win_http_proxy:
        proxy: ''
        bypass: ''




Status
------


Authors
~~~~~~~

- Jordan Borean (@jborean93)
