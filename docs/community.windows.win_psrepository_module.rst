.. _community.windows.win_psrepository_module:


**********************************
community.windows.win_psrepository
**********************************

**Adds, removes or updates a Windows PowerShell repository.**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- This module helps to add, remove and update Windows PowerShell repository on Windows-based systems.



Requirements
------------
The below requirements are needed on the host that executes this module.

- PowerShell Module `PowerShellGet >= 1.6.0 <https://www.powershellgallery.com/packages/PowerShellGet/>`_
- PowerShell Module `PackageManagement >= 1.1.7 <https://www.powershellgallery.com/packages/PackageManagement/>`_
- PowerShell Package Provider ``NuGet`` >= 2.8.5.201


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
                    <b>force</b>
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
                        <div>If <code>True</code>, any differences from the desired state will result in the repository being unregistered, and then re-registered.</div>
                        <div><em>force</em> has no effect when <em>state=absent</em>. See notes for additional context.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>installation_policy</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>trusted</li>
                                    <li>untrusted</li>
                        </ul>
                </td>
                <td>
                        <div>Sets the <code>InstallationPolicy</code> of a repository.</div>
                        <div>Will default to <code>trusted</code> when creating a new repository or used with <em>force=True</em>.</div>
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
                        <div>Name of the repository to work with.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>proxy</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                    <div style="font-style: italic; font-size: small; color: darkgreen">added in 1.1.0</div>
                </td>
                <td>
                </td>
                <td>
                        <div>Proxy to use for repository.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>publish_location</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Specifies the URI for publishing modules to this repository.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>script_publish_location</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Specifies the URI for publishing scripts to this repository.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>script_source_location</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Specifies the URI for discovering and installing scripts from this repository.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>source_location</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Specifies the URI for discovering and installing modules from this repository.</div>
                        <div>A URI can be a NuGet server feed (most common situation), HTTP, HTTPS, FTP or file location.</div>
                        <div>Required when registering a new repository or using <em>force=True</em>.</div>
                        <div style="font-size: small; color: darkgreen"><br/>aliases: source</div>
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
                        <div>If <code>present</code> a new repository is added or updated.</div>
                        <div>If <code>absent</code> a repository is removed.</div>
                </td>
            </tr>
    </table>
    <br/>


Notes
-----

.. note::
   - See the examples on how to update the NuGet package provider.
   - You can not use ``win_psrepository`` to re-register (add) removed PSGallery, use the command ``Register-PSRepository -Default`` instead.
   - When registering or setting *source_location*, PowerShellGet will transform the location according to internal rules, such as following HTTP/S redirects.
   - This can result in a ``CHANGED`` status on each run as the values will never match and will be "reset" each time.
   - To work around that, find the true destination value with :ref:`community.windows.win_psrepository_info <community.windows.win_psrepository_info_module>` or ``Get-PSRepository`` and update the playbook to match.
   - When updating an existing repository, all options except *name* are optional. Only supplied options will be updated. Use *force=True* to exactly match.
   - *script_location*, *publish_location*, and *script_publish_location* are optional but once set can only be cleared with *force=True*.
   - Using *force=True* will unregister and re-register the repository if there are any changes, so that it exactly matches the options specified.


See Also
--------

.. seealso::

   :ref:`community.windows.win_psrepository_info_module`
      The official documentation on the **community.windows.win_psrepository_info** module.
   :ref:`community.windows.win_psmodule_module`
      The official documentation on the **community.windows.win_psmodule** module.


Examples
--------

.. code-block:: yaml

    ---
    - name: Ensure the required NuGet package provider version is installed
      ansible.windows.win_shell: Find-PackageProvider -Name Nuget -ForceBootstrap -IncludeDependencies -Force

    - name: Register a PowerShell repository
      community.windows.win_psrepository:
        name: MyRepository
        source_location: https://myrepo.com
        state: present

    - name: Remove a PowerShell repository
      community.windows.win_psrepository:
        name: MyRepository
        state: absent

    - name: Add an untrusted repository
      community.windows.win_psrepository:
        name: MyRepository
        installation_policy: untrusted

    - name: Add a repository with different locations
      community.windows.win_psrepository:
        name: NewRepo
        source_location: https://myrepo.example/module/feed
        script_source_location: https://myrepo.example/script/feed
        publish_location: https://myrepo.example/api/module/publish
        script_publish_location: https://myrepo.example/api/script/publish

    - name: Update only two properties on the above repository
      community.windows.win_psrepository:
        name: NewRepo
        installation_policy: untrusted
        script_publish_location: https://scriptprocessor.example/publish

    - name: Clear script locations from the above repository by re-registering it
      community.windows.win_psrepository:
        name: NewRepo
        installation_policy: untrusted
        source_location: https://myrepo.example/module/feed
        publish_location: https://myrepo.example/api/module/publish
        force: True




Status
------


Authors
~~~~~~~

- Wojciech Sciesinski (@it-praktyk)
- Brian Scholer (@briantist)
