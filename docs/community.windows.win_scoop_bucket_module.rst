.. _community.windows.win_scoop_bucket_module:


**********************************
community.windows.win_scoop_bucket
**********************************

**Manage Scoop buckets**


Version added: 1.0.0

.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Manage Scoop buckets



Requirements
------------
The below requirements are needed on the host that executes this module.

- git


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
                    <b>name</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                         / <span style="color: red">required</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Name of the Scoop bucket.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>repo</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Git repository that contains the scoop bucket</div>
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
                        <div>State of the Scoop bucket.</div>
                        <div>When <code>absent</code>, will ensure the package is not installed.</div>
                        <div>When <code>present</code>, will ensure the package is installed.</div>
                </td>
            </tr>
    </table>
    <br/>



See Also
--------

.. seealso::

   :ref:`community.windows.win_scoop_module`
      The official documentation on the **community.windows.win_scoop** module.
   `Scoop website <https://scoop.sh>`_
       More information about Scoop
   `Scoop directory <https://rasa.github.io/scoop-directory/>`_
       A directory of buckets for the scoop package manager for Windows


Examples
--------

.. code-block:: yaml

    - name: Add the extras bucket
      community.windows.win_scoop_bucket:
        name: extras

    - name: Remove the versions bucket
      community.windows.win_scoop_bucket:
        name: versions
        state: absent

    - name: Add a custom bucket
      community.windows.win_scoop_bucket:
        name: my-bucket
        repo: https://github.com/example/my-bucket




Status
------


Authors
~~~~~~~

- Jamie Magee (@JamieMagee)
