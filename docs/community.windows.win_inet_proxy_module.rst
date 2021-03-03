.. _community.windows.win_inet_proxy_module:


********************************
community.windows.win_inet_proxy
********************************

**Manages proxy settings for WinINet and Internet Explorer**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Used to set or remove proxy settings for Windows INet which includes Internet Explorer.
- WinINet is a framework used by interactive applications to submit web requests through.
- The proxy settings can also be used by other applications like Firefox, Chrome, and others but there is no definitive list.




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
                    <b>auto_config_url</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The URL of a proxy configuration script.</div>
                        <div>Proxy configuration scripts are typically JavaScript files with the <code>.pac</code> extension that implement the C(FindProxyForUR<a href='host'>url</a> function.</div>
                        <div>Omit, set to null or an empty string to remove the auto config URL.</div>
                        <div>This corresponds to the checkbox <em>Use automatic configuration script</em> in the connection settings window.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>auto_detect</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">boolean</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>no</li>
                                    <li><div style="color: blue"><b>yes</b>&nbsp;&larr;</div></li>
                        </ul>
                </td>
                <td>
                        <div>Whether to configure WinINet to automatically detect proxy settings through Web Proxy Auto-Detection <code>WPAD</code>.</div>
                        <div>This corresponds to the checkbox <em>Automatically detect settings</em> in the connection settings window.</div>
                </td>
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
                        <div>Use <code>&lt;local&gt;</code> to match hostnames that are not fully qualified domain names. This is useful when needing to connect to intranet sites using just the hostname. If defined, this should be the last entry in the bypass list.</div>
                        <div>Use <code>&lt;-loopback&gt;</code> to stop automatically bypassing the proxy when connecting through any loopback address like <code>127.0.0.1</code>, <code>localhost</code>, or the local hostname.</div>
                        <div>Omit, set to null or an empty string/list to remove the bypass list.</div>
                        <div>If this is set then <em>proxy</em> must also be set.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>connection</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The name of the IE connection to set the proxy settings for.</div>
                        <div>These are the connections under the <em>Dial-up and Virtual Private Network</em> header in the IE settings.</div>
                        <div>When omitted, the default LAN connection is used.</div>
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
    </table>
    <br/>


Notes
-----

.. note::
   - This is not the same as the proxy settings set in WinHTTP through the ``netsh`` command. Use the :ref:`community.windows.win_http_proxy <community.windows.win_http_proxy_module>` module to manage that instead.
   - These settings are by default set per user and not system wide. A registry property must be set independently from this module if you wish to apply the proxy for all users. See examples for more detail.
   - If per user proxy settings are desired, use *become* to become any local user on the host. No password is needed to be set for this to work.
   - If the proxy requires authentication, set the credentials using the :ref:`community.windows.win_credential <community.windows.win_credential_module>` module. This requires *become* to be used so the credential store can be accessed.


See Also
--------

.. seealso::

   :ref:`community.windows.win_http_proxy_module`
      The official documentation on the **community.windows.win_http_proxy** module.
   :ref:`community.windows.win_credential_module`
      The official documentation on the **community.windows.win_credential** module.


Examples
--------

.. code-block:: yaml

    # This should be set before running the win_inet_proxy module
    - name: Configure IE proxy settings to apply to all users
      ansible.windows.win_regedit:
        path: HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings
        name: ProxySettingsPerUser
        data: 0
        type: dword
        state: present

    # This should be set before running the win_inet_proxy module
    - name: Configure IE proxy settings to apply per user
      ansible.windows.win_regedit:
        path: HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings
        name: ProxySettingsPerUser
        data: 1
        type: dword
        state: present

    - name: Configure IE proxy to use auto detected settings without an explicit proxy
      win_inet_proxy:
        auto_detect: yes

    - name: Configure IE proxy to use auto detected settings with a configuration script
      win_inet_proxy:
        auto_detect: yes
        auto_config_url: http://proxy.ansible.com/proxy.pac

    - name: Configure IE to use explicit proxy host
      win_inet_proxy:
        auto_detect: yes
        proxy: ansible.proxy

    - name: Configure IE to use explicit proxy host with port and without auto detection
      win_inet_proxy:
        auto_detect: no
        proxy: ansible.proxy:8080

    - name: Configure IE to use a specific proxy per protocol
      win_inet_proxy:
        proxy:
          http: ansible.proxy:8080
          https: ansible.proxy:8443

    - name: Configure IE to use a specific proxy per protocol using a string
      win_inet_proxy:
        proxy: http=ansible.proxy:8080;https=ansible.proxy:8443

    - name: Set a proxy with a bypass list
      win_inet_proxy:
        proxy: ansible.proxy
        bypass:
        - server1
        - server2
        - <-loopback>
        - <local>

    - name: Remove any explicit proxies that are set
      win_inet_proxy:
        proxy: ''
        bypass: ''

    # This should be done after setting the IE proxy with win_inet_proxy
    - name: Import IE proxy configuration to WinHTTP
      win_http_proxy:
        source: ie

    # Explicit credentials can only be set per user and require become to work
    - name: Set credential to use for proxy auth
      win_credential:
        name: ansible.proxy  # The name should be the FQDN of the proxy host
        type: generic_password
        username: proxyuser
        secret: proxypass
        state: present
      become: yes
      become_user: '{{ ansible_user }}'
      become_method: runas




Status
------


Authors
~~~~~~~

- Jordan Borean (@jborean93)
