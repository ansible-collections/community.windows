.. _community.windows.win_computer_description_module:


******************************************
community.windows.win_computer_description
******************************************

**Set windows description, owner and organization**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- This module sets Windows description that is shown under My Computer properties. Module also sets Windows license owner and organization. License information can be viewed by running winver commad.




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
                    <b>description</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>String value to apply to Windows descripton. Specify value of &quot;&quot; to clear the value.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>organization</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>String value of organization that the Windows is licensed to. Specify value of &quot;&quot; to clear the value.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>owner</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>String value of the persona that the Windows is licensed to. Specify value of &quot;&quot; to clear the value.</div>
                </td>
            </tr>
    </table>
    <br/>




Examples
--------

.. code-block:: yaml

    - name: Set Windows description, owner and organization
      community.windows.win_computer_description:
       description: Best Box
       owner: RusoSova
       organization: MyOrg
      register: result

    - name: Set Windows description only
      community.windows.win_computer_description:
       description: This is my Windows machine
      register: result

    - name: Set organization and clear owner field
      community.windows.win_computer_description:
       owner: ''
       organization: Black Mesa

    - name: Clear organization, description and owner
      community.windows.win_computer_description:
       organization: ""
       owner: ""
       description: ""
      register: result




Status
------


Authors
~~~~~~~

- RusoSova (@RusoSova)
