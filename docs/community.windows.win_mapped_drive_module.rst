.. _community.windows.win_mapped_drive_module:


**********************************
community.windows.win_mapped_drive
**********************************

**Map network drives for users**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Allows you to modify mapped network drives for individual users.
- Also support WebDAV endpoints in the UNC form.




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
                    <b>letter</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                         / <span style="color: red">required</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The letter of the network path to map to.</div>
                        <div>This letter must not already be in use with Windows.</div>
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
                        <div>The password for <code>username</code> that is used when testing the initial connection.</div>
                        <div>This is never saved with a mapped drive, use the <span class='module'>community.windows.win_credential</span> module to persist a username and password for a host.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>path</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">path</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The UNC path to map the drive to.</div>
                        <div>If pointing to a WebDAV location this must still be in a UNC path in the format <code>\\hostname\path</code> and not a URL, see examples for more details.</div>
                        <div>To specify a <code>https</code> WebDAV path, add <code>@SSL</code> after the hostname. To specify a custom WebDAV port add <code>@&lt;port num&gt;</code> after the <code>@SSL</code> or hostname portion of the UNC path, e.g. <code>\\server@SSL@1234</code> or <code>\\server@1234</code>.</div>
                        <div>This is required if <code>state=present</code>.</div>
                        <div>If <code>state=absent</code> and <em>path</em> is not set, the module will delete the mapped drive regardless of the target.</div>
                        <div>If <code>state=absent</code> and the <em>path</em> is set, the module will throw an error if path does not match the target of the mapped drive.</div>
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
                        <div>If <code>present</code> will ensure the mapped drive exists.</div>
                        <div>If <code>absent</code> will ensure the mapped drive does not exist.</div>
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
                        <div>The username that is used when testing the initial connection.</div>
                        <div>This is never saved with a mapped drive, the <span class='module'>community.windows.win_credential</span> module to persist a username and password for a host.</div>
                        <div>This is required if the mapped drive requires authentication with custom credentials and become, or CredSSP cannot be used.</div>
                        <div>If become or CredSSP is used, any credentials saved with <span class='module'>community.windows.win_credential</span> will automatically be used instead.</div>
                </td>
            </tr>
    </table>
    <br/>


Notes
-----

.. note::
   - You cannot use this module to access a mapped drive in another Ansible task, drives mapped with this module are only accessible when logging in interactively with the user through the console or RDP.
   - It is recommend to run this module with become or CredSSP when the remote path requires authentication.
   - When using become or CredSSP, the task will have access to any local credentials stored in the user's vault.
   - If become or CredSSP is not available, the *username* and *password* options can be used for the initial authentication but these are not persisted.
   - WebDAV paths must have the WebDAV client feature installed for this module to map those paths. This is installed by default on desktop Windows editions but Windows Server hosts need to install the ``WebDAV-Redirector`` feature using :ref:`ansible.windows.win_feature <ansible.windows.win_feature_module>`.


See Also
--------

.. seealso::

   :ref:`community.windows.win_credential_module`
      The official documentation on the **community.windows.win_credential** module.


Examples
--------

.. code-block:: yaml

    - name: Create a mapped drive under Z
      community.windows.win_mapped_drive:
        letter: Z
        path: \\domain\appdata\accounting

    - name: Delete any mapped drives under Z
      community.windows.win_mapped_drive:
        letter: Z
        state: absent

    - name: Only delete the mapped drive Z if the paths match (error is thrown otherwise)
      community.windows.win_mapped_drive:
        letter: Z
        path: \\domain\appdata\accounting
        state: absent

    - name: Create mapped drive with credentials and save the username and password
      block:
      - name: Save the network credentials required for the mapped drive
        community.windows.win_credential:
          name: server
          type: domain_password
          username: username@DOMAIN
          secret: Password01
          state: present

      - name: Create a mapped drive that requires authentication
        community.windows.win_mapped_drive:
          letter: M
          path: \\SERVER\C$
          state: present
      vars:
        # become is required to save and retrieve the credentials in the tasks
        ansible_become: yes
        ansible_become_method: runas
        ansible_become_user: '{{ ansible_user }}'
        ansible_become_pass: '{{ ansible_password }}'

    - name: Create mapped drive with credentials that do not persist on the next logon
      community.windows.win_mapped_drive:
        letter: M
        path: \\SERVER\C$
        state: present
        username: '{{ ansible_user }}'
        password: '{{ ansible_password }}'

    # This should only be required for Windows Server OS'
    - name: Ensure WebDAV client feature is installed
      ansible.windows.win_feature:
        name: WebDAV-Redirector
        state: present
      register: webdav_feature

    - name: Reboot after installing WebDAV client feature
      ansible.windows.win_reboot:
      when: webdav_feature.reboot_required

    - name: Map the HTTPS WebDAV location
      community.windows.win_mapped_drive:
        letter: W
        path: \\live.sysinternals.com@SSL\tools  # https://live.sysinternals.com/tools
        state: present




Status
------


Authors
~~~~~~~

- Jordan Borean (@jborean93)
