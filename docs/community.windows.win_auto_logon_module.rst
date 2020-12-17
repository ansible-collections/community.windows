.. _community.windows.win_auto_logon_module:


********************************
community.windows.win_auto_logon
********************************

**Adds or Sets auto logon registry keys.**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Used to apply auto logon registry setting.




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
                    <b>logon_count</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The number of times to do an automatic logon.</div>
                        <div>This count is deremented by Windows everytime an automatic logon is performed.</div>
                        <div>Once the count reaches <code>0</code> then the automatic logon process is disabled.</div>
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
                        <div>Password to be used for automatic login.</div>
                        <div>Must be set when <code>state=present</code>.</div>
                        <div>Value of this input will be used as password for <em>username</em>.</div>
                        <div>While this value is encrypted by LSA it is decryptable to any user who is an Administrator on the remote host.</div>
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
                        <div>Whether the registry key should be <code>present</code> or <code>absent</code>.</div>
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
                </td>
                <td>
                </td>
                <td>
                        <div>Username to login automatically.</div>
                        <div>Must be set when <code>state=present</code>.</div>
                        <div>This can be the Netlogon or UPN of a domain account and is automatically parsed to the <code>DefaultUserName</code> and <code>DefaultDomainName</code> registry properties.</div>
                </td>
            </tr>
    </table>
    <br/>




Examples
--------

.. code-block:: yaml

    - name: Set autologon for user1
      community.windows.win_auto_logon:
        username: User1
        password: str0ngp@ssword

    - name: Set autologon for abc.com\user1
      community.windows.win_auto_logon:
        username: abc.com\User1
        password: str0ngp@ssword

    - name: Remove autologon for user1
      community.windows.win_auto_logon:
        state: absent

    - name: Set autologon for user1 with a limited logon count
      community.windows.win_auto_logon:
        username: User1
        password: str0ngp@ssword
        logon_count: 5




Status
------


Authors
~~~~~~~

- Prasoon Karunan V (@prasoonkarunan)
