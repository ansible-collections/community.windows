.. _community.windows.win_lineinfile_module:


********************************
community.windows.win_lineinfile
********************************

**Ensure a particular line is in a file, or replace an existing line using a back-referenced regular expression**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- This module will search a file for a line, and ensure that it is present or absent.
- This is primarily useful when you want to change a single line in a file only.




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
                    <b>backrefs</b>
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
                        <div>Used with <code>state=present</code>. If set, line can contain backreferences (both positional and named) that will get populated if the <code>regexp</code> matches. This flag changes the operation of the module slightly; <code>insertbefore</code> and <code>insertafter</code> will be ignored, and if the <code>regexp</code> doesn&#x27;t match anywhere in the file, the file will be left unchanged.</div>
                        <div>If the <code>regexp</code> does match, the last matching line will be replaced by the expanded line parameter.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>backup</b>
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
                        <div>Determine whether a backup should be created.</div>
                        <div>When set to <code>yes</code>, create a backup file including the timestamp information so you can get the original file back if you somehow clobbered it incorrectly.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>create</b>
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
                        <div>Used with <code>state=present</code>. If specified, the file will be created if it does not already exist. By default it will fail if the file is missing.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>encoding</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <b>Default:</b><br/><div style="color: blue">"auto"</div>
                </td>
                <td>
                        <div>Specifies the encoding of the source text file to operate on (and thus what the output encoding will be). The default of <code>auto</code> will cause the module to auto-detect the encoding of the source file and ensure that the modified file is written with the same encoding.</div>
                        <div>An explicit encoding can be passed as a string that is a valid value to pass to the .NET framework System.Text.Encoding.GetEncoding() method - see <a href='https://msdn.microsoft.com/en-us/library/system.text.encoding%28v=vs.110%29.aspx'>https://msdn.microsoft.com/en-us/library/system.text.encoding%28v=vs.110%29.aspx</a>.</div>
                        <div>This is mostly useful with <code>create=yes</code> if you want to create a new file with a specific encoding. If <code>create=yes</code> is specified without a specific encoding, the default encoding (UTF-8, no BOM) will be used.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>insertafter</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li><div style="color: blue"><b>EOF</b>&nbsp;&larr;</div></li>
                                    <li>*regex*</li>
                        </ul>
                </td>
                <td>
                        <div>Used with <code>state=present</code>. If specified, the line will be inserted after the last match of specified regular expression. A special value is available; <code>EOF</code> for inserting the line at the end of the file.</div>
                        <div>If specified regular expression has no matches, EOF will be used instead. May not be used with <code>backrefs</code>.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>insertbefore</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>BOF</li>
                                    <li>*regex*</li>
                        </ul>
                </td>
                <td>
                        <div>Used with <code>state=present</code>. If specified, the line will be inserted before the last match of specified regular expression. A value is available; <code>BOF</code> for inserting the line at the beginning of the file.</div>
                        <div>If specified regular expression has no matches, the line will be inserted at the end of the file. May not be used with <code>backrefs</code>.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>line</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Required for <code>state=present</code>. The line to insert/replace into the file. If <code>backrefs</code> is set, may contain backreferences that will get expanded with the <code>regexp</code> capture groups if the regexp matches.</div>
                        <div>Be aware that the line is processed first on the controller and thus is dependent on yaml quoting rules. Any double quoted line will have control characters, such as &#x27;\r\n&#x27;, expanded. To print such characters literally, use single or no quotes.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>newline</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>unix</li>
                                    <li><div style="color: blue"><b>windows</b>&nbsp;&larr;</div></li>
                        </ul>
                </td>
                <td>
                        <div>Specifies the line separator style to use for the modified file. This defaults to the windows line separator (<code>\r\n</code>). Note that the indicated line separator will be used for file output regardless of the original line separator that appears in the input file.</div>
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
                        <div>The path of the file to modify.</div>
                        <div>Note that the Windows path delimiter <code>\</code> must be escaped as <code>\\</code> when the line is double quoted.</div>
                        <div style="font-size: small; color: darkgreen"><br/>aliases: dest, destfile, name</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>regex</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">-</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The regular expression to look for in every line of the file. For <code>state=present</code>, the pattern to replace if found; only the last line found will be replaced. For <code>state=absent</code>, the pattern of the line to remove. Uses .NET compatible regular expressions; see <a href='https://msdn.microsoft.com/en-us/library/hs600312%28v=vs.110%29.aspx'>https://msdn.microsoft.com/en-us/library/hs600312%28v=vs.110%29.aspx</a>.</div>
                        <div style="font-size: small; color: darkgreen"><br/>aliases: regexp</div>
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
                        <div>Whether the line should be there or not.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>validate</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Validation to run before copying into place. Use %s in the command to indicate the current file to validate.</div>
                        <div>The command is passed securely so shell features like expansion and pipes won&#x27;t work.</div>
                </td>
            </tr>
    </table>
    <br/>



See Also
--------

.. seealso::

   :ref:`ansible.builtin.assemble_module`
      The official documentation on the **ansible.builtin.assemble** module.
   :ref:`ansible.builtin.lineinfile_module`
      The official documentation on the **ansible.builtin.lineinfile** module.


Examples
--------

.. code-block:: yaml

    - name: Insert path without converting \r\n
      community.windows.win_lineinfile:
        path: c:\file.txt
        line: c:\return\new

    - community.windows.win_lineinfile:
        path: C:\Temp\example.conf
        regex: '^name='
        line: 'name=JohnDoe'

    - community.windows.win_lineinfile:
        path: C:\Temp\example.conf
        regex: '^name='
        state: absent

    - community.windows.win_lineinfile:
        path: C:\Temp\example.conf
        regex: '^127\.0\.0\.1'
        line: '127.0.0.1 localhost'

    - community.windows.win_lineinfile:
        path: C:\Temp\httpd.conf
        regex: '^Listen '
        insertafter: '^#Listen '
        line: Listen 8080

    - community.windows.win_lineinfile:
        path: C:\Temp\services
        regex: '^# port for http'
        insertbefore: '^www.*80/tcp'
        line: '# port for http by default'

    - name: Create file if it doesn't exist with a specific encoding
      community.windows.win_lineinfile:
        path: C:\Temp\utf16.txt
        create: yes
        encoding: utf-16
        line: This is a utf-16 encoded file

    - name: Add a line to a file and ensure the resulting file uses unix line separators
      community.windows.win_lineinfile:
        path: C:\Temp\testfile.txt
        line: Line added to file
        newline: unix

    - name: Update a line using backrefs
      community.windows.win_lineinfile:
        path: C:\Temp\example.conf
        backrefs: yes
        regex: '(^name=)'
        line: '$1JohnDoe'



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
                    <b>backup</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>if backup=yes</td>
                <td>
                            <div>Name of the backup file that was created.</div>
                            <div>This is now deprecated, use <code>backup_file</code> instead.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">C:\Path\To\File.txt.11540.20150212-220915.bak</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>backup_file</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>if backup=yes</td>
                <td>
                            <div>Name of the backup file that was created.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">C:\Path\To\File.txt.11540.20150212-220915.bak</div>
                </td>
            </tr>
    </table>
    <br/><br/>


Status
------


Authors
~~~~~~~

- Brian Lloyd (@brianlloyd)
