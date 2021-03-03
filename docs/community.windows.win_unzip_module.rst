.. _community.windows.win_unzip_module:


***************************
community.windows.win_unzip
***************************

**Unzips compressed files and archives on the Windows node**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Unzips compressed files and archives.
- Supports .zip files natively.
- Supports other formats supported by the Powershell Community Extensions (PSCX) module (basically everything 7zip supports).
- For non-Windows targets, use the :ref:`ansible.builtin.unarchive <ansible.builtin.unarchive_module>` module instead.



Requirements
------------
The below requirements are needed on the host that executes this module.

- PSCX


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
                    <b>creates</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">path</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>If this file or directory exists the specified src will not be extracted.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>delete_archive</b>
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
                        <div>Remove the zip file, after unzipping.</div>
                        <div style="font-size: small; color: darkgreen"><br/>aliases: rm</div>
                </td>
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
                        <div>Destination of zip file (provide absolute path of directory). If it does not exist, the directory will be created.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>password</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">-</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>If a zip file is encrypted with password.</div>
                        <div>Passing a value to a password parameter requires the PSCX module to be installed.</div>
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
                        <div>Recursively expand zipped files within the src file.</div>
                        <div>Setting to a value of <code>yes</code> requires the PSCX module to be installed.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>src</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">path</span>
                         / <span style="color: red">required</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>File to be unzipped (provide absolute path).</div>
                </td>
            </tr>
    </table>
    <br/>


Notes
-----

.. note::
   - This module is not really idempotent, it will extract the archive every time, and report a change.
   - For extracting any compression types other than .zip, the PowerShellCommunityExtensions (PSCX) Module is required.  This module (in conjunction with PSCX) has the ability to recursively unzip files within the src zip file provided and also functionality for many other compression types. If the destination directory does not exist, it will be created before unzipping the file.  Specifying rm parameter will force removal of the src file after extraction.


See Also
--------

.. seealso::

   :ref:`ansible.builtin.unarchive_module`
      The official documentation on the **ansible.builtin.unarchive** module.


Examples
--------

.. code-block:: yaml

    # This unzips a library that was downloaded with win_get_url, and removes the file after extraction
    # $ ansible -i hosts -m win_unzip -a "src=C:\LibraryToUnzip.zip dest=C:\Lib remove=yes" all

    - name: Unzip a bz2 (BZip) file
      community.windows.win_unzip:
        src: C:\Users\Phil\Logs.bz2
        dest: C:\Users\Phil\OldLogs
        creates: C:\Users\Phil\OldLogs

    - name: Unzip gz log
      community.windows.win_unzip:
        src: C:\Logs\application-error-logs.gz
        dest: C:\ExtractedLogs\application-error-logs

    # Unzip .zip file, recursively decompresses the contained .gz files and removes all unneeded compressed files after completion.
    - name: Recursively decompress GZ files in ApplicationLogs.zip
      community.windows.win_unzip:
        src: C:\Downloads\ApplicationLogs.zip
        dest: C:\Application\Logs
        recurse: yes
        delete_archive: yes

    - name: Install PSCX
      community.windows.win_psmodule:
        name: Pscx
        state: present

    - name: Unzip .7z file which is password encrypted
      community.windows.win_unzip:
        src: C:\Downloads\ApplicationLogs.7z
        dest: C:\Application\Logs
        password: abcd
        delete_archive: yes



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
                    <b>dest</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>The provided destination path</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">C:\ExtractedLogs\application-error-logs</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>removed</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">boolean</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>Whether the module did remove any files during task run</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">True</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>src</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>The provided source path</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">C:\Logs\application-error-logs.gz</div>
                </td>
            </tr>
    </table>
    <br/><br/>


Status
------


Authors
~~~~~~~

- Phil Schwartz (@schwartzmx)
