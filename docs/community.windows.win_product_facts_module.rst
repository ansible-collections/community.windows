.. _community.windows.win_product_facts_module:


***********************************
community.windows.win_product_facts
***********************************

**Provides Windows product and license information**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Provides Windows product and license information.







Examples
--------

.. code-block:: yaml

    - name: Get product id and product key
      community.windows.win_product_facts:

    - name: Display Windows edition
      debug:
        var: ansible_os_license_edition

    - name: Display Windows license status
      debug:
        var: ansible_os_license_status


Returned Facts
--------------
Facts returned by this module are added/updated in the ``hostvars`` host facts and can be referenced by name just like any other host fact. They do not need to be registered in order to use them.

.. raw:: html

    <table border=0 cellpadding=0 class="documentation-table">
                                                                    <tr>
            <th colspan="1">Fact</th>
            <th>Returned</th>
            <th width="100%">Description</th>
        </tr>
            <tr>
                <td colspan="1" colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>ansible_os_license_channel</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>The Windows license channel.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">Volume:MAK</div>
                </td>
            </tr>
            <tr>
                <td colspan="1" colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>ansible_os_license_edition</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>The Windows license edition.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">Windows(R) ServerStandard edition</div>
                </td>
            </tr>
            <tr>
                <td colspan="1" colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>ansible_os_license_status</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>The Windows license status.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">Licensed</div>
                </td>
            </tr>
            <tr>
                <td colspan="1" colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>ansible_os_product_id</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>The Windows product ID.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">00326-10000-00000-AA698</div>
                </td>
            </tr>
            <tr>
                <td colspan="1" colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>ansible_os_product_key</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this fact"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>always</td>
                <td>
                            <div>The Windows product key.
                            </div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">T49TD-6VFBW-VV7HY-B2PXY-MY47H</div>
                </td>
            </tr>
    </table>
    <br/><br/>



Status
------


Authors
~~~~~~~

- Dag Wieers (@dagwieers)
