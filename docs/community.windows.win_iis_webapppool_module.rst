.. _community.windows.win_iis_webapppool_module:


************************************
community.windows.win_iis_webapppool
************************************

**Configure IIS Web Application Pools**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Creates, removes and configures an IIS Web Application Pool.




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
                    <b>attributes</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">-</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>This field is a free form dictionary value for the application pool attributes.</div>
                        <div>These attributes are based on the naming standard at <a href='https://www.iis.net/configreference/system.applicationhost/applicationpools/add#005'>https://www.iis.net/configreference/system.applicationhost/applicationpools/add#005</a>, see the examples section for more details on how to set this.</div>
                        <div>You can also set the attributes of child elements like cpu and processModel, see the examples to see how it is done.</div>
                        <div>While you can use the numeric values for enums it is recommended to use the enum name itself, e.g. use SpecificUser instead of 3 for processModel.identityType.</div>
                        <div>managedPipelineMode may be either &quot;Integrated&quot; or &quot;Classic&quot;.</div>
                        <div>startMode may be either &quot;OnDemand&quot; or &quot;AlwaysRunning&quot;.</div>
                        <div>Use <code>state</code> module parameter to modify the state of the app pool.</div>
                        <div>When trying to set &#x27;processModel.password&#x27; and you receive a &#x27;Value does fall within the expected range&#x27; error, you have a corrupted keystore. Please follow <a href='http://structuredsight.com/2014/10/26/im-out-of-range-youre-out-of-range/'>http://structuredsight.com/2014/10/26/im-out-of-range-youre-out-of-range/</a> to help fix your host.</div>
                </td>
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
                        <div>Name of the application pool.</div>
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
                                    <li>restarted</li>
                                    <li>started</li>
                                    <li>stopped</li>
                        </ul>
                </td>
                <td>
                        <div>The state of the application pool.</div>
                        <div>If <code>absent</code> will ensure the app pool is removed.</div>
                        <div>If <code>present</code> will ensure the app pool is configured and exists.</div>
                        <div>If <code>restarted</code> will ensure the app pool exists and will restart, this is never idempotent.</div>
                        <div>If <code>started</code> will ensure the app pool exists and is started.</div>
                        <div>If <code>stopped</code> will ensure the app pool exists and is stopped.</div>
                </td>
            </tr>
    </table>
    <br/>



See Also
--------

.. seealso::

   :ref:`community.windows.win_iis_virtualdirectory_module`
      The official documentation on the **community.windows.win_iis_virtualdirectory** module.
   :ref:`community.windows.win_iis_webapplication_module`
      The official documentation on the **community.windows.win_iis_webapplication** module.
   :ref:`community.windows.win_iis_webbinding_module`
      The official documentation on the **community.windows.win_iis_webbinding** module.
   :ref:`community.windows.win_iis_website_module`
      The official documentation on the **community.windows.win_iis_website** module.


Examples
--------

.. code-block:: yaml

    - name: Return information about an existing application pool
      community.windows.win_iis_webapppool:
        name: DefaultAppPool
        state: present

    - name: Create a new application pool in 'Started' state
      community.windows.win_iis_webapppool:
        name: AppPool
        state: started

    - name: Stop an application pool
      community.windows.win_iis_webapppool:
        name: AppPool
        state: stopped

    - name: Restart an application pool (non-idempotent)
      community.windows.win_iis_webapppool:
        name: AppPool
        state: restarted

    - name: Change application pool attributes using new dict style
      community.windows.win_iis_webapppool:
        name: AppPool
        attributes:
          managedRuntimeVersion: v4.0
          autoStart: no

    - name: Creates an application pool, sets attributes and starts it
      community.windows.win_iis_webapppool:
        name: AnotherAppPool
        state: started
        attributes:
          managedRuntimeVersion: v4.0
          autoStart: no

    # In the below example we are setting attributes in child element processModel
    # https://www.iis.net/configreference/system.applicationhost/applicationpools/add/processmodel
    - name: Manage child element and set identity of application pool
      community.windows.win_iis_webapppool:
        name: IdentitiyAppPool
        state: started
        attributes:
          managedPipelineMode: Classic
          processModel.identityType: SpecificUser
          processModel.userName: '{{ansible_user}}'
          processModel.password: '{{ansible_password}}'
          processModel.loadUserProfile: true

    - name: Manage a timespan attribute
      community.windows.win_iis_webapppool:
        name: TimespanAppPool
        state: started
        attributes:
          # Timespan with full string "day:hour:minute:second.millisecond"
          recycling.periodicRestart.time: "00:00:05:00.000000"
          recycling.periodicRestart.schedule: ["00:10:00", "05:30:00"]
          # Shortened timespan "hour:minute:second"
          processModel.pingResponseTime: "00:03:00"



Return Values
-------------
Common return values are documented `here <https://docs.ansible.com/ansible/latest/reference_appendices/common_return_values.html#common-return-values>`_, the following are the fields unique to this module:

