.. _community.windows.win_nssm_module:


**************************
community.windows.win_nssm
**************************

**Install a service using NSSM**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Install a Windows service using the NSSM wrapper.
- NSSM is a service helper which doesn't suck. See https://nssm.cc/ for more information.



Requirements
------------
The below requirements are needed on the host that executes this module.

- nssm >= 2.24.0 # (install via :ref:`chocolatey.chocolatey.win_chocolatey <chocolatey.chocolatey.win_chocolatey_module>`) ``win_chocolatey: name=nssm``


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
                    <b>app_environment</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">dictionary</span>
                    </div>
                    <div style="font-style: italic; font-size: small; color: darkgreen">added in 1.2.0</div>
                </td>
                <td>
                </td>
                <td>
                        <div>Key/Value pairs which will be added to the environment of the service application.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>app_parameters</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>A string representing a dictionary of parameters to be passed to the application when it starts.</div>
                        <div>DEPRECATED since v2.8, please use <em>arguments</em> instead.</div>
                        <div>This is mutually exclusive with <em>arguments</em>.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>app_rotate_bytes</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>
                        <b>Default:</b><br/><div style="color: blue">104858</div>
                </td>
                <td>
                        <div>NSSM will not rotate any file which is smaller than the configured number of bytes.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>app_rotate_online</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li><div style="color: blue"><b>0</b>&nbsp;&larr;</div></li>
                                    <li>1</li>
                        </ul>
                </td>
                <td>
                        <div>If set to 1, nssm can rotate files which grow to the configured file size limit while the service is running.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>app_stop_method_console</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Time to wait after sending Control-C.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>app_stop_method_skip</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>1</li>
                                    <li>2</li>
                                    <li>3</li>
                                    <li>4</li>
                                    <li>5</li>
                                    <li>6</li>
                                    <li>7</li>
                                    <li>8</li>
                                    <li>9</li>
                                    <li>10</li>
                                    <li>11</li>
                                    <li>12</li>
                                    <li>13</li>
                                    <li>14</li>
                                    <li>15</li>
                        </ul>
                </td>
                <td>
                        <div>To disable service shutdown methods, set to the sum of one or more of the numbers</div>
                        <div>1 - Don&#x27;t send Control-C to the console.</div>
                        <div>2 - Don&#x27;t send WM_CLOSE to windows.</div>
                        <div>4 - Don&#x27;t send WM_QUIT to threads.</div>
                        <div>8 - Don&#x27;t call TerminateProcess().</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>application</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">path</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The application binary to run as a service</div>
                        <div>Required when <em>state</em> is <code>present</code>, <code>started</code>, <code>stopped</code>, or <code>restarted</code>.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>arguments</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Parameters to be passed to the application when it starts.</div>
                        <div>This can be either a simple string or a list.</div>
                        <div>This is mutually exclusive with <em>app_parameters</em>.</div>
                        <div style="font-size: small; color: darkgreen"><br/>aliases: app_parameters_free_form</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>dependencies</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">list</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Service dependencies that has to be started to trigger startup, separated by comma.</div>
                        <div>DEPRECATED, will be removed in a major release after <code>2021-07-01</code>, please use the <span class='module'>ansible.windows.win_service</span> module instead.</div>
                </td>
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
                        <div>The description to set for the service.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>display_name</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The display name to set for the service.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>executable</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">path</span>
                    </div>
                </td>
                <td>
                        <b>Default:</b><br/><div style="color: blue">"nssm.exe"</div>
                </td>
                <td>
                        <div>The location of the NSSM utility (in case it is not located in your PATH).</div>
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
                        <div>Name of the service to operate on.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>password</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Password to be used for service startup.</div>
                        <div>DEPRECATED, will be removed in a major release after <code>2021-07-01</code>, please use the <span class='module'>ansible.windows.win_service</span> module instead.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>start_mode</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li><div style="color: blue"><b>auto</b>&nbsp;&larr;</div></li>
                                    <li>delayed</li>
                                    <li>disabled</li>
                                    <li>manual</li>
                        </ul>
                </td>
                <td>
                        <div>If <code>auto</code> is selected, the service will start at bootup.</div>
                        <div><code>delayed</code> causes a delayed but automatic start after boot.</div>
                        <div><code>manual</code> means that the service will start only when another service needs it.</div>
                        <div><code>disabled</code> means that the service will stay off, regardless if it is needed or not.</div>
                        <div>DEPRECATED, will be removed in a major release after <code>2021-07-01</code>, please use the <span class='module'>ansible.windows.win_service</span> module instead.</div>
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
                                    <li>started</li>
                                    <li>stopped</li>
                                    <li>restarted</li>
                        </ul>
                </td>
                <td>
                        <div>State of the service on the system.</div>
                        <div>Values <code>started</code>, <code>stopped</code>, and <code>restarted</code> are deprecated and will be removed on a major release after <code>2021-07-01</code>. Please use the <span class='module'>ansible.windows.win_service</span> module instead to start, stop or restart the service.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>stderr_file</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">path</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Path to receive error output.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>stdout_file</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">path</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Path to receive output.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>user</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>User to be used for service startup.</div>
                        <div>DEPRECATED, will be removed in a major release after <code>2021-07-01</code>, please use the <span class='module'>ansible.windows.win_service</span> module instead.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>working_directory</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">path</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The working directory to run the service executable from (defaults to the directory containing the application binary)</div>
                        <div style="font-size: small; color: darkgreen"><br/>aliases: app_directory, chdir</div>
                </td>
            </tr>
    </table>
    <br/>


