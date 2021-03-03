.. _community.windows.win_pester_module:


****************************
community.windows.win_pester
****************************

**Run Pester tests on Windows hosts**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Run Pester tests on Windows hosts.
- Test files have to be available on the remote host.



Requirements
------------
The below requirements are needed on the host that executes this module.

- Pester


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
                    <b>output_file</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Generates an output test report.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>output_format</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <b>Default:</b><br/><div style="color: blue">"NunitXML"</div>
                </td>
                <td>
                        <div>Format of the test report to be generated.</div>
                        <div>This parameter is to be used with output_file option.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>path</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                         / <span style="color: red">required</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Path to a pester test file or a folder where tests can be found.</div>
                        <div>If the path is a folder, the module will consider all ps1 files as Pester tests.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>tags</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">list</span>
                         / <span style="color: purple">elements=string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Runs only tests in Describe blocks with specified Tags values.</div>
                        <div>Accepts multiple comma separated tags.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>test_parameters</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">dictionary</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Allows to specify parameters to the test script.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>version</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Minimum version of the pester module that has to be available on the remote host.</div>
                        <div style="font-size: small; color: darkgreen"><br/>aliases: minimum_version</div>
                </td>
            </tr>
    </table>
    <br/>




Examples
--------

.. code-block:: yaml

    - name: Get facts
      ansible.windows.setup:

    - name: Add Pester module
      action:
        module_name: "{{ 'community.windows.win_psmodule' if ansible_powershell_version >= 5 else 'chocolatey.chocolatey.win_chocolatey' }}"
        name: Pester
        state: present

    - name: Run the pester test provided in the path parameter.
      community.windows.win_pester:
        path: C:\Pester

    - name: Run the pester tests only for the tags specified.
      community.windows.win_pester:
        path: C:\Pester\TestScript.tests
        tags: CI,UnitTests

    # Run pesters tests files that are present in the specified folder
    # ensure that the pester module version available is greater or equal to the version parameter.
    - name: Run the pester test present in a folder and check the Pester module version.
      community.windows.win_pester:
        path: C:\Pester\test01.test.ps1
        version: 4.1.0

    - name: Run the pester test present in a folder with given script parameters.
      community.windows.win_pester:
        path: C:\Pester\test04.test.ps1
        test_parameters:
          Process: lsass
          Service: bits

    - name: Run the pester test present in a folder and generate NunitXML test result..
      community.windows.win_pester:
        path: C:\Pester\test04.test.ps1
        output_file: c:\Pester\resullt\testresult.xml



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
                    <b>output</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">list</span>
                    </div>
                </td>
                <td>success</td>
                <td>
                            <div>Results of the Pester tests.</div>
                    <br/>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>pester_version</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Version of the pester module found on the remote host.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">4.3.1</div>
                </td>
            </tr>
    </table>
    <br/><br/>


Status
------


Authors
~~~~~~~

- Erwan Quelin (@equelin)
- Prasoon Karunan V (@prasoonkarunan)
