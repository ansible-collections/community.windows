.. _community.windows.win_user_profile_module:


**********************************
community.windows.win_user_profile
**********************************

**Manages the Windows user profiles.**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Used to create or remove user profiles on a Windows host.
- This can be used to create a profile before a user logs on or delete a profile when removing a user account.
- A profile can be created for both a local or domain account.




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
                    <b>name</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Specifies the base name for the profile path.</div>
                        <div>When <em>state</em> is <code>present</code> this is used to create the profile for <em>username</em> at a specific path within the profile directory.</div>
                        <div>This cannot be used to specify a path outside of the profile directory but rather it specifies a folder(s) within this directory.</div>
                        <div>If a profile for another user already exists at the same path, then a 3 digit incremental number is appended by Windows automatically.</div>
                        <div>When <em>state</em> is <code>absent</code> and <em>username</em> is not set, then the module will remove all profiles that point to the profile path derived by this value.</div>
                        <div>This is useful if the account no longer exists but the profile still remains.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>remove_multiple</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">boolean</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li><div style="color: blue"><b>no</b>&nbsp;&larr;</div></li>
                                    <li>yes</li>
                        </ul>
                </td>
                <td>
                        <div>When <em>state</em> is <code>absent</code> and the value for <em>name</em> matches multiple profiles the module will fail.</div>
                        <div>Set this value to <code>yes</code> to force the module to delete all the profiles found.</div>
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
                        <div>Will ensure the profile exists when set to <code>present</code>.</div>
                        <div>When creating a profile the <em>username</em> option must be set to a valid account.</div>
                        <div>Will remove the profile(s) when set to <code>absent</code>.</div>
                        <div>When removing a profile either <em>username</em> must be set to a valid account, or <em>name</em> is set to the profile&#x27;s base name.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>username</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">sid</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The account name of security identifier (SID) for the profile.</div>
                        <div>This must be set when <em>state</em> is <code>present</code> and must be a valid account or the SID of a valid account.</div>
                        <div>When <em>state</em> is <code>absent</code> then this must still be a valid account number but the SID can be a deleted user&#x27;s SID.</div>
                </td>
            </tr>
    </table>
    <br/>



See Also
--------

.. seealso::

   :ref:`ansible.windows.win_user_module`
      The official documentation on the **ansible.windows.win_user** module.
   :ref:`community.windows.win_domain_user_module`
      The official documentation on the **community.windows.win_domain_user** module.


Examples
--------

.. code-block:: yaml

    - name: Create a profile for an account
      community.windows.win_user_profile:
        username: ansible-account
        state: present

    - name: Create a profile for an account at C:\Users\ansible
      community.windows.win_user_profile:
        username: ansible-account
        name: ansible
        state: present

    - name: Remove a profile for a still valid account
      community.windows.win_user_profile:
        username: ansible-account
        state: absent

    - name: Remove a profile for a deleted account
      community.windows.win_user_profile:
        name: ansible
        state: absent

    - name: Remove a profile for a deleted account based on the SID
      community.windows.win_user_profile:
        username: S-1-5-21-3233007181-2234767541-1895602582-1305
        state: absent

    - name: Remove multiple profiles that exist at the basename path
      community.windows.win_user_profile:
        name: ansible
        state: absent
        remove_multiple: yes



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
                    <b>path</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>The full path to the profile for the account. This will be null if <code>state=absent</code> and no profile was deleted.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">C:\Users\ansible</div>
                </td>
            </tr>
    </table>
    <br/><br/>


Status
------


Authors
~~~~~~~

- Jordan Borean (@jborean93)