.. raw:: html

    <table border=0 cellpadding=0 class="documentation-table">
        <tr>
            <th colspan="2">Key</th>
            <th>Returned</th>
            <th width="100%">Description</th>
        </tr>
            <tr>
                <td colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>attributes</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">dictionary</span>
                    </div>
                </td>
                <td>success</td>
                <td>
                            <div>Application Pool attributes that were set and processed by this module invocation.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">{&#x27;enable32BitAppOnWin64&#x27;: &#x27;true&#x27;, &#x27;managedRuntimeVersion&#x27;: &#x27;v4.0&#x27;, &#x27;managedPipelineMode&#x27;: &#x27;Classic&#x27;}</div>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>info</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">complex</span>
                    </div>
                </td>
                <td>success</td>
                <td>
                            <div>Information on current state of the Application Pool. See https://www.iis.net/configreference/system.applicationhost/applicationpools/add#005 for the full list of return attributes based on your IIS version.</div>
                    <br/>
                </td>
            </tr>
                                <tr>
                    <td class="elbow-placeholder">&nbsp;</td>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>attributes</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">dictionary</span>
                    </div>
                </td>
                <td>success</td>
                <td>
                            <div>Key value pairs showing the current Application Pool attributes.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">{&#x27;autoStart&#x27;: True, &#x27;managedRuntimeLoader&#x27;: &#x27;webengine4.dll&#x27;, &#x27;managedPipelineMode&#x27;: &#x27;Classic&#x27;, &#x27;name&#x27;: &#x27;DefaultAppPool&#x27;, &#x27;CLRConfigFile&#x27;: &#x27;&#x27;, &#x27;passAnonymousToken&#x27;: True, &#x27;applicationPoolSid&#x27;: &#x27;S-1-5-82-1352790163-598702362-1775843902-1923651883-1762956711&#x27;, &#x27;queueLength&#x27;: 1000, &#x27;managedRuntimeVersion&#x27;: &#x27;v4.0&#x27;, &#x27;state&#x27;: &#x27;Started&#x27;, &#x27;enableConfigurationOverride&#x27;: True, &#x27;startMode&#x27;: &#x27;OnDemand&#x27;, &#x27;enable32BitAppOnWin64&#x27;: True}</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder">&nbsp;</td>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>cpu</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">dictionary</span>
                    </div>
                </td>
                <td>success</td>
                <td>
                            <div>Key value pairs showing the current Application Pool cpu attributes.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">{&#x27;action&#x27;: &#x27;NoAction&#x27;, &#x27;limit&#x27;: 0, &#x27;resetInterval&#x27;: {&#x27;Days&#x27;: 0, &#x27;Hours&#x27;: 0}}</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder">&nbsp;</td>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>failure</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">dictionary</span>
                    </div>
                </td>
                <td>success</td>
                <td>
                            <div>Key value pairs showing the current Application Pool failure attributes.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">{&#x27;autoShutdownExe&#x27;: &#x27;&#x27;, &#x27;orphanActionExe&#x27;: &#x27;&#x27;, &#x27;rapidFailProtextionInterval&#x27;: {&#x27;Days&#x27;: 0, &#x27;Hours&#x27;: 0}}</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder">&nbsp;</td>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>name</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>success</td>
                <td>
                            <div>Name of Application Pool that was processed by this module invocation.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">DefaultAppPool</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder">&nbsp;</td>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>processModel</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">dictionary</span>
                    </div>
                </td>
                <td>success</td>
                <td>
                            <div>Key value pairs showing the current Application Pool processModel attributes.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">{&#x27;identityType&#x27;: &#x27;ApplicationPoolIdentity&#x27;, &#x27;logonType&#x27;: &#x27;LogonBatch&#x27;, &#x27;pingInterval&#x27;: {&#x27;Days&#x27;: 0, &#x27;Hours&#x27;: 0}}</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder">&nbsp;</td>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>recycling</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">dictionary</span>
                    </div>
                </td>
                <td>success</td>
                <td>
                            <div>Key value pairs showing the current Application Pool recycling attributes.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">{&#x27;disallowOverlappingRotation&#x27;: False, &#x27;disallowRotationOnConfigChange&#x27;: False, &#x27;logEventOnRecycle&#x27;: &#x27;Time,Requests,Schedule,Memory,IsapiUnhealthy,OnDemand,ConfigChange,PrivateMemory&#x27;}</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder">&nbsp;</td>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="return-"></div>
                    <b>state</b>
                    <a class="ansibleOptionLink" href="#return-" title="Permalink to this return value"></a>
                    <div style="font-size: small">
                      <span style="color: purple">string</span>
                    </div>
                </td>
                <td>success</td>
                <td>
                            <div>Current runtime state of the pool as the module completed.</div>
                    <br/>
                        <div style="font-size: smaller"><b>Sample:</b></div>
                        <div style="font-size: smaller; color: blue; word-wrap: break-word; word-break: break-all;">Started</div>
                </td>
            </tr>

    </table>
    <br/><br/>


Status
------


Authors
~~~~~~~

- Henrik Wallström (@henrikwallstrom)
- Jordan Borean (@jborean93)
