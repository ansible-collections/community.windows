.. _community.windows.win_eventlog_entry_module:


************************************
community.windows.win_eventlog_entry
************************************

**Write entries to Windows event logs**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Write log entries to a given event log from a specified source.




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
                    <b>category</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>A numeric task category associated with the category message file for the log source.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>entry_type</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>Error</li>
                                    <li>FailureAudit</li>
                                    <li>Information</li>
                                    <li>SuccessAudit</li>
                                    <li>Warning</li>
                        </ul>
                </td>
                <td>
                        <div>Indicates the entry being written to the log is of a specific type.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>event_id</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">integer</span>
                         / <span style="color: red">required</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The numeric event identifier for the entry.</div>
                        <div>Value must be between 0 and 65535.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>log</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                         / <span style="color: red">required</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Name of the event log to write an entry to.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>message</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                         / <span style="color: red">required</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The message for the given log entry.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>raw_data</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Binary data associated with the log entry.</div>
                        <div>Value must be a comma-separated array of 8-bit unsigned integers (0 to 255).</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>source</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                         / <span style="color: red">required</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Name of the log source to indicate where the entry is from.</div>
                </td>
            </tr>
    </table>
    <br/>


Notes
-----

.. note::
   - This module will always report a change when writing an event entry.


See Also
--------

.. seealso::

   :ref:`community.windows.win_eventlog_module`
      The official documentation on the **community.windows.win_eventlog** module.


Examples
--------

.. code-block:: yaml

    - name: Write an entry to a Windows event log
      community.windows.win_eventlog_entry:
        log: MyNewLog
        source: NewLogSource1
        event_id: 1234
        message: This is a test log entry.

    - name: Write another entry to a different Windows event log
      community.windows.win_eventlog_entry:
        log: AnotherLog
        source: MyAppSource
        event_id: 5000
        message: An error has occurred.
        entry_type: Error
        category: 5
        raw_data: 10,20




Status
------


Authors
~~~~~~~

- Andrew Saraceni (@andrewsaraceni)
