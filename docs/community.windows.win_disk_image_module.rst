.. _community.windows.win_disk_image_module:


********************************
community.windows.win_disk_image
********************************

**Manage ISO/VHD/VHDX mounts on Windows hosts**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Manages mount behavior for a specified ISO, VHD, or VHDX image on a Windows host. When ``state`` is ``present``, the image will be mounted under a system-assigned drive letter, which will be returned in the ``mount_path`` value of the module result.
- Requires Windows 8+ or Windows Server 2012+.




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
                    <b>image_path</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                         / <span style="color: red">required</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Path to an ISO, VHD, or VHDX image on the target Windows host (the file cannot reside on a network share)</div>
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
                        <div>Whether the image should be present as a drive-letter mount or not.</div>
                </td>
            </tr>
    </table>
    <br/>




Examples
--------

.. code-block:: yaml

    # Run installer from mounted ISO, then unmount
    - name: Ensure an ISO is mounted
      community.windows.win_disk_image:
        image_path: C:\install.iso
        state: present
      register: disk_image_out

    - name: Run installer from mounted ISO
      ansible.windows.win_package:
        path: '{{ disk_image_out.mount_paths[0] }}setup\setup.exe'
        product_id: 35a4e767-0161-46b0-979f-e61f282fee21
        state: present

    - name: Unmount ISO
      community.windows.win_disk_image:
        image_path: C:\install.iso
        state: absent



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
                    <b>mount_paths</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">list</span>
                    </div>
                </td>
                <td>when <code>state</code> is <code>present</code></td>
                <td>
                            <div>A list of filesystem paths mounted from the target image.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">[&#x27;E:\\&#x27;, &#x27;F:\\&#x27;]</div>
                </td>
            </tr>
    </table>
    <br/><br/>


Status
------


Authors
~~~~~~~

- Matt Davis (@nitzmahone)
