.. _community.windows.win_firewall_rule_module:


***********************************
community.windows.win_firewall_rule
***********************************

**Windows firewall automation**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Allows you to create/remove/update firewall rules.




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
                    <b>action</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>allow</li>
                                    <li>block</li>
                        </ul>
                </td>
                <td>
                        <div>What to do with the items this rule is for.</div>
                        <div>Defaults to <code>allow</code> when creating a new rule.</div>
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
                        <div>Description for the firewall rule.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>direction</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>in</li>
                                    <li>out</li>
                        </ul>
                </td>
                <td>
                        <div>Whether this rule is for inbound or outbound traffic.</div>
                        <div>Defaults to <code>in</code> when creating a new rule.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>enabled</b>
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
                        <div>Whether this firewall rule is enabled or disabled.</div>
                        <div>Defaults to <code>true</code> when creating a new rule.</div>
                        <div style="font-size: small; color: darkgreen"><br/>aliases: enable</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>group</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The group name for the rule.</div>
                        <div>If <em>name</em> is not specified then the module will set the firewall options for all the rules in this group.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>icmp_type_code</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">list</span>
                         / <span style="color: purple">elements=string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The ICMP types and codes for the rule.</div>
                        <div>This is only valid when <em>protocol</em> is <code>icmpv4</code> or <code>icmpv6</code>.</div>
                        <div>Each entry follows the format <code>type:code</code> where <code>type</code> is the type number and <code>code</code> is the code number for that type or <code>*</code> for all codes.</div>
                        <div>Set the value to just <code>*</code> to apply the rule for all ICMP type codes.</div>
                        <div>See <a href='https://www.iana.org/assignments/icmp-parameters/icmp-parameters.xhtml'>https://www.iana.org/assignments/icmp-parameters/icmp-parameters.xhtml</a> for a list of ICMP types and the codes that apply to them.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>localip</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The local ip address this rule applies to.</div>
                        <div>Set to <code>any</code> to apply to all local ip addresses.</div>
                        <div>Defaults to <code>any</code> when creating a new rule.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>localport</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The local port this rule applies to.</div>
                        <div>Set to <code>any</code> to apply to all local ports.</div>
                        <div>Defaults to <code>any</code> when creating a new rule.</div>
                        <div>Must have <em>protocol</em> set</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>name</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The rule&#x27;s display name.</div>
                        <div>This is required unless <em>group</em> is specified.</div>
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
                </td>
                <td>
                        <div>The profile this rule applies to.</div>
                        <div>Defaults to <code>domain,private,public</code> when creating a new rule.</div>
                        <div style="font-size: small; color: darkgreen"><br/>aliases: profile</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>program</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The program this rule applies to.</div>
                        <div>Set to <code>any</code> to apply to all programs.</div>
                        <div>Defaults to <code>any</code> when creating a new rule.</div>
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
                </td>
                <td>
                        <div>The protocol this rule applies to.</div>
                        <div>Set to <code>any</code> to apply to all services.</div>
                        <div>Defaults to <code>any</code> when creating a new rule.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>remoteip</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The remote ip address/range this rule applies to.</div>
                        <div>Set to <code>any</code> to apply to all remote ip addresses.</div>
                        <div>Defaults to <code>any</code> when creating a new rule.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>remoteport</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The remote port this rule applies to.</div>
                        <div>Set to <code>any</code> to apply to all remote ports.</div>
                        <div>Defaults to <code>any</code> when creating a new rule.</div>
                        <div>Must have <em>protocol</em> set</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>service</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The service this rule applies to.</div>
                        <div>Set to <code>any</code> to apply to all services.</div>
                        <div>Defaults to <code>any</code> when creating a new rule.</div>
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
                        <div>Should this rule be added or removed.</div>
                </td>
            </tr>
    </table>
    <br/>


Notes
-----

.. note::
   - Multiple firewall rules can share the same *name*, if there are multiple matches then the module will set the user defined options for each matching rule.


See Also
--------

.. seealso::

   :ref:`community.windows.win_firewall_module`
      The official documentation on the **community.windows.win_firewall** module.


Examples
--------

.. code-block:: yaml

    - name: Firewall rule to allow SMTP on TCP port 25
      community.windows.win_firewall_rule:
        name: SMTP
        localport: 25
        action: allow
        direction: in
        protocol: tcp
        state: present
        enabled: yes

    - name: Firewall rule to allow RDP on TCP port 3389
      community.windows.win_firewall_rule:
        name: Remote Desktop
        localport: 3389
        action: allow
        direction: in
        protocol: tcp
        profiles: private
        state: present
        enabled: yes

    - name: Firewall rule to be created for application group
      community.windows.win_firewall_rule:
        name: SMTP
        group: application
        localport: 25
        action: allow
        direction: in
        protocol: tcp
        state: present
        enabled: yes

    - name: Enable all the Firewall rules in application group
      win_firewall_rule:
        group: application
        enabled: yes

    - name: Firewall rule to allow port range
      community.windows.win_firewall_rule:
        name: Sample port range
        localport: 5000-5010
        action: allow
        direction: in
        protocol: tcp
        state: present
        enabled: yes

    - name: Firewall rule to allow ICMP v4 echo (ping)
      community.windows.win_firewall_rule:
        name: ICMP Allow incoming V4 echo request
        enabled: yes
        state: present
        profiles: private
        action: allow
        direction: in
        protocol: icmpv4
        icmp_type_code:
        - '8:*'

    - name: Firewall rule to alloc ICMP v4 on all type codes
      community.windows.win_firewall_rule:
        name: ICMP Allow incoming V4 echo request
        enabled: yes
        state: present
        profiles: private
        action: allow
        direction: in
        protocol: icmpv4
        icmp_type_code: '*'




Status
------


Authors
~~~~~~~

- Artem Zinenko (@ar7z1)
- Timothy Vandenbrande (@TimothyVandenbrande)
