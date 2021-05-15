.. _community.windows.win_zip_module:


*************************
community.windows.win_zip
*************************

**Compress file or directory as zip archive on the Windows node**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Compress file or directory as zip archive.
- For non-Windows targets, use the :ref:`ansible.builtin.archive <ansible.builtin.archive_module>` module instead.



Requirements
------------
The below requirements are needed on the host that executes this module.

- .NET Framework 4.5 or later


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
                    <b>dest</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">path</span>
                         / <span style="color: red">required</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Destination path of zip file (provide absolute path of zip file on the target node).</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>src</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                         / <span style="color: red">required</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>File or directory path to be zipped (provide absolute path on the target node).</div>
                        <div>When a directory path the directory is zipped as the root entry in the archive.</div>
                        <div>Specify <code>\*</code> to the end of <em>src</em> to zip the contents of the directory and not the directory itself.</div>
                </td>
            </tr>
    </table>
    <br/>


Notes
-----

.. note::
   - The filenames in the zip are encoded using UTF-8.


See Also
--------

.. seealso::

   :ref:`ansible.builtin.archive_module`
      The official documentation on the **ansible.builtin.archive** module.


Examples
--------

.. code-block:: yaml

    - name: Compress a file
      community.windows.win_zip:
        src: C:\Users\hiyoko\log.txt
        dest: C:\Users\hiyoko\log.zip

    - name: Compress a directory as the root of the archive
      community.windows.win_zip:
        src: C:\Users\hiyoko\log
        dest: C:\Users\hiyoko\log.zip

    - name: Compress the directories contents
      community.windows.win_zip:
        src: C:\Users\hiyoko\log\*
        dest: C:\Users\hiyoko\log.zip




Status
------


Authors
~~~~~~~

- Kento Yagisawa (@hiyoko_taisa)
