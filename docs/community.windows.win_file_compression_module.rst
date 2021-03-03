.. _community.windows.win_file_compression_module:


**************************************
community.windows.win_file_compression
**************************************

**Alters the compression of files and directories on NTFS partitions.**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- This module sets the compressed attribute for files and directories on a filesystem that supports it like NTFS.
- NTFS compression can be used to save disk space.




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
                    <b>force</b>
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
                        <div>This option only has an effect when <em>recurse</em> is <code>true</code></div>
                        <div>If <code>true</code>, will check the compressed state of all subdirectories and files and make a change if any are different from <em>compressed</em>.</div>
                        <div>If <code>false</code>, will only make a change if the compressed state of <em>path</em> is different from <em>compressed</em>.</div>
                        <div>If the folder structure is complex or contains a lot of files, it is recommended to set this option to <code>false</code> so that not every file has to be checked.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>path</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">path</span>
                         / <span style="color: red">required</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The full path of the file or directory to modify.</div>
                        <div>The path must exist on file system that supports compression like NTFS.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>recurse</b>
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
                        <div>Whether to recursively apply changes to all subdirectories and files.</div>
                        <div>This option only has an effect when <em>path</em> is a directory.</div>
                        <div>When set to <code>false</code>, only applies changes to <em>path</em>.</div>
                        <div>When set to <code>true</code>, applies changes to <em>path</em> and all subdirectories and files.</div>
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
                        <div>Set to <code>present</code> to ensure the <em>path</em> is compressed.</div>
                        <div>Set to <code>absent</code> to ensure the <em>path</em> is not compressed.</div>
                </td>
            </tr>
    </table>
    <br/>


Notes
-----

.. note::
   - :ref:`community.windows.win_file_compression <community.windows.win_file_compression_module>` sets the file system's compression state, it does not create a zip archive file.
   - For more about NTFS Compression, see http://www.ntfs.com/ntfs-compressed.htm



Examples
--------

.. code-block:: yaml

    - name: Compress log files directory
      community.windows.win_file_compression:
        path: C:\Logs
        state: present

    - name: Decompress log files directory
      community.windows.win_file_compression:
        path: C:\Logs
        state: absent

    - name: Compress reports directory and all subdirectories
      community.windows.win_file_compression:
        path: C:\business\reports
        state: present
        recurse: yes

    # This will only check C:\business\reports for the compressed state
    # If C:\business\reports is compressed, it will not make a change
    # even if one of the child items is uncompressed

    - name: Compress reports directory and all subdirectories (quick)
      community.windows.win_file_compression:
        path: C:\business\reports
        compressed: yes
        recurse: yes
        force: no



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
                    <b>rc</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>The return code of the compress/uncompress operation.</div>
                            <div>If no changes are made or the operation is successful, rc is 0.</div>
                    <br/>
                </td>
            </tr>
    </table>
    <br/><br/>


Status
------


Authors
~~~~~~~

- Micah Hunsberger (@mhunsber)
