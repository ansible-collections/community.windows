.. _community.windows.win_firewall_module:


******************************
community.windows.win_firewall
******************************

**Enable or disable the Windows Firewall**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Enable or Disable Windows Firewall profiles.



Requirements
------------
The below requirements are needed on the host that executes this module.

- This module requires Windows Management Framework 5 or later.


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
                    <b>inbound_action</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                    <div style="font-style: italic; font-size: small; color: darkgreen">added in 1.1.0</div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>allow</li>
                                    <li>block</li>
                                    <li>not_configured</li>
                        </ul>
                </td>
                <td>
                        <div>Set to <code>allow</code> or <code>block</code> inbound network traffic in the profile.</div>
                        <div><code>not_configured</code> is valid when configuring a GPO.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>outbound_action</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                    <div style="font-style: italic; font-size: small; color: darkgreen">added in 1.1.0</div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>allow</li>
                                    <li>block</li>
                                    <li>not_configured</li>
                        </ul>
                </td>
                <td>
                        <div>Set to <code>allow</code> or <code>block</code> inbound network traffic in the profile.</div>
                        <div><code>not_configured</code> is valid when configuring a GPO.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>profiles</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">list</span>
                         / <span style="color: purple">elements=string</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li><div style="color: blue"><b>Domain</b>&nbsp;&larr;</div></li>
                                    <li><div style="color: blue"><b>Private</b>&nbsp;&larr;</div></li>
                                    <li><div style="color: blue"><b>Public</b>&nbsp;&larr;</div></li>
                        </ul>
                        <b>Default:</b><br/><div style="color: blue">["Domain", "Private", "Public"]</div>
                </td>
                <td>
                        <div>Specify one or more profiles to change.</div>
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
                                    <li>disabled</li>
                                    <li>enabled</li>
                        </ul>
                </td>
                <td>
                        <div>Set state of firewall for given profile.</div>
                </td>
            </tr>
    </table>
    <br/>



See Also
--------

.. seealso::

   :ref:`community.windows.win_firewall_rule_module`
      The official documentation on the **community.windows.win_firewall_rule** module.


Examples
--------

.. code-block:: yaml

    - name: Enable firewall for Domain, Public and Private profiles
      community.windows.win_firewall:
        state: enabled
        profiles:
        - Domain
        - Private
        - Public
      tags: enable_firewall

    - name: Disable Domain firewall
      community.windows.win_firewall:
        state: disabled
        profiles:
        - Domain
      tags: disable_firewall

    - name: Enable firewall for Domain profile and block outbound connections
      community.windows.win_firewall:
        profiles: Domain
        state: enabled
        outbound_action: block
      tags: block_connection



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
                    <b>enabled</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">boolean</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Current firewall status for chosen profile (after any potential change).</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">True</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>profiles</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Chosen profile.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">Domain</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>state</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">list</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Desired state of the given firewall profile(s).</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">enabled</div>
                </td>
            </tr>
    </table>
    <br/><br/>


Status
------


Authors
~~~~~~~

- Michael Eaton (@michaeldeaton)
