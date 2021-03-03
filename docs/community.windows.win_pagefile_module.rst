.. _community.windows.win_pagefile_module:


******************************
community.windows.win_pagefile
******************************

**Query or change pagefile configuration**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Query current pagefile configuration.
- Enable/Disable AutomaticManagedPagefile.
- Create new or override pagefile configuration.




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
                    <b>automatic</b>
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
                        <div>Configures AutomaticManagedPagefile for the entire system.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>drive</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The drive of the pagefile.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>initial_size</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The initial size of the pagefile in megabytes.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>maximum_size</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The maximum size of the pagefile in megabytes.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>override</b>
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
                        <div>Override the current pagefile on the drive.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>remove_all</b>
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
                        <div>Remove all pagefiles in the system, not including automatic managed.</div>
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
                                    <li>present</li>
                                    <li><div style="color: blue"><b>query</b>&nbsp;&larr;</div></li>
                        </ul>
                </td>
                <td>
                        <div>State of the pagefile.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>system_managed</b>
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
                        <div>Configures current pagefile to be managed by the system.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>test_path</b>
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
                        <div>Use Test-Path on the drive to make sure the drive is accessible before creating the pagefile.</div>
                </td>
            </tr>
    </table>
    <br/>


Notes
-----

.. note::
   - There is difference between automatic managed pagefiles that configured once for the entire system and system managed pagefile that configured per pagefile.
   - InitialSize 0 and MaximumSize 0 means the pagefile is managed by the system.
   - Value out of range exception may be caused by several different issues, two common problems - No such drive, Pagefile size is too small.
   - Setting a pagefile when AutomaticManagedPagefile is on will disable the AutomaticManagedPagefile.



Examples
--------

.. code-block:: yaml

    - name: Query pagefiles configuration
      community.windows.win_pagefile:

    - name: Query C pagefile
      community.windows.win_pagefile:
        drive: C

    - name: Set C pagefile, don't override if exists
      community.windows.win_pagefile:
        drive: C
        initial_size: 1024
        maximum_size: 1024
        override: no
        state: present

    - name: Set C pagefile, override if exists
      community.windows.win_pagefile:
        drive: C
        initial_size: 1024
        maximum_size: 1024
        state: present

    - name: Remove C pagefile
      community.windows.win_pagefile:
        drive: C
        state: absent

    - name: Remove all current pagefiles, enable AutomaticManagedPagefile and query at the end
      community.windows.win_pagefile:
        remove_all: yes
        automatic: yes

    - name: Remove all pagefiles disable AutomaticManagedPagefile and set C pagefile
      community.windows.win_pagefile:
        drive: C
        initial_size: 2048
        maximum_size: 2048
        remove_all: yes
        automatic: no
        state: present

    - name: Set D pagefile, override if exists
      community.windows.win_pagefile:
        drive: d
        initial_size: 1024
        maximum_size: 1024
        state: present



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
                    <b>automatic_managed_pagefiles</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">boolean</span>
                    </div>
                </td>
                <td>When state is query.</td>
                <td>
                            <div>Whether the pagefiles is automatically managed.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">True</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>pagefiles</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">list</span>
                    </div>
                </td>
                <td>When state is query.</td>
                <td>
                            <div>Contains caption, description, initial_size, maximum_size and name for each pagefile in the system.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">[{&#x27;caption&#x27;: &quot;c:\\ &#x27;pagefile.sys&#x27;&quot;, &#x27;description&#x27;: &quot;&#x27;pagefile.sys&#x27; @ c:\\&quot;, &#x27;initial_size&#x27;: 2048, &#x27;maximum_size&#x27;: 2048, &#x27;name&#x27;: &#x27;c:\\pagefile.sys&#x27;}, {&#x27;caption&#x27;: &quot;d:\\ &#x27;pagefile.sys&#x27;&quot;, &#x27;description&#x27;: &quot;&#x27;pagefile.sys&#x27; @ d:\\&quot;, &#x27;initial_size&#x27;: 1024, &#x27;maximum_size&#x27;: 1024, &#x27;name&#x27;: &#x27;d:\\pagefile.sys&#x27;}]</div>
                </td>
            </tr>
    </table>
    <br/><br/>


Status
------


Authors
~~~~~~~

- Liran Nisanov (@LiranNis)
