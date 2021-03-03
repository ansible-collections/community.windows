.. _community.windows.win_initialize_disk_module:


*************************************
community.windows.win_initialize_disk
*************************************

**Initializes disks on Windows Server**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- The :ref:`community.windows.win_initialize_disk <community.windows.win_initialize_disk_module>` module initializes disks




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
                    <b>disk_number</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Used to specify the disk number of the disk to be initialized.</div>
                </td>
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
                        <div>Specify if initializing should be forced for disks that are already initialized.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>online</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">boolean</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>no</li>
                                    <li><div style="color: blue"><b>yes</b>&nbsp;&larr;</div></li>
                        </ul>
                </td>
                <td>
                        <div>If the disk is offline and/or readonly update the disk to be online and not readonly.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>path</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Used to specify the path to the disk to be initialized.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>style</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li><div style="color: blue"><b>gpt</b>&nbsp;&larr;</div></li>
                                    <li>mbr</li>
                        </ul>
                </td>
                <td>
                        <div>The partition style to use for the disk. Valid options are mbr or gpt.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>uniqueid</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Used to specify the uniqueid of the disk to be initialized.</div>
                </td>
            </tr>
    </table>
    <br/>


Notes
-----

.. note::
   - One of three parameters (*disk_number*, *uniqueid*, and *path*) are mandatory to identify the target disk, but more than one cannot be specified at the same time.
   - A minimum Operating System Version of Server 2012 or Windows 8 is required to use this module.
   - This module is idempotent if *force* is not specified.


See Also
--------

.. seealso::

   :ref:`community.windows.win_disk_facts_module`
      The official documentation on the **community.windows.win_disk_facts** module.
   :ref:`community.windows.win_partition_module`
      The official documentation on the **community.windows.win_partition** module.
   :ref:`community.windows.win_format_module`
      The official documentation on the **community.windows.win_format** module.


Examples
--------

.. code-block:: yaml

    - name: Initialize a disk
      community.windows.win_initialize_disk:
        disk_number: 1

    - name: Initialize a disk with an MBR partition style
      community.windows.win_initialize_disk:
        disk_number: 1
        style: mbr

    - name: Forcefully initiallize a disk
      community.windows.win_initialize_disk:
        disk_number: 2
        force: yes




Status
------


Authors
~~~~~~~

- Brant Evans (@branic)
