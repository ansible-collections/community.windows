.. _community.windows.win_hosts_module:


***************************
community.windows.win_hosts
***************************

**Manages hosts file entries on Windows.**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Manages hosts file entries on Windows.
- Maps IPv4 or IPv6 addresses to canonical names.
- Adds, removes, or sets cname records for ip and hostname pairs.
- Modifies %windir%\\system32\\drivers\\etc\\hosts.




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
                                    <li>add</li>
                                    <li>remove</li>
                                    <li><div style="color: blue"><b>set</b>&nbsp;&larr;</div></li>
                        </ul>
                </td>
                <td>
                        <div>Controls the behavior of <em>aliases</em>.</div>
                        <div>Only applicable when <code>state=present</code>.</div>
                        <div>If <code>add</code>, each alias in <em>aliases</em> will be added to the host entry.</div>
                        <div>If <code>set</code>, each alias in <em>aliases</em> will be added to the host entry, and other aliases will be removed from the entry.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>aliases</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">list</span>
                         / <span style="color: purple">elements=string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>A list of additional names (cname records) for the host entry.</div>
                        <div>Only applicable when <code>state=present</code>.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>canonical_name</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>A canonical name for the host entry.</div>
                        <div>required for <code>state=present</code>.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>ip_address</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The ip address for the host entry.</div>
                        <div>Can be either IPv4 (A record) or IPv6 (AAAA record).</div>
                        <div>Required for <code>state=present</code>.</div>
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
                        <div>Whether the entry should be present or absent.</div>
                        <div>If only <em>canonical_name</em> is provided when <code>state=absent</code>, then all hosts entries with the canonical name of <em>canonical_name</em> will be removed.</div>
                        <div>If only <em>ip_address</em> is provided when <code>state=absent</code>, then all hosts entries with the ip address of <em>ip_address</em> will be removed.</div>
                        <div>If <em>ip_address</em> and <em>canonical_name</em> are both omitted when <code>state=absent</code>, then all hosts entries will be removed.</div>
                </td>
            </tr>
    </table>
    <br/>


Notes
-----

.. note::
   - Each canonical name can only be mapped to one IPv4 and one IPv6 address. If *canonical_name* is provided with ``state=present`` and is found to be mapped to another IP address that is the same type as, but unique from *ip_address*, then *canonical_name* and all *aliases* will be removed from the entry and added to an entry with the provided IP address.
   - Each alias can only be mapped to one canonical name. If *aliases* is provided with ``state=present`` and an alias is found to be mapped to another canonical name, then the alias will be removed from the entry and either added to or removed from (depending on *action*) an entry with the provided canonical name.


See Also
--------

.. seealso::

   :ref:`ansible.windows.win_template_module`
      The official documentation on the **ansible.windows.win_template** module.
   :ref:`ansible.windows.win_file_module`
      The official documentation on the **ansible.windows.win_file** module.
   :ref:`ansible.windows.win_copy_module`
      The official documentation on the **ansible.windows.win_copy** module.


Examples
--------

.. code-block:: yaml

    - name: Add 127.0.0.1 as an A record for localhost
      community.windows.win_hosts:
        state: present
        canonical_name: localhost
        ip_address: 127.0.0.1

    - name: Add ::1 as an AAAA record for localhost
      community.windows.win_hosts:
        state: present
        canonical_name: localhost
        ip_address: '::1'

    - name: Remove 'bar' and 'zed' from the list of aliases for foo (192.168.1.100)
      community.windows.win_hosts:
        state: present
        canonical_name: foo
        ip_address: 192.168.1.100
        action: remove
        aliases:
          - bar
          - zed

    - name: Remove hosts entries with canonical name 'bar'
      community.windows.win_hosts:
        state: absent
        canonical_name: bar

    - name: Remove 10.2.0.1 from the list of hosts
      community.windows.win_hosts:
        state: absent
        ip_address: 10.2.0.1

    - name: Ensure all name resolution is handled by DNS
      community.windows.win_hosts:
        state: absent




Status
------


Authors
~~~~~~~

- Micah Hunsberger (@mhunsber)
