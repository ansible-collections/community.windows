.. _community.windows.win_disk_facts_module:


********************************
community.windows.win_disk_facts
********************************

**Show the attached disks and disk information of the target host**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- With the module you can retrieve and output detailed information about the attached disks of the target and its volumes and partitions if existent.



Requirements
------------
The below requirements are needed on the host that executes this module.

- Windows 8.1 / Windows 2012 (NT 6.2)



Notes
-----

.. note::
   - In order to understand all the returned properties and values please visit the following site and open the respective MSFT class https://msdn.microsoft.com/en-us/library/windows/desktop/hh830612.aspx



Examples
--------

.. code-block:: yaml

    - name: Get disk facts
      community.windows.win_disk_facts:

    - name: Output first disk size
      debug:
        var: ansible_facts.disks[0].size

    - name: Convert first system disk into various formats
      debug:
        msg: '{{ disksize_gib }} vs {{ disksize_gib_human }}'
      vars:
        # Get first system disk
        disk: '{{ ansible_facts.disks|selectattr("system_disk")|first }}'

        # Show disk size in Gibibytes
        disksize_gib_human: '{{ disk.size|filesizeformat(true) }}'   # returns "223.6 GiB" (human readable)
        disksize_gib: '{{ (disk.size/1024|pow(3))|round|int }} GiB'  # returns "224 GiB" (value in GiB)

        # Show disk size in Gigabytes
        disksize_gb_human: '{{ disk.size|filesizeformat }}'        # returns "240.1 GB" (human readable)
        disksize_gb: '{{ (disk.size/1000|pow(3))|round|int }} GB'  # returns "240 GB" (value in GB)

    - name: Output second disk serial number
      debug:
        var: ansible_facts.disks[1].serial_number


Returned Facts
--------------
Facts returned by this module are added/updated in the ``hostvars`` host facts and can be referenced by name just like any other host fact. They do not need to be registered in order to use them.

