.. _community.windows.win_partition_module:


*******************************
community.windows.win_partition
*******************************

**Creates, changes and removes partitions on Windows Server**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- The :ref:`community.windows.win_partition <community.windows.win_partition_module>` module can create, modify or delete a partition on a disk




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
                    <b>active</b>
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
                        <div>Specifies if the partition is active and can be used to start the system. This property is only valid when the disk&#x27;s partition style is MBR.</div>
                </td>
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
                        <div>Disk number is mandatory for creating new partitions.</div>
                        <div>A combination of <em>disk_number</em> and <em>partition_number</em> can be used to specify the partition instead of <em>drive_letter</em> if required.</div>
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
                        <div>Used for accessing partitions if <em>disk_number</em> and <em>partition_number</em> are not provided.</div>
                        <div>Use <code>auto</code> for automatically assigning a drive letter, or a letter A-Z for manually assigning a drive letter to a new partition. If not specified, no drive letter is assigned when creating a new partition.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>gpt_type</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>system_partition</li>
                                    <li>microsoft_reserved</li>
                                    <li>basic_data</li>
                                    <li>microsoft_recovery</li>
                        </ul>
                </td>
                <td>
                        <div>Specify the partition&#x27;s GPT type if the disk&#x27;s partition style is GPT.</div>
                        <div>This only applies to new partitions.</div>
                        <div>This does not relate to the partitions file system formatting.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>hidden</b>
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
                        <div>Hides the target partition, making it undetectable by the mount manager.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>mbr_type</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>fat12</li>
                                    <li>fat16</li>
                                    <li>extended</li>
                                    <li>huge</li>
                                    <li>ifs</li>
                                    <li>fat32</li>
                        </ul>
                </td>
                <td>
                        <div>Specify the partition&#x27;s MBR type if the disk&#x27;s partition style is MBR.</div>
                        <div>This only applies to new partitions.</div>
                        <div>This does not relate to the partitions file system formatting.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>offline</b>
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
                        <div>Sets the partition offline.</div>
                        <div>Adding a mount point (such as a drive letter) will cause the partition to go online again.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>partition_number</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Used in conjunction with <em>disk_number</em> to uniquely identify a partition.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>partition_size</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Specify size of the partition in B, KB, KiB, MB, MiB, GB, GiB, TB or TiB. Use -1 to specify maximum supported size.</div>
                        <div>Partition size is mandatory for creating a new partition but not for updating or deleting a partition.</div>
                        <div>The decimal SI prefixes kilo, mega, giga, tera, etc., are powers of 10^3 = 1000. The binary prefixes kibi, mebi, gibi, tebi, etc. respectively refer to the corresponding power of 2^10 = 1024. Thus, a gigabyte (GB) is 1000000000 (1000^3) bytes while 1 gibibyte (GiB) is 1073741824 (1024^3) bytes.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>read_only</b>
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
                        <div>Make the partition read only, restricting changes from being made to the partition.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>state</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>absent</li>
                                    <li><div style="color: blue"><b>present</b>&nbsp;&larr;</div></li>
                        </ul>
                </td>
                <td>
                        <div>Used to specify the state of the partition. Use <code>absent</code> to specify if a partition should be removed and <code>present</code> to specify if the partition should be created or updated.</div>
                </td>
            </tr>
    </table>
    <br/>


Notes
-----

.. note::
   - A minimum Operating System Version of 6.2 is required to use this module. To check if your OS is compatible, see https://docs.microsoft.com/en-us/windows/desktop/sysinfo/operating-system-version.
   - This module cannot be used for removing the drive letter associated with a partition, initializing a disk or, file system formatting.
   - Idempotence works only if you're specifying a drive letter or other unique attributes such as a combination of disk number and partition number.
   - For more information, see https://msdn.microsoft.com/en-us/library/windows/desktop/hh830524.aspx.



Examples
--------

.. code-block:: yaml

    - name: Create a partition with drive letter D and size 5 GiB
      community.windows.win_partition:
        drive_letter: D
        partition_size: 5 GiB
        disk_number: 1

    - name: Resize previously created partition to it's maximum size and change it's drive letter to E
      community.windows.win_partition:
        drive_letter: E
        partition_size: -1
        partition_number: 1
        disk_number: 1

    - name: Delete partition
      community.windows.win_partition:
        disk_number: 1
        partition_number: 1
        state: absent




Status
------


Authors
~~~~~~~

- Varun Chopra (@chopraaa) <v@chopraaa.com>
