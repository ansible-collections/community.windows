.. _community.windows.win_rds_rap_module:


*****************************
community.windows.win_rds_rap
*****************************

**Manage Resource Authorization Policies (RAP) on a Remote Desktop Gateway server**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Creates, removes and configures a Remote Desktop resource authorization policy (RD RAP).
- A RD RAP allows you to specify the network resources (computers) that users can connect to remotely through a Remote Desktop Gateway server.



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
                    <b>allowed_ports</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">list</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>List of port numbers through which connections are allowed for this policy.</div>
                        <div>To allow connections through any port, specify &#x27;any&#x27;.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>computer_group</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The computer group name that is associated with this resource authorization policy (RAP).</div>
                        <div>This is required when <em>computer_group_type</em> is <code>rdg_group</code> or <code>ad_network_resource_group</code>.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>computer_group_type</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>rdg_group</li>
                                    <li>ad_network_resource_group</li>
                                    <li>allow_any</li>
                        </ul>
                </td>
                <td>
                        <div>The computer group type:</div>
                        <div><code>rdg_group</code>: RD Gateway-managed group</div>
                        <div><code>ad_network_resource_group</code>: Active Directory Domain Services network resource group</div>
                        <div><code>allow_any</code>: Allow users to connect to any network resource.</div>
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
                        <div>Optional description of the resource authorization policy.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>name</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">-</span>
                         / <span style="color: red">required</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Name of the resource authorization policy.</div>
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
                                    <li>disabled</li>
                                    <li>enabled</li>
                                    <li><div style="color: blue"><b>present</b>&nbsp;&larr;</div></li>
                        </ul>
                </td>
                <td>
                        <div>The state of resource authorization policy.</div>
                        <div>If <code>absent</code> will ensure the policy is removed.</div>
                        <div>If <code>present</code> will ensure the policy is configured and exists.</div>
                        <div>If <code>enabled</code> will ensure the policy is configured, exists and enabled.</div>
                        <div>If <code>disabled</code> will ensure the policy is configured, exists, but disabled.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>user_groups</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">list</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>List of user groups that are associated with this resource authorization policy (RAP). A user must belong to one of these groups to access the RD Gateway server.</div>
                        <div>Required when a new RAP is created.</div>
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

    - name: Create a new RDS RAP
      community.windows.win_rds_rap:
        name: My RAP
        description: Allow all users to connect to any resource through ports 3389 and 3390
        user_groups:
          - BUILTIN\users
        computer_group_type: allow_any
        allowed_ports:
          - 3389
          - 3390
        state: enabled




Status
------


Authors
~~~~~~~

- Kevin Subileau (@ksubileau)
