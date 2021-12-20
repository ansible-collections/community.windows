.. _community.windows.win_iis_virtualdirectory_module:


******************************************
community.windows.win_iis_virtualdirectory
******************************************

**Configures a virtual directory in IIS**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Creates, Removes and configures a virtual directory in IIS.




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
                    <b>application</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The application under which the virtual directory is created or exists.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>connect_as</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                    <div style="font-style: italic; font-size: small; color: darkgreen">added in 1.9.0</div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>pass_through</li>
                                    <li>specific_user</li>
                        </ul>
                </td>
                <td>
                        <div>The type of authentication to use for the virtual directory. Either <code>pass_through</code> or <code>specific_user</code></div>
                        <div>If <code>pass_through</code>, IIS will use the identity of the user or application pool identity to access the physical path.</div>
                        <div>If <code>specific_user</code>, IIS will use the credentials provided in <em>username</em> and <em>password</em> to access the physical path.</div>
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
                        <div>The name of the virtual directory to create or remove.</div>
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
                    <div style="font-style: italic; font-size: small; color: darkgreen">added in 1.9.0</div>
                </td>
                <td>
                </td>
                <td>
                        <div>The password associated with <em>username</em>.</div>
                        <div>Required when <em>connect_as</em> is set to <code>specific_user</code>.</div>
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
                        <div>The physical path to the folder in which the new virtual directory is created.</div>
                        <div>The specified folder must already exist.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>site</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                         / <span style="color: red">required</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The site name under which the virtual directory is created or exists.</div>
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
                        <div>Whether to add or remove the specified virtual directory.</div>
                        <div>Removing will remove the virtual directory and all under it (Recursively).</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>username</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                    <div style="font-style: italic; font-size: small; color: darkgreen">added in 1.9.0</div>
                </td>
                <td>
                </td>
                <td>
                        <div>Specifies the user name of an account that can access configuration files and content for the virtual directory.</div>
                        <div>Required when <em>connect_as</em> is set to <code>specific_user</code>.</div>
                </td>
            </tr>
    </table>
    <br/>



See Also
--------

.. seealso::

   :ref:`community.windows.win_iis_webapplication_module`
      The official documentation on the **community.windows.win_iis_webapplication** module.
   :ref:`community.windows.win_iis_webapppool_module`
      The official documentation on the **community.windows.win_iis_webapppool** module.
   :ref:`community.windows.win_iis_webbinding_module`
      The official documentation on the **community.windows.win_iis_webbinding** module.
   :ref:`community.windows.win_iis_website_module`
      The official documentation on the **community.windows.win_iis_website** module.


Examples
--------

.. code-block:: yaml

    - name: Create a virtual directory if it does not exist
      community.windows.win_iis_virtualdirectory:
        name: somedirectory
        site: somesite
        state: present
        physical_path: C:\virtualdirectory\some

    - name: Remove a virtual directory if it exists
      community.windows.win_iis_virtualdirectory:
        name: somedirectory
        site: somesite
        state: absent

    - name: Create a virtual directory on an application if it does not exist
      community.windows.win_iis_virtualdirectory:
        name: somedirectory
        site: somesite
        application: someapp
        state: present
        physical_path: C:\virtualdirectory\some




Status
------


Authors
~~~~~~~

- Henrik Wallström (@henrikwallstrom)
