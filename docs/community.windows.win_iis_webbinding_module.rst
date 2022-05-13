.. _community.windows.win_iis_webbinding_module:


************************************
community.windows.win_iis_webbinding
************************************

**Configures a IIS Web site binding**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Creates, removes and configures a binding to an existing IIS Web site.




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
                        <div>Certificate hash (thumbprint) for the SSL binding. The certificate hash is the unique identifier for the certificate.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>certificate_store_name</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <b>Default:</b><br/><div style="color: blue">"my"</div>
                </td>
                <td>
                        <div>Name of the certificate store where the certificate for the binding is located.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>host_header</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The host header to bind to / use for the new site.</div>
                        <div>If you are creating/removing a catch-all binding, omit this parameter rather than defining it as &#x27;*&#x27;.</div>
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
                        <b>Default:</b><br/><div style="color: blue">"*"</div>
                </td>
                <td>
                        <div>The IP address to bind to / use for the new site.</div>
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
                        <div>Names of web site.</div>
                        <div style="font-size: small; color: darkgreen"><br/>aliases: website</div>
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
                        <b>Default:</b><br/><div style="color: blue">80</div>
                </td>
                <td>
                        <div>The port to bind to / use for the new site.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>protocol</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <b>Default:</b><br/><div style="color: blue">"http"</div>
                </td>
                <td>
                        <div>The protocol to be used for the Web binding (usually HTTP, HTTPS, or FTP).</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>ssl_flags</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>This parameter is only valid on Server 2012 and newer.</div>
                        <div>Primarily used for enabling and disabling server name indication (SNI).</div>
                        <div>Set to <code>0</code> to disable SNI.</div>
                        <div>Set to <code>1</code> to enable SNI.</div>
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
                        <div>State of the binding.</div>
                </td>
            </tr>
    </table>
    <br/>



See Also
--------

.. seealso::

   :ref:`community.windows.win_iis_virtualdirectory_module`
      The official documentation on the **community.windows.win_iis_virtualdirectory** module.
   :ref:`community.windows.win_iis_webapplication_module`
      The official documentation on the **community.windows.win_iis_webapplication** module.
   :ref:`community.windows.win_iis_webapppool_module`
      The official documentation on the **community.windows.win_iis_webapppool** module.
   :ref:`community.windows.win_iis_website_module`
      The official documentation on the **community.windows.win_iis_website** module.


Examples
--------

.. code-block:: yaml

    - name: Add a HTTP binding on port 9090
      community.windows.win_iis_webbinding:
        name: Default Web Site
        port: 9090
        state: present

    - name: Remove the HTTP binding on port 9090
      community.windows.win_iis_webbinding:
        name: Default Web Site
        port: 9090
        state: absent

    - name: Remove the default http binding
      community.windows.win_iis_webbinding:
        name: Default Web Site
        port: 80
        ip: '*'
        state: absent

    - name: Add a HTTPS binding
      community.windows.win_iis_webbinding:
        name: Default Web Site
        protocol: https
        port: 443
        ip: 127.0.0.1
        certificate_hash: B0D0FA8408FC67B230338FCA584D03792DA73F4C
        state: present

    - name: Add a HTTPS binding with host header and SNI enabled
      community.windows.win_iis_webbinding:
        name: Default Web Site
        protocol: https
        port: 443
        host_header: test.com
        ssl_flags: 1
        certificate_hash: D1A3AF8988FD32D1A3AF8988FD323792DA73F4C
        state: present



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
                    <b>binding_info</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">dictionary</span>
                    </div>
                </td>
                <td>on success</td>
                <td>
                            <div>Information on the binding being manipulated</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">&quot;binding_info&quot;: {
      &quot;bindingInformation&quot;: &quot;127.0.0.1:443:&quot;,
      &quot;certificateHash&quot;: &quot;FF3910CE089397F1B5A77EB7BAFDD8F44CDE77DD&quot;,
      &quot;certificateStoreName&quot;: &quot;MY&quot;,
      &quot;hostheader&quot;: &quot;&quot;,
      &quot;ip&quot;: &quot;127.0.0.1&quot;,
      &quot;port&quot;: 443,
      &quot;protocol&quot;: &quot;https&quot;,
      &quot;sslFlags&quot;: &quot;not supported&quot;
    }</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>operation_type</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>on success</td>
                <td>
                            <div>The type of operation performed</div>
                            <div>Can be removed, updated, matched, or added</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">removed</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>website_state</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>The state of the website being targetted</div>
                            <div>Can be helpful in case you accidentally cause a binding collision which can result in the targetted site being stopped</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">Started</div>
                </td>
            </tr>
    </table>
    <br/><br/>


Status
------


Authors
~~~~~~~

- Noah Sparks (@nwsparks)
- Henrik Wallström (@henrikwallstrom)