.. raw:: html

    <table border=0 cellpadding=0 class="documentation-table">
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        <tr>
            <th colspan="4">Fact</th>
            <th>Returned</th>
            <th width="100%">Description</th>
        </tr>
            <tr>
                <td colspan="4" colspan="4">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>ansible_disks</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">list</span>
                    </div>
                </td>
                <td>if disks were found</td>
                <td>
                            <div>Detailed information about one particular disk.
                            </div>
                    <br/>
                </td>
            </tr>
                                <tr>
                    <td class="elbow-placeholder"></td>
                <td colspan="3" colspan="3">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>bootable</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">boolean</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Information whether the particular disk is a bootable disk.
                            </div>
                    <br/>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                <td colspan="3" colspan="3">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>bus_type</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Bus type of the particular disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">SCSI</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                <td colspan="3" colspan="3">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>clustered</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">boolean</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Information whether the particular disk is clustered (part of a failover cluster).
                            </div>
                    <br/>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                <td colspan="3" colspan="3">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>firmware_version</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Firmware version of the particular disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">0001</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                <td colspan="3" colspan="3">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>friendly_name</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Friendly name of the particular disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">Red Hat VirtIO SCSI Disk Device</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                <td colspan="3" colspan="3">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>guid</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>if existent</td>
                <td>
                            <div>GUID of the particular disk on the target.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">{efa5f928-57b9-47fc-ae3e-902e85fbe77f}</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                <td colspan="3" colspan="3">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>location</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Location of the particular disk on the target.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">PCIROOT(0)#PC<em>0400</em>#SCS<em>P00T00L00</em></div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                <td colspan="3" colspan="3">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>manufacturer</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Manufacturer of the particular disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">Red Hat</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                <td colspan="3" colspan="3">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>model</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Model specification of the particular disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">VirtIO</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                <td colspan="3" colspan="3">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>number</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Disk number of the particular disk.
                            </div>
                    <br/>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                <td colspan="3" colspan="3">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>operational_status</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Operational status of the particular disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">Online</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                <td colspan="3" colspan="3">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>partition_count</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Number of partitions on the particular disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">4</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                <td colspan="3" colspan="3">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>partition_style</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Partition style of the particular disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">MBR</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                <td colspan="3" colspan="3">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>partitions</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">list</span>
                    </div>
                </td>
                <td>if existent</td>
                <td>
                            <div>Detailed information about one particular partition on the specified disk.
                            </div>
                    <br/>
                </td>
            </tr>
                                <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>access_paths</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>if existent</td>
                <td>
                            <div>Access paths of the particular partition.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">\\?\Volume{85bdc4a8-f8eb-11e6-80fa-806e6f6e6963}\</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>active</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">boolean</span>
                    </div>
                </td>
                <td>if partition_style property of the particular disk has value &quot;MBR&quot;</td>
                <td>
                            <div>Information whether the particular partition is an active partition or not.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">True</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>drive_letter</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>if existent</td>
                <td>
                            <div>Drive letter of the particular partition.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">C</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>gpt_type</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>if partition_style property of the particular disk has value &quot;GPT&quot;</td>
                <td>
                            <div>gpt type of the particular partition.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">{e3c9e316-0b5c-4db8-817d-f92df00215ae}</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>guid</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>if existent</td>
                <td>
                            <div>GUID of the particular partition.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">{302e475c-6e64-4674-a8e2-2f1c7018bf97}</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>hidden</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">boolean</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Information whether the particular partition is hidden or not.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">True</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>mbr_type</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>if partition_style property of the particular disk has value &quot;MBR&quot;</td>
                <td>
                            <div>mbr type of the particular partition.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">7</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>no_default_driveletter</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">boolean</span>
                    </div>
                </td>
                <td>if partition_style property of the particular disk has value &quot;GPT&quot;</td>
                <td>
                            <div>Information whether the particular partition has a default drive letter or not.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">True</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>number</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Number of the particular partition.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">1</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>offset</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Offset of the particular partition.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">368050176</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>shadow_copy</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">boolean</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Information whether the particular partition is a shadow copy of another partition.
                            </div>
                    <br/>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>size</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Size in bytes of the particular partition.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">838860800</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>transition_state</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Transition state of the particular partition.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">1</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>type</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Type of the particular partition.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">IFS</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>volumes</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">list</span>
                    </div>
                </td>
                <td>if existent</td>
                <td>
                            <div>Detailed information about one particular volume on the specified partition.
                            </div>
                    <br/>
                </td>
            </tr>
                                <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="1" colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>allocation_unit_size</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Allocation unit size in bytes of the particular volume.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">4096</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="1" colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>drive_type</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Drive type of the particular volume.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">Fixed</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="1" colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>health_status</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Health status of the particular volume.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">Healthy</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="1" colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>label</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>File system label of the particular volume.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">System Reserved</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="1" colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>object_id</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Object ID of the particular volume.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">\\?\Volume{85bdc4a9-f8eb-11e6-80fa-806e6f6e6963}\</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="1" colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>path</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Path of the particular volume.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">\\?\Volume{85bdc4a9-f8eb-11e6-80fa-806e6f6e6963}\</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="1" colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>size</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Size in bytes of the particular volume.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">838856704</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="1" colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>size_remaining</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Remaining size in bytes of the particular volume.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">395620352</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="1" colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>type</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>File system type of the particular volume.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">NTFS</div>
                </td>
            </tr>


            <tr>
                    <td class="elbow-placeholder"></td>
                <td colspan="3" colspan="3">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>path</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Path of the particular disk on the target.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">\\?\scsi#disk&amp;ven_red_hat&amp;prod_virtio#4&amp;23208fd0&amp;1&amp;000000#{&lt;id&gt;}</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                <td colspan="3" colspan="3">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>physical_disk</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">complex</span>
                    </div>
                </td>
                <td>if existent</td>
                <td>
                            <div>Detailed information about physical disk properties of the particular disk.
                            </div>
                    <br/>
                </td>
            </tr>
                                <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>allocated_size</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Allocated size in bytes of the particular physical disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">240057409536</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>bus_type</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Bus type of the particular physical disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">SCSI</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>can_pool</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">boolean</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Information whether the particular physical disk can be added to a storage pool.
                            </div>
                    <br/>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>cannot_pool_reason</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>if can_pool property has value false</td>
                <td>
                            <div>Information why the particular physical disk can not be added to a storage pool.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">Insufficient Capacity</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>device_id</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Device ID of the particular physical disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">0</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>friendly_name</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Friendly name of the particular physical disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">PhysicalDisk0</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>health_status</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Health status of the particular physical disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">Healthy</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>indication_enabled</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">boolean</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Information whether indication is enabled for the particular physical disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">True</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>manufacturer</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Manufacturer of the particular physical disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">SUSE</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>media_type</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Media type of the particular physical disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">UnSpecified</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>model</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Model of the particular physical disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">Xen Block</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>object_id</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Object ID of the particular physical disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">{1}\\\\HOST\\root/Microsoft/Windows/Storage/Providers_v2\\SPACES_PhysicalDisk.ObjectId=\&quot;{&lt;object_id&gt;}:PD:{&lt;pd&gt;}\&quot;</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>operational_status</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Operational status of the particular physical disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">OK</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>partial</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">boolean</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Information whether the particular physical disk is partial.
                            </div>
                    <br/>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>physical_location</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Physical location of the particular physical disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">Integrated : Adapter 3 : Port 0 : Target 0 : LUN 0</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>serial_number</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Serial number of the particular physical disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">b62beac80c3645e5877f</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>size</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Size in bytes of the particular physical disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">240057409536</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>spindle_speed</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Spindle speed in rpm of the particular physical disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">4294967295</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>supported_usages</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">complex</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Supported usage types of the particular physical disk.
                            </div>
                    <br/>
                </td>
            </tr>
                                <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="1" colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>Count</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Count of supported usage types.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">5</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="1" colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>value</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>List of supported usage types.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">Auto-Select, Hot Spare</div>
                </td>
            </tr>

            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>unique_id</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Unique ID of the particular physical disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">3141463431303031</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>usage_type</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Usage type of the particular physical disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">Auto-Select</div>
                </td>
            </tr>

            <tr>
                    <td class="elbow-placeholder"></td>
                <td colspan="3" colspan="3">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>read_only</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">boolean</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Read only status of the particular disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">True</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                <td colspan="3" colspan="3">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>sector_size</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Sector size in bytes of the particular disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">4096</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                <td colspan="3" colspan="3">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>serial_number</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Serial number of the particular disk on the target.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">b62beac80c3645e5877f</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                <td colspan="3" colspan="3">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>size</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Size in bytes of the particular disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">227727638528</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                <td colspan="3" colspan="3">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>system_disk</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">boolean</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Information whether the particular disk is a system disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">True</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                <td colspan="3" colspan="3">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>unique_id</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Unique ID of the particular disk on the target.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">3141463431303031</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                <td colspan="3" colspan="3">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>virtual_disk</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">complex</span>
                    </div>
                </td>
                <td>if existent</td>
                <td>
                            <div>Detailed information about virtual disk properties of the particular disk.
                            </div>
                    <br/>
                </td>
            </tr>
                                <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>access</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Access of the particular virtual disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">Read/Write</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>allocated_size</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Allocated size in bytes of the particular virtual disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">240057409536</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>allocation_unit_size</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Allocation unit size in bytes of the particular virtual disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">4096</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>available_copies</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>if existent</td>
                <td>
                            <div>Number of the available copies of the particular virtual disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">1</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>columns</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Number of the columns of the particular virtual disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">2</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>deduplication_enabled</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">boolean</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Information whether deduplication is enabled for the particular virtual disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">True</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>detached_reason</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Detached reason of the particular virtual disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">None</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>enclosure_aware</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">boolean</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Information whether the particular virtual disk is enclosure aware.
                            </div>
                    <br/>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>fault_domain_awareness</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Fault domain awareness of the particular virtual disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">PhysicalDisk</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>footprint_on_pool</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Footprint on pool in bytes of the particular virtual disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">240057409536</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>friendly_name</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Friendly name of the particular virtual disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">Prod2 Virtual Disk</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>groups</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Number of the groups of the particular virtual disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">1</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>health_status</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Health status of the particular virtual disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">Healthy</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>inter_leave</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Inter leave in bytes of the particular virtual disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">102400</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>logical_sector_size</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Logical sector size in byte of the particular virtual disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">512</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>manual_attach</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">boolean</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Information whether the particular virtual disk is manual attached.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">True</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>media_type</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Media type of the particular virtual disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">Unspecified</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>name</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Name of the particular virtual disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">vDisk1</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>object_id</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Object ID of the particular virtual disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">{1}\\\\HOST\\root/Microsoft/Windows/Storage/Providers_v2\\SPACES_VirtualDisk.ObjectId=\&quot;{&lt;object_id&gt;}:VD:{&lt;vd&gt;}\&quot;</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>operational_status</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Operational status of the particular virtual disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">OK</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>parity_layout</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>if existent</td>
                <td>
                            <div>Parity layout of the particular virtual disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">1</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>physical_disk_redundancy</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Type of the physical disk redundancy of the particular virtual disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">1</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>physical_sector_size</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Physical sector size in bytes of the particular virtual disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">4096</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>provisioning_type</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Provisioning type of the particular virtual disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">Thin</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>read_cache_size</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Read cache size in byte of the particular virtual disk.
                            </div>
                    <br/>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>request_no_spof</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">boolean</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Information whether the particular virtual disk requests no single point of failure.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">True</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>resiliency_setting_name</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Type of the physical disk redundancy of the particular virtual disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">1</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>size</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Size in bytes of the particular virtual disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">240057409536</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>snapshot</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">boolean</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Information whether the particular virtual disk is a snapshot.
                            </div>
                    <br/>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>tiered</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">boolean</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Information whether the particular virtual disk is tiered.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">True</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>unique_id</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Unique ID of the particular virtual disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">260542E4C6B01D47A8FA7630FD90FFDE</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>unique_id_format</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Unique ID format of the particular virtual disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">Vendor Specific</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>write_cache_size</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Write cache size in byte of the particular virtual disk.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">100</div>
                </td>
            </tr>

            <tr>
                    <td class="elbow-placeholder"></td>
                <td colspan="3" colspan="3">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>win32_disk_drive</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">complex</span>
                    </div>
                </td>
                <td>if existent</td>
                <td>
                            <div>Representation of the Win32_DiskDrive class.
                            </div>
                    <br/>
                </td>
            </tr>
                                <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>availability</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Availability and status of the device.
                            </div>
                    <br/>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>bytes_per_sector</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Number of bytes in each sector for the physical disk drive.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">512</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>capabilities</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">list</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Array of capabilities of the media access device.
                            </div>
                            <div>For example, the device may support random access (3), removable media (7), and automatic cleaning (9).
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">[3, 4]</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>capability_descriptions</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">list</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>List of more detailed explanations for any of the access device features indicated in the Capabilities array.
                            </div>
                            <div>Note, each entry of this array is related to the entry in the Capabilities array that is located at the same index.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">[&#x27;Random Access&#x27;, &#x27;Supports Writing&#x27;]</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>caption</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Short description of the object.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">VMware Virtual disk SCSI Disk Device</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>compression_method</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Algorithm or tool used by the device to support compression.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">Compressed</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>config_manager_error_code</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Windows Configuration Manager error code.
                            </div>
                    <br/>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>config_manager_user_config</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">boolean</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>If True, the device is using a user-defined configuration.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">True</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>creation_class_name</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Name of the first concrete class to appear in the inheritance chain used in the creation of an instance.
                            </div>
                            <div>When used with the other key properties of the class, the property allows all instances of this class
                            </div>
                            <div>and its subclasses to be uniquely identified.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">Win32_DiskDrive</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>default_block_size</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Default block size, in bytes, for this device.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">512</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>description</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Description of the object.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">Disk drive</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>device_id</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Unique identifier of the disk drive with other devices on the system.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">\\.\PHYSICALDRIVE0</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>error_cleared</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">boolean</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>If True, the error reported in LastErrorCode is now cleared.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">True</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>error_description</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>More information about the error recorded in LastErrorCode,
                            </div>
                            <div>and information on any corrective actions that may be taken.
                            </div>
                    <br/>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>error_methodology</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Type of error detection and correction supported by this device.
                            </div>
                    <br/>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>firmware_revision</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Revision for the disk drive firmware that is assigned by the manufacturer.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">1.0</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>index</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Physical drive number of the given drive.
                            </div>
                            <div>This property is filled by the STORAGE_DEVICE_NUMBER structure returned from the IOCTL_STORAGE_GET_DEVICE_NUMBER control code
                            </div>
                            <div>A value of 0xffffffff indicates that the given drive does not map to a physical drive.
                            </div>
                    <br/>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>install_date</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Date and time the object was installed. This property does not need a value to indicate that the object is installed.
                            </div>
                    <br/>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>interface_type</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Interface type of physical disk drive.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">SCSI</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>last_error_code</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Last error code reported by the logical device.
                            </div>
                    <br/>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>manufacturer</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Name of the disk drive manufacturer.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">Seagate</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>max_block_size</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Maximum block size, in bytes, for media accessed by this device.
                            </div>
                    <br/>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>max_media_size</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Maximum media size, in kilobytes, of media supported by this device.
                            </div>
                    <br/>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>media_loaded</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">boolean</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>If True, the media for a disk drive is loaded, which means that the device has a readable file system and is accessible.
                            </div>
                            <div>For fixed disk drives, this property will always be TRUE.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">True</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>media_type</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Type of media used or accessed by this device.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">Fixed hard disk media</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>min_block_size</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Minimum block size, in bytes, for media accessed by this device.
                            </div>
                    <br/>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>model</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Manufacturer&#x27;s model number of the disk drive.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">ST32171W</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>name</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Label by which the object is known. When subclassed, the property can be overridden to be a key property.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">\\\\.\\PHYSICALDRIVE0</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>needs_cleaning</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">boolean</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>If True, the media access device needs cleaning.
                            </div>
                            <div>Whether manual or automatic cleaning is possible is indicated in the Capabilities property.
                            </div>
                    <br/>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>number_of_media_supported</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Maximum number of media which can be supported or inserted
                            </div>
                            <div>(when the media access device supports multiple individual media).
                            </div>
                    <br/>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>partitions</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Number of partitions on this physical disk drive that are recognized by the operating system.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">3</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>pnp_device_id</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Windows Plug and Play device identifier of the logical device.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">SCSI\DISK&amp;VEN_VMWARE&amp;PROD_VIRTUAL_DISK\5&amp;1982005&amp;0&amp;000000</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>power_management_capabilities</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">list</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Array of the specific power-related capabilities of a logical device.
                            </div>
                    <br/>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>power_management_supported</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">boolean</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>If True, the device can be power-managed (can be put into suspend mode, and so on).
                            </div>
                            <div>The property does not indicate that power management features are currently enabled,
                            </div>
                            <div>only that the logical device is capable of power management.
                            </div>
                    <br/>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>scsi_bus</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>SCSI bus number of the disk drive.
                            </div>
                    <br/>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>scsi_logical_unit</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>SCSI logical unit number (LUN) of the disk drive.
                            </div>
                    <br/>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>scsi_port</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>SCSI port number of the disk drive.
                            </div>
                    <br/>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>scsi_target_id</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>SCSI identifier number of the disk drive.
                            </div>
                    <br/>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>sectors_per_track</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Number of sectors in each track for this physical disk drive.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">63</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>serial_number</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Number allocated by the manufacturer to identify the physical media.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">6000c298f34101b38cb2b2508926b9de</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>signature</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Disk identification. This property can be used to identify a shared resource.
                            </div>
                    <br/>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>size</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Size of the disk drive. It is calculated by multiplying the total number of cylinders, tracks in each cylinder,
                            </div>
                            <div>sectors in each track, and bytes in each sector.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">53686402560</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>status</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Current status of the object. Various operational and nonoperational statuses can be defined.
                            </div>
                            <div>Operational statuses include: &quot;OK&quot;, &quot;Degraded&quot;, and &quot;Pred Fail&quot;
                            </div>
                            <div>(an element, such as a SMART-enabled hard disk drive, may be functioning properly but predicting a failure in the near future).
                            </div>
                            <div>Nonoperational statuses include: &quot;Error&quot;, &quot;Starting&quot;, &quot;Stopping&quot;, and &quot;Service&quot;.
                            </div>
                            <div>&quot;Service&quot;, could apply during mirror-resilvering of a disk, reload of a user permissions list, or other administrative work.
                            </div>
                            <div>Not all such work is online, yet the managed element is neither &quot;OK&quot; nor in one of the other states.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">OK</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>status_info</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>State of the logical device. If this property does not apply to the logical device, the value 5 (Not Applicable) should be used.
                            </div>
                    <br/>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>system_creation_class_name</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Value of the scoping computer&#x27;s CreationClassName property.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">Win32_ComputerSystem</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>system_name</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Name of the scoping system.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">WILMAR-TEST-123</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>total_cylinders</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Total number of cylinders on the physical disk drive.
                            </div>
                            <div>Note: the value for this property is obtained through extended functions of BIOS interrupt 13h.
                            </div>
                            <div>The value may be inaccurate if the drive uses a translation scheme to support high-capacity disk sizes.
                            </div>
                            <div>Consult the manufacturer for accurate drive specifications.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">6527</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>total_heads</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Total number of heads on the disk drive.
                            </div>
                            <div>Note: the value for this property is obtained through extended functions of BIOS interrupt 13h.
                            </div>
                            <div>The value may be inaccurate if the drive uses a translation scheme to support high-capacity disk sizes.
                            </div>
                            <div>Consult the manufacturer for accurate drive specifications.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">255</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>total_sectors</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Total number of sectors on the physical disk drive.
                            </div>
                            <div>Note: the value for this property is obtained through extended functions of BIOS interrupt 13h.
                            </div>
                            <div>The value may be inaccurate if the drive uses a translation scheme to support high-capacity disk sizes.
                            </div>
                            <div>Consult the manufacturer for accurate drive specifications.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">104856255</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>total_tracks</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Total number of tracks on the physical disk drive.
                            </div>
                            <div>Note: the value for this property is obtained through extended functions of BIOS interrupt 13h.
                            </div>
                            <div>The value may be inaccurate if the drive uses a translation scheme to support high-capacity disk sizes.
                            </div>
                            <div>Consult the manufacturer for accurate drive specifications.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">1664385</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="2" colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>tracks_per_cylinder</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Number of tracks in each cylinder on the physical disk drive.
                            </div>
                            <div>Note: the value for this property is obtained through extended functions of BIOS interrupt 13h.
                            </div>
                            <div>The value may be inaccurate if the drive uses a translation scheme to support high-capacity disk sizes.
                            </div>
                            <div>Consult the manufacturer for accurate drive specifications.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">255</div>
                </td>
            </tr>


    </table>
    <br/><br/>



Status
------


Authors
~~~~~~~

- Marc Tschapek (@marqelme)
