.. _community.windows.win_regmerge_module:


******************************
community.windows.win_regmerge
******************************

**Merges the contents of a registry file into the Windows registry**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Wraps the reg.exe command to import the contents of a registry file.
- Suitable for use with registry files created using :ref:`ansible.windows.win_template <ansible.windows.win_template_module>`.
- Windows registry files have a specific format and must be constructed correctly with carriage return and line feed line endings otherwise they will not be merged.
- Exported registry files often start with a Byte Order Mark which must be removed if the file is to templated using :ref:`ansible.windows.win_template <ansible.windows.win_template_module>`.
- Registry file format is described at https://support.microsoft.com/en-us/kb/310516
- See also :ref:`ansible.windows.win_template <ansible.windows.win_template_module>`, :ref:`ansible.windows.win_regedit <ansible.windows.win_regedit_module>`




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
                    <b>compare_key</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The parent key to use when comparing the contents of the registry to the contents of the file.  Needs to be in HKLM or HKCU part of registry. Use a PS-Drive style path for example HKLM:\SOFTWARE not HKEY_LOCAL_MACHINE\SOFTWARE If not supplied, or the registry key is not found, no comparison will be made, and the module will report changed.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>path</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">path</span>
                         / <span style="color: red">required</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The full path including file name to the registry file on the remote machine to be merged</div>
                </td>
            </tr>
    </table>
    <br/>


Notes
-----

.. note::
   - Organise your registry files so that they contain a single root registry key if you want to use the compare_to functionality.
   - This module does not force registry settings to be in the state described in the file.  If registry settings have been modified externally the module will merge the contents of the file but continue to report differences on subsequent runs.
   - To force registry change, use :ref:`ansible.windows.win_regedit <ansible.windows.win_regedit_module>` with ``state=absent`` before using ``community.windows.win_regmerge``.


See Also
--------

.. seealso::

   :ref:`ansible.windows.win_reg_stat_module`
      The official documentation on the **ansible.windows.win_reg_stat** module.
   :ref:`ansible.windows.win_regedit_module`
      The official documentation on the **ansible.windows.win_regedit** module.


Examples
--------

.. code-block:: yaml

    - name: Merge in a registry file without comparing to current registry
      community.windows.win_regmerge:
        path: C:\autodeploy\myCompany-settings.reg

    - name: Compare and merge registry file
      community.windows.win_regmerge:
        path: C:\autodeploy\myCompany-settings.reg
        compare_to: HKLM:\SOFTWARE\myCompany



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
                    <b>compare_to_key_found</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">boolean</span>
                    </div>
                </td>
                <td>when comparison key not found in registry</td>
                <td>
                            <div>whether the parent registry key has been found for comparison</div>
                    <br/>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>compared</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">boolean</span>
                    </div>
                </td>
                <td>when a comparison key has been supplied and comparison has been attempted</td>
                <td>
                            <div>whether a comparison has taken place between the registry and the file</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">True</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>difference_count</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>changed</td>
                <td>
                            <div>number of differences between the registry and the file</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">1</div>
                </td>
            </tr>
    </table>
    <br/><br/>


Status
------


Authors
~~~~~~~

- Jon Hawkesworth (@jhawkesworth)
