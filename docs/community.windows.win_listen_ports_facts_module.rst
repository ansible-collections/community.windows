.. _community.windows.win_listen_ports_facts_module:


****************************************
community.windows.win_listen_ports_facts
****************************************

**Recopilates the facts of the listening ports of the machine**


Version added: 1.10.0

.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Recopilates the information of the TCP and UDP ports of the machine and the related processes.
- State of the TCP ports could be filtered, as well as the format of the date when the parent process was launched.
- The module's goal is to replicate the functionality of the linux module listen_ports_facts, mantaining the format of the said module.




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
                    <b>date_format</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <b>Default:</b><br/><div style="color: blue">"%c"</div>
                </td>
                <td>
                        <div>The format of the date when the process that owns the port started.</div>
                        <div>The date specification is UFormat</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>tcp_filter</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">list</span>
                         / <span style="color: purple">elements=string</span>
                    </div>
                </td>
                <td>
                        <b>Default:</b><br/><div style="color: blue">["Listen"]</div>
                </td>
                <td>
                        <div>Filter for the state of the TCP ports that will be recopilated.</div>
                        <div>Supports multiple states (Bound, Closed, CloseWait, Closing, DeleteTCB, Established, FinWait1, FinWait2, LastAck, Listen, SynReceived, SynSent and TimeWait), that can be used alone or combined. Note that the Bound state is only available on PowerShell version 4.0 or later.</div>
                </td>
            </tr>
    </table>
    <br/>


Notes
-----

.. note::
   - The generated data (tcp_listen and udp_listen) and the fields within follows the listen_ports_facts schema to achieve compatibility with the said module output, even though this module if capable of extracting ports with a state other than Listen


See Also
--------

.. seealso::

   :ref:`community.general.listen_ports_facts_module`
      The official documentation on the **community.general.listen_ports_facts** module.


Examples
--------

.. code-block:: yaml

    - name: Recopilate ports facts
      community.windows.win_listen_ports_facts:

    - name: Retrieve only ports with Closing and Established states
      community.windows.win_listen_ports_facts:
        tcp_filter:
            - Closing
            - Established

    - name: Get ports facts with only the year within the date field
      community.windows.win_listen_ports_facts:
        date_format: '%Y'



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
                    <b>tcp_listen</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">list</span>
                       / <span style="color: purple">elements=dictionary</span>
                    </div>
                </td>
                <td>success</td>
                <td>
                            <div>List of dicts with the detected TCP ports</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">[{&#x27;address&#x27;: &#x27;127.0.0.1&#x27;, &#x27;name&#x27;: &#x27;python&#x27;, &#x27;pid&#x27;: 5332, &#x27;port&#x27;: 82, &#x27;protocol&#x27;: &#x27;tcp&#x27;, &#x27;stime&#x27;: &#x27;Thu Nov 18 15:27:42 2021&#x27;, &#x27;user&#x27;: &#x27;SERVER\\Administrator&#x27;}]</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>udp_listen</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">list</span>
                       / <span style="color: purple">elements=dictionary</span>
                    </div>
                </td>
                <td>success</td>
                <td>
                            <div>List of dicts with the detected UDP ports</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">[{&#x27;address&#x27;: &#x27;127.0.0.1&#x27;, &#x27;name&#x27;: &#x27;python&#x27;, &#x27;pid&#x27;: 5332, &#x27;port&#x27;: 82, &#x27;protocol&#x27;: &#x27;udp&#x27;, &#x27;stime&#x27;: &#x27;Thu Nov 18 15:27:42 2021&#x27;, &#x27;user&#x27;: &#x27;SERVER\\Administrator&#x27;}]</div>
                </td>
            </tr>
    </table>
    <br/><br/>


Status
------


Authors
~~~~~~~

- David Nieto (@david-ns)
