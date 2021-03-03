.. _community.windows.win_timezone_module:


******************************
community.windows.win_timezone
******************************

**Sets Windows machine timezone**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Sets machine time to the specified timezone.




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
                    <b>timezone</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                         / <span style="color: red">required</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Timezone to set to.</div>
                        <div>Example: Central Standard Time</div>
                        <div>To disable Daylight Saving time, add the suffix <code>_dstoff</code> on timezones that support this.</div>
                </td>
            </tr>
    </table>
    <br/>


Notes
-----

.. note::
   - The module will check if the provided timezone is supported on the machine.
   - A list of possible timezones is available from ``tzutil.exe /l`` and from https://msdn.microsoft.com/en-us/library/ms912391.aspx
   - If running on Server 2008 the hotfix https://support.microsoft.com/en-us/help/2556308/tzutil-command-line-tool-is-added-to-windows-vista-and-to-windows-server-2008 needs to be installed to be able to run this module.


See Also
--------

.. seealso::

   :ref:`community.windows.win_region_module`
      The official documentation on the **community.windows.win_region** module.


Examples
--------

.. code-block:: yaml

    - name: Set timezone to 'Romance Standard Time' (GMT+01:00)
      community.windows.win_timezone:
        timezone: Romance Standard Time

    - name: Set timezone to 'GMT Standard Time' (GMT)
      community.windows.win_timezone:
        timezone: GMT Standard Time

    - name: Set timezone to 'Central Standard Time' (GMT-06:00)
      community.windows.win_timezone:
        timezone: Central Standard Time

    - name: Set timezime to Pacific Standard time and disable Daylight Saving time adjustments
      community.windows.win_timezone:
        timezone: Pacific Standard Time_dstoff



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
                    <b>previous_timezone</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>success</td>
                <td>
                            <div>The previous timezone if it was changed, otherwise the existing timezone.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">Central Standard Time</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>timezone</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>success</td>
                <td>
                            <div>The current timezone (possibly changed).</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">Central Standard Time</div>
                </td>
            </tr>
    </table>
    <br/><br/>


Status
------


Authors
~~~~~~~

- Phil Schwartz (@schwartzmx)
