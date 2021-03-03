.. _community.windows.win_region_module:


****************************
community.windows.win_region
****************************

**Set the region and format settings**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Set the location settings of a Windows Server.
- Set the format settings of a Windows Server.
- Set the unicode language settings of a Windows Server.
- Copy across these settings to the default profile.




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
                    <b>copy_settings</b>
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
                        <div>This will copy the current format and location values to new user profiles and the welcome screen. This will only run if <code>location</code>, <code>format</code> or <code>unicode_language</code> has resulted in a change. If this process runs then it will always result in a change.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>format</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The language format to set for the current user, see <a href='https://msdn.microsoft.com/en-us/library/system.globalization.cultureinfo.aspx'>https://msdn.microsoft.com/en-us/library/system.globalization.cultureinfo.aspx</a> for a list of culture names to use.</div>
                        <div>This needs to be set if <code>location</code> or <code>unicode_language</code> is not set.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>location</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The location to set for the current user, see <a href='https://msdn.microsoft.com/en-us/library/dd374073.aspx'>https://msdn.microsoft.com/en-us/library/dd374073.aspx</a> for a list of GeoIDs you can use and what location it relates to.</div>
                        <div>This needs to be set if <code>format</code> or <code>unicode_language</code> is not set.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>unicode_language</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The unicode language format to set for all users, see <a href='https://msdn.microsoft.com/en-us/library/system.globalization.cultureinfo.aspx'>https://msdn.microsoft.com/en-us/library/system.globalization.cultureinfo.aspx</a> for a list of culture names to use.</div>
                        <div>This needs to be set if <code>location</code> or <code>format</code> is not set. After setting this value a reboot is required for it to take effect.</div>
                </td>
            </tr>
    </table>
    <br/>



See Also
--------

.. seealso::

   :ref:`community.windows.win_timezone_module`
      The official documentation on the **community.windows.win_timezone** module.


Examples
--------

.. code-block:: yaml

    - name: Set the region format to English United States
      community.windows.win_region:
        format: en-US

    - name: Set the region format to English Australia and copy settings to new profiles
      community.windows.win_region:
        format: en-AU
        copy_settings: yes

    - name: Set the location to United States
      community.windows.win_region:
        location: 244

    # Reboot when region settings change
    - name: Set the unicode language to English Great Britain, reboot if required
      community.windows.win_region:
        unicode_language: en-GB
      register: result

    - ansible.windows.win_reboot:
      when: result.restart_required

    # Reboot when format, location or unicode has changed
    - name: Set format, location and unicode to English Australia and copy settings, reboot if required
      community.windows.win_region:
        location: 12
        format: en-AU
        unicode_language: en-AU
      register: result

    - ansible.windows.win_reboot:
      when: result.restart_required



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
                    <b>restart_required</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">boolean</span>
                    </div>
                </td>
                <td>success</td>
                <td>
                            <div>Whether a reboot is required for the change to take effect.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">True</div>
                </td>
            </tr>
    </table>
    <br/><br/>


Status
------


Authors
~~~~~~~

- Jordan Borean (@jborean93)
