.. _community.windows.win_dotnet_ngen_module:


*********************************
community.windows.win_dotnet_ngen
*********************************

**Runs ngen to recompile DLLs after .NET  updates**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- After .NET framework is installed/updated, Windows will probably want to recompile things to optimise for the host.
- This happens via scheduled task, usually at some inopportune time.
- This module allows you to run this task on your own schedule, so you incur the CPU hit at some more convenient and controlled time.
- https://docs.microsoft.com/en-us/dotnet/framework/tools/ngen-exe-native-image-generator#native-image-service
- http://blogs.msdn.com/b/dotnet/archive/2013/08/06/wondering-why-mscorsvw-exe-has-high-cpu-usage-you-can-speed-it-up.aspx





Notes
-----

.. note::
   - There are in fact two scheduled tasks for ngen but they have no triggers so aren't a problem.
   - There's no way to test if they've been completed.
   - The stdout is quite likely to be several megabytes.



Examples
--------

.. code-block:: yaml

    - name: Run ngen tasks
      community.windows.win_dotnet_ngen:



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
                    <b>dotnet_ngen64_eqi_exit_code</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>64-bit ngen executable exists</td>
                <td>
                            <div>The exit code after running the 64-bit ngen.exe executeQueuedItems command.</div>
                    <br/>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>dotnet_ngen64_eqi_output</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>64-bit ngen executable exists</td>
                <td>
                            <div>The stdout after running the 64-bit ngen.exe executeQueuedItems command.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">sample output</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>dotnet_ngen64_update_exit_code</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>64-bit ngen executable exists</td>
                <td>
                            <div>The exit code after running the 64-bit ngen.exe update /force command.</div>
                    <br/>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>dotnet_ngen64_update_output</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>64-bit ngen executable exists</td>
                <td>
                            <div>The stdout after running the 64-bit ngen.exe update /force command.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">sample output</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>dotnet_ngen_eqi_exit_code</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>32-bit ngen executable exists</td>
                <td>
                            <div>The exit code after running the 32-bit ngen.exe executeQueuedItems command.</div>
                    <br/>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>dotnet_ngen_eqi_output</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>32-bit ngen executable exists</td>
                <td>
                            <div>The stdout after running the 32-bit ngen.exe executeQueuedItems command.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">sample output</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>dotnet_ngen_update_exit_code</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>32-bit ngen executable exists</td>
                <td>
                            <div>The exit code after running the 32-bit ngen.exe update /force command.</div>
                    <br/>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>dotnet_ngen_update_output</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>32-bit ngen executable exists</td>
                <td>
                            <div>The stdout after running the 32-bit ngen.exe update /force command.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">sample output</div>
                </td>
            </tr>
    </table>
    <br/><br/>


Status
------


Authors
~~~~~~~

- Peter Mounce (@petemounce)
