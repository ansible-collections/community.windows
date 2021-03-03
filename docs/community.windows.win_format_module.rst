.. _community.windows.win_format_module:


****************************
community.windows.win_format
****************************

**Formats an existing volume or a new volume on an existing partition on Windows**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- The :ref:`community.windows.win_format <community.windows.win_format_module>` module formats an existing volume or a new volume on an existing partition on Windows




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
                    <b>allocation_unit_size</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Specifies the cluster size to use when formatting the volume.</div>
                        <div>If no cluster size is specified when you format a partition, defaults are selected based on the size of the partition.</div>
                        <div>This value must be a multiple of the physical sector size of the disk.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>compress</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">boolean</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>no</li>
                                    <li>yes</li>
                        </ul>
                </td>
                <td>
                        <div>Enable compression on the resulting NTFS volume.</div>
                        <div>NTFS compression is not supported where <em>allocation_unit_size</em> is more than 4096.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>drive_letter</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Used to specify the drive letter of the volume to be formatted.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>file_system</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>ntfs</li>
                                    <li>refs</li>
                                    <li>exfat</li>
                                    <li>fat32</li>
                                    <li>fat</li>
                        </ul>
                </td>
                <td>
                        <div>Used to specify the file system to be used when formatting the target volume.</div>
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
                        <div>Specify if formatting should be forced for volumes that are not created from new partitions or if the source and target file system are different.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>full</b>
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
                        <div>A full format writes to every sector of the disk, takes much longer to perform than the default (quick) format, and is not recommended on storage that is thinly provisioned.</div>
                        <div>Specify <code>true</code> for full format.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>integrity_streams</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">boolean</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>no</li>
                                    <li>yes</li>
                        </ul>
                </td>
                <td>
                        <div>Enable integrity streams on the resulting ReFS volume.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>label</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Used to specify the label of the volume to be formatted.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>large_frs</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">boolean</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>no</li>
                                    <li>yes</li>
                        </ul>
                </td>
                <td>
                        <div>Specifies that large File Record System (FRS) should be used.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>new_label</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Used to specify the new file system label of the formatted volume.</div>
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
                        <div>Used to specify the path to the volume to be formatted.</div>
                </td>
            </tr>
    </table>
    <br/>


Notes
-----

.. note::
   - Microsoft Windows Server 2012 or Microsoft Windows 8 or newer is required to use this module. To check if your system is compatible, see https://docs.microsoft.com/en-us/windows/desktop/sysinfo/operating-system-version.
   - One of three parameters (*drive_letter*, *path* and *label*) are mandatory to identify the target volume but more than one cannot be specified at the same time.
   - This module is idempotent if *force* is not specified and file system labels remain preserved.
   - For more information, see https://docs.microsoft.com/en-us/previous-versions/windows/desktop/stormgmt/format-msft-volume


See Also
--------

.. seealso::

   :ref:`community.windows.win_disk_facts_module`
      The official documentation on the **community.windows.win_disk_facts** module.
   :ref:`community.windows.win_partition_module`
      The official documentation on the **community.windows.win_partition** module.


Examples
--------

.. code-block:: yaml

    - name: Create a partition with drive letter D and size 5 GiB
      community.windows.win_partition:
        drive_letter: D
        partition_size: 5 GiB
        disk_number: 1

    - name: Full format the newly created partition as NTFS and label it
      community.windows.win_format:
        drive_letter: D
        file_system: NTFS
        new_label: Formatted
        full: True




Status
------


Authors
~~~~~~~

- Varun Chopra (@chopraaa) <v@chopraaa.com>
