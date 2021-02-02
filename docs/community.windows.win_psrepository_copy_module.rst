.. _community.windows.win_psrepository_copy_module:


***************************************
community.windows.win_psrepository_copy
***************************************

**Copies registered PSRepositories to other user profiles**


Version added: 1.3.0

.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Copies specified registered PSRepositories to other user profiles on the system.
- Can include the ``Default`` profile so that new users start with the selected repositories.
- Can include special service accounts like the local SYSTEM user, LocalService, NetworkService.




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
                    <b>exclude</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">list</span>
                         / <span style="color: purple">elements=string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The names of repositories to exclude.</div>
                        <div>Names are interpreted as wildcards.</div>
                        <div>If a name matches both an include (<em>name</em>) and <em>exclude</em>, it will be excluded.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>exclude_profiles</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">list</span>
                         / <span style="color: purple">elements=string</span>
                    </div>
                </td>
                <td>
                        <b>Default:</b><br/><div style="color: blue">["systemprofile", "LocalService", "NetworkService"]</div>
                </td>
                <td>
                        <div>The names of user profiles to exclude.</div>
                        <div>If a profile matches both an include (<em>profiles</em>) and <em>exclude_profiles</em>, it will be excluded.</div>
                        <div>By default, the service account profiles are excluded.</div>
                        <div>To explcitly exclude nothing, set <em>exclude_profiles=[]</em>.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>name</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">list</span>
                         / <span style="color: purple">elements=string</span>
                    </div>
                </td>
                <td>
                        <b>Default:</b><br/><div style="color: blue">["*"]</div>
                </td>
                <td>
                        <div>The names of repositories to copy.</div>
                        <div>Names are interpreted as wildcards.</div>
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
                        <b>Default:</b><br/><div style="color: blue">["*"]</div>
                </td>
                <td>
                        <div>The names of user profiles to populate with repositories.</div>
                        <div>Names are interpreted as wildcards.</div>
                        <div>The <code>Default</code> profile can also be matched.</div>
                        <div>The <code>Public</code> and <code>All Users</code> profiles cannot be targeted, as PSRepositories are not loaded from them.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>source</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">path</span>
                    </div>
                </td>
                <td>
                        <b>Default:</b><br/><div style="color: blue">"%LOCALAPPDATA%\\Microsoft\\Windows\\PowerShell\\PowerShellGet\\PSRepositories.xml"</div>
                </td>
                <td>
                        <div>The full path to the source repositories XML file.</div>
                        <div>Defaults to the repositories registered to the current user.</div>
                </td>
            </tr>
    </table>
    <br/>


Notes
-----

.. note::
   - Does not require the ``PowerShellGet`` module or any other external dependencies.
   - User profiles are loaded from the registry. If a given path does not exist (like if the profile directory was deleted), it is silently skipped.
   - If setting service account profiles, you may need ``become=yes``. See examples.
   - When PowerShellGet first sets up a repositories file, it always adds ``PSGallery``, however if this module creates a new repos file and your selected repositories don't include ``PSGallery``, it won't be in your destination.
   - The values searched in *profiles* (and *exclude_profiles*) are profile names, not necessarily user names. This can happen when the profile path is deliberately changed or when domain user names conflict with users from the local computer or another domain. In this case the second+ user may have the domain name or local computer name appended, like ``JoeUser.Contoso`` vs. ``JoeUser``. If you intend to filter user profiles, ensure your filters catch the right names.
   - In the case of the service accounts, the specific profiles are ``systemprofile`` (for the ``SYSTEM`` user), and ``LocalService`` or ``NetworkService`` for those accounts respectively.
   - Repositories with credentials (requiring authentication) or proxy information will copy, but the credentials and proxy details will not as that information is not stored with repository.


See Also
--------

.. seealso::

   :ref:`community.windows.win_psrepository_module`
      The official documentation on the **community.windows.win_psrepository** module.
   :ref:`community.windows.win_psrepository_info_module`
      The official documentation on the **community.windows.win_psrepository_info** module.


Examples
--------

.. code-block:: yaml

    - name: Copy the current user's PSRepositories to all non-service account profiles and Default profile
      community.windows.win_psrepository_copy:

    - name: Copy the current user's PSRepositories to all profiles and Default profile
      community.windows.win_psrepository_copy:
        exclude_profiles: []

    - name: Copy the current user's PSRepositories to all profiles beginning with A, B, or C
      community.windows.win_psrepository_copy:
        profiles:
          - 'A*'
          - 'B*'
          - 'C*'

    - name: Copy the current user's PSRepositories to all profiles beginning B except Brian and Brianna
      community.windows.win_psrepository_copy:
        profiles: 'B*'
        exclude_profiles:
          - Brian
          - Brianna

    - name: Copy a specific set of repositories to profiles beginning with 'svc' with exceptions
      community.windows.win_psrepository_copy:
        name:
          - CompanyRepo1
          - CompanyRepo2
          - PSGallery
        profiles: 'svc*'
        exclude_profiles: 'svc-restricted'

    - name: Copy repos matching a pattern with exceptions
      community.windows.win_psrepository_copy:
        name: 'CompanyRepo*'
        exclude: 'CompanyRepo*-Beta'

    - name: Copy repositories from a custom XML file on the target host
      community.windows.win_psrepository_copy:
        source: 'C:\data\CustomRepostories.xml'

    ### A sample workflow of seeding a system with a custom repository

    # A playbook that does initial host setup or builds system images

    - name: Register custom respository
      community.windows.win_psrepository:
        name: PrivateRepo
        source_location: https://example.com/nuget/feed/etc
        installation_policy: trusted

    - name: Ensure all current and new users have this repository registered
      community.windows.win_psrepository_copy:
        name: PrivateRepo

    # In another playbook, run by other users (who may have been created later)

    - name: Install a module
      community.windows.win_psmodule:
        name: CompanyModule
        repository: PrivateRepo
        state: present




Status
------


Authors
~~~~~~~

- Brian Scholer (@briantist)