Notes
-----

.. note::
   - The service will NOT be started after its creation when ``state=present``.
   - Once the service is created, you can use the :ref:`ansible.windowswin_service <ansible.windowswin_service_module>` module to start it or configure some additionals properties, such as its startup type, dependencies, service account, and so on.


See Also
--------

.. seealso::

   :ref:`ansible.windows.win_service_module`
      The official documentation on the **ansible.windows.win_service** module.


Examples
--------

.. code-block:: yaml

    - name: Install the foo service
      community.windows.win_nssm:
        name: foo
        application: C:\windows\foo.exe

    # This will yield the following command: C:\windows\foo.exe bar "true"
    - name: Install the Consul service with a list of parameters
      community.windows.win_nssm:
        name: Consul
        application: C:\consul\consul.exe
        arguments:
          - agent
          - -config-dir=C:\consul\config

    # This is strictly equivalent to the previous example
    - name: Install the Consul service with an arbitrary string of parameters
      community.windows.win_nssm:
        name: Consul
        application: C:\consul\consul.exe
        arguments: agent -config-dir=C:\consul\config


    # Install the foo service, and then configure and start it with win_service
    - name: Install the foo service, redirecting stdout and stderr to the same file
      community.windows.win_nssm:
        name: foo
        application: C:\windows\foo.exe
        stdout_file: C:\windows\foo.log
        stderr_file: C:\windows\foo.log

    - name: Configure and start the foo service using win_service
      ansible.windows.win_service:
        name: foo
        dependencies: [ adf, tcpip ]
        username: foouser
        password: secret
        start_mode: manual
        state: started

    - name: Install a script based service and define custom environment variables
      community.windows.win_nssm:
        name: <ServiceName>
        application: C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
        arguments:
          - <path-to-script>
          - <script arg>
        app_environment:
          AUTH_TOKEN: <token value>
          SERVER_URL: https://example.com
          PATH: "<path-prepends>;{{ ansible_env.PATH }};<path-appends>"

    - name: Remove the foo service
      community.windows.win_nssm:
        name: foo
        state: absent




Status
------


Authors
~~~~~~~

- Adam Keech (@smadam813)
- George Frank (@georgefrank)
- Hans-Joachim Kliemeck (@h0nIg)
- Michael Wild (@themiwi)
- Kevin Subileau (@ksubileau)
- Shachaf Goldstein (@Shachaf92)
