.. _community.windows.win_shortcut_module:


******************************
community.windows.win_shortcut
******************************

**Manage shortcuts on Windows**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Create, manage and delete Windows shortcuts




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
                    <b>arguments</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Additional arguments for the executable defined in <code>src</code>.</div>
                        <div style="font-size: small; color: darkgreen"><br/>aliases: args</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>description</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Description for the shortcut.</div>
                        <div>This is usually shown when hoovering the icon.</div>
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
                        <div>Destination file for the shortcuting file.</div>
                        <div>File name should have a <code>.lnk</code> or <code>.url</code> extension.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>directory</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">path</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Working directory for executable defined in <code>src</code>.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>hotkey</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Key combination for the shortcut.</div>
                        <div>This is a combination of one or more modifiers and a key.</div>
                        <div>Possible modifiers are Alt, Ctrl, Shift, Ext.</div>
                        <div>Possible keys are [A-Z] and [0-9].</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>icon</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">path</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Icon used for the shortcut.</div>
                        <div>File name should have a <code>.ico</code> extension.</div>
                        <div>The file name is followed by a comma and the number in the library file (.dll) or use 0 for an image file.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>run_as_admin</b>
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
                        <div>When <code>src</code> is an executable, this can control whether the shortcut will be opened as an administrator or not.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>src</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Executable or URL the shortcut points to.</div>
                        <div>The executable needs to be in your PATH, or has to be an absolute path to the executable.</div>
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
                        <div>When <code>absent</code>, removes the shortcut if it exists.</div>
                        <div>When <code>present</code>, creates or updates the shortcut.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>windowstyle</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>maximized</li>
                                    <li>minimized</li>
                                    <li>normal</li>
                        </ul>
                </td>
                <td>
                        <div>Influences how the application is displayed when it is launched.</div>
                </td>
            </tr>
    </table>
    <br/>


Notes
-----

.. note::
   - The following options can include Windows environment variables: ``dest``, ``args``, ``description``, ``dest``, ``directory``, ``icon`` ``src``
   - Windows has two types of shortcuts: Application and URL shortcuts. URL shortcuts only consists of ``dest`` and ``src``


See Also
--------

.. seealso::

   :ref:`ansible.windows.win_file_module`
      The official documentation on the **ansible.windows.win_file** module.


Examples
--------

.. code-block:: yaml

    - name: Create an application shortcut on the desktop
      community.windows.win_shortcut:
        src: C:\Program Files\Mozilla Firefox\Firefox.exe
        dest: C:\Users\Public\Desktop\Mozilla Firefox.lnk
        icon: C:\Program Files\Mozilla Firefox\Firefox.exe,0

    - name: Create the same shortcut using environment variables
      community.windows.win_shortcut:
        description: The Mozilla Firefox web browser
        src: '%ProgramFiles%\Mozilla Firefox\Firefox.exe'
        dest: '%Public%\Desktop\Mozilla Firefox.lnk'
        icon: '%ProgramFiles\Mozilla Firefox\Firefox.exe,0'
        directory: '%ProgramFiles%\Mozilla Firefox'
        hotkey: Ctrl+Alt+F

    - name: Create an application shortcut for an executable in PATH to your desktop
      community.windows.win_shortcut:
        src: cmd.exe
        dest: Desktop\Command prompt.lnk

    - name: Create an application shortcut for the Ansible website
      community.windows.win_shortcut:
        src: '%ProgramFiles%\Google\Chrome\Application\chrome.exe'
        dest: '%UserProfile%\Desktop\Ansible website.lnk'
        arguments: --new-window https://ansible.com/
        directory: '%ProgramFiles%\Google\Chrome\Application'
        icon: '%ProgramFiles%\Google\Chrome\Application\chrome.exe,0'
        hotkey: Ctrl+Alt+A

    - name: Create a URL shortcut for the Ansible website
      community.windows.win_shortcut:
        src: https://ansible.com/
        dest: '%Public%\Desktop\Ansible website.url'




Status
------


Authors
~~~~~~~

- Dag Wieers (@dagwieers)
