.. _community.windows.win_psscript_module:


******************************
community.windows.win_psscript
******************************

**Install and manage PowerShell scripts from a PSRepository**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Add or remove PowerShell scripts from registered PSRepositories.



Requirements
------------
The below requirements are needed on the host that executes this module.

- ``PowerShellGet`` module v1.6.0+


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
                    <b>allow_prerelease</b>
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
                        <div>If <code>yes</code> installs scripts flagged as prereleases.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>maximum_version</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The maximum version of the script to install.</div>
                        <div>Cannot be used when <em>state=latest</em>.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>minimum_version</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The minimum version of the script to install.</div>
                        <div>Cannot be used when <em>state=latest</em>.</div>
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
                        <div>The name of the script you want to install or remove.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>repository</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The registered name of the repository you want to install from.</div>
                        <div>Cannot be used when <em>state=absent</em>.</div>
                        <div>If ommitted, all repositories will be searched.</div>
                        <div>To register a repository, use <span class='module'>community.windows.win_psrepository</span>.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>required_version</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The exact version of the script to install.</div>
                        <div>Cannot be used with <em>minimum_version</em> or <em>maximum_version</em>.</div>
                        <div>Cannot be used when <em>state=latest</em>.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>scope</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>current_user</li>
                                    <li><div style="color: blue"><b>all_users</b>&nbsp;&larr;</div></li>
                        </ul>
                </td>
                <td>
                        <div>Determines whether the script is installed for only the <code>current_user</code> or for <code>all_users</code>.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>source_password</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The password portion of the credential required to access the repository.</div>
                        <div>Must be used together with <em>source_username</em>.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>source_username</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The username portion of the credential required to access the repository.</div>
                        <div>Must be used together with <em>source_password</em>.</div>
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
                                    <li><div style="color: blue"><b>present</b>&nbsp;&larr;</div></li>
                                    <li>absent</li>
                                    <li>latest</li>
                        </ul>
                </td>
                <td>
                        <div>The desired state of the script. <code>absent</code> removes the script.</div>
                        <div><code>latest</code> will ensure the most recent version available is installed.</div>
                        <div><code>present</code> only installs if the script is missing.</div>
                </td>
            </tr>
    </table>
    <br/>


Notes
-----

.. note::
   - Unlike PowerShell modules, scripts do not support side-by-side installations of multiple versions. Installing a new version will replace the existing one.


See Also
--------

.. seealso::

   :ref:`community.windows.win_psrepository_module`
      The official documentation on the **community.windows.win_psrepository** module.
   :ref:`community.windows.win_psrepository_info_module`
      The official documentation on the **community.windows.win_psrepository_info** module.
   :ref:`community.windows.win_psmodule_module`
      The official documentation on the **community.windows.win_psmodule** module.


Examples
--------

.. code-block:: yaml

    - name: Install a script from PSGallery
      community.windows.win_psscript:
        name: Test-RPC
        repository: PSGallery

    - name: Find and install the latest version of a script from any repository
      community.windows.win_psscript:
        name: Get-WindowsAutoPilotInfo
        state: latest

    - name: Remove a script that isn't needed
      community.windows.win_psscript:
        name: Defrag-Partition
        state: absent

    - name: Install a specific version of a script for the current user
      community.windows.win_psscript:
        name: CleanOldFiles
        scope: current_user
        required_version: 3.10.2

    - name: Install a script below a certain version
      community.windows.win_psscript:
        name: New-FeatureEnable
        maximum_version: 2.99.99

    - name: Ensure a minimum version of a script is present
      community.windows.win_psscript:
        name: OldStandby
        minimum_version: 3.0.0

    - name: Install any available version that fits a specific range
      community.windows.win_psscript:
        name: FinickyScript
        minimum_version: 2.5.1
        maximum_version: 2.6.19




Status
------


Authors
~~~~~~~

- Brian Scholer (@briantist)
