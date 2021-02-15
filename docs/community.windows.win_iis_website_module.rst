.. _community.windows.win_iis_website_module:


*********************************
community.windows.win_iis_website
*********************************

**Configures a IIS Web site**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Creates, Removes and configures a IIS Web site.




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
                    <b>application_pool</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The application pool in which the new site executes.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>hostname</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The host header to bind to / use for the new site.</div>
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
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>parameters</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Custom site Parameters from string where properties are separated by a pipe and property name/values by colon Ex. &quot;foo:1|bar:2&quot;</div>
                        <div>Some custom parameters that you can use are listed below, this isn&#x27;t a definitive list but some common parameters.</div>
                        <div><code>logfile.directory</code> - Physical path to store Logs, e.g. <code>D:\IIS-LOGs\</code>.</div>
                        <div><code>logfile.period</code> - Log file rollover scheduled accepting these values, how frequently the log file should be rolled-over, e.g. <code>Hourly, Daily, Weekly, Monthly</code>.</div>
                        <div><code>logfile.LogFormat</code> - Log file format, by default IIS uses <code>W3C</code>.</div>
                        <div><code>logfile.truncateSize</code> - The size at which the log file contents will be trunsted, expressed in bytes.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>physical_path</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The physical path on the remote host to use for the new site.</div>
                        <div>The specified folder must already exist.</div>
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
                </td>
                <td>
                        <div>The port to bind to / use for the new site.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>site_id</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Explicitly set the IIS numeric ID for a site.</div>
                        <div>Note that this value cannot be changed after the website has been created.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>ssl</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Enables HTTPS binding on the site..</div>
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
                                    <li>started</li>
                                    <li>stopped</li>
                                    <li>restarted</li>
                        </ul>
                </td>
                <td>
                        <div>State of the web site</div>
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
   :ref:`community.windows.win_iis_webbinding_module`
      The official documentation on the **community.windows.win_iis_webbinding** module.


Examples
--------

.. code-block:: yaml

    # Start a website

    - name: Acme IIS site
      community.windows.win_iis_website:
        name: Acme
        state: started
        port: 80
        ip: 127.0.0.1
        hostname: acme.local
        application_pool: acme
        physical_path: C:\sites\acme
        parameters: logfile.directory:C:\sites\logs
      register: website

    # Remove Default Web Site and the standard port 80 binding
    - name: Remove Default Web Site
      community.windows.win_iis_website:
        name: "Default Web Site"
        state: absent

    # Create a WebSite with custom Logging configuration (Logs Location, Format and Rolling Over).

    - name: Creating WebSite with Custom Log location, Format 3WC and rolling over every hour.
      community.windows.win_iis_website:
        name: MyCustom_Web_Shop_Site
        state: started
        port: 80
        ip: '*'
        hostname: '*'
        physical_path: D:\wwwroot\websites\my-shop-site
        parameters: logfile.directory:D:\IIS-LOGS\websites\my-shop-site|logfile.period:Hourly|logFile.logFormat:W3C
        application_pool: my-shop-site

    # Some commandline examples:

    # This return information about an existing host
    # $ ansible -i vagrant-inventory -m community.windows.win_iis_website -a "name='Default Web Site'" window
    # host | success >> {
    #     "changed": false,
    #     "site": {
    #         "ApplicationPool": "DefaultAppPool",
    #         "Bindings": [
    #             "*:80:"
    #         ],
    #         "ID": 1,
    #         "Name": "Default Web Site",
    #         "PhysicalPath": "%SystemDrive%\\inetpub\\wwwroot",
    #         "State": "Stopped"
    #     }
    # }

    # This stops an existing site.
    # $ ansible -i hosts -m community.windows.win_iis_website -a "name='Default Web Site' state=stopped" host

    # This creates a new site.
    # $ ansible -i hosts -m community.windows.win_iis_website -a "name=acme physical_path=C:\\sites\\acme" host

    # Change logfile.
    # $ ansible -i hosts -m community.windows.win_iis_website -a "name=acme physical_path=C:\\sites\\acme" host




Status
------


Authors
~~~~~~~

- Henrik Wallström (@henrikwallstrom)
