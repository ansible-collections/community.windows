.. _community.windows.win_webpicmd_module:


******************************
community.windows.win_webpicmd
******************************

**Installs packages using Web Platform Installer command-line**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Installs packages using Web Platform Installer command-line (http://www.iis.net/learn/install/web-platform-installer/web-platform-installer-v4-command-line-webpicmdexe-rtw-release).
- Must be installed and present in PATH (see :ref:`chocolatey.chocolatey.win_chocolatey <chocolatey.chocolatey.win_chocolatey_module>` module; 'webpicmd' is the package name, and you must install 'lessmsi' first too)?
- Install IIS first (see :ref:`ansible.windows.win_feature <ansible.windows.win_feature_module>` module).




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
                         / <span style="color: red">required</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Name of the package to be installed.</div>
                </td>
            </tr>
    </table>
    <br/>


Notes
-----

.. note::
   - Accepts EULAs and suppresses reboot - you will need to check manage reboots yourself (see :ref:`ansible.windows.win_reboot <ansible.windows.win_reboot_module>` module)


See Also
--------

.. seealso::

   :ref:`ansible.windows.win_package_module`
      The official documentation on the **ansible.windows.win_package** module.


Examples
--------

.. code-block:: yaml

    - name: Install URLRewrite2.
      community.windows.win_webpicmd:
        name: URLRewrite2




Status
------


Authors
~~~~~~~

- Peter Mounce (@petemounce)
