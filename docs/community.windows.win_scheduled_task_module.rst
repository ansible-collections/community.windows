.. _community.windows.win_scheduled_task_module:


************************************
community.windows.win_scheduled_task
************************************

**Manage scheduled tasks**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Creates/modifies or removes Windows scheduled tasks.




Parameters
----------

.. raw:: html

    <table  border=0 cellpadding=0 class="documentation-table">
        <tr>
            <th colspan="3">Parameter</th>
            <th>Choices/<font color="blue">Defaults</font></th>
            <th width="100%">Comments</th>
        </tr>
            <tr>
                <td colspan="3">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>actions</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">list</span>
                         / <span style="color: purple">elements=dictionary</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>A list of action to configure for the task.</div>
                        <div>See suboptions for details on how to construct each list entry.</div>
                        <div>When creating a task there MUST be at least one action but when deleting a task this can be a null or an empty list.</div>
                        <div>The ordering of this list is important, the module will ensure the order is kept when modifying the task.</div>
                        <div>This module only supports the <code>ExecAction</code> type but can still delete the older legacy types.</div>
                </td>
            </tr>
                                <tr>
                    <td class="elbow-placeholder"></td>
                <td colspan="2">
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
                        <div>An argument string to supply for the executable.</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                <td colspan="2">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>path</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                         / <span style="color: red">required</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The path to the executable for the ExecAction.</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                <td colspan="2">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>working_directory</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The working directory to run the executable from.</div>
                </td>
            </tr>

            <tr>
                <td colspan="3">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>allow_demand_start</b>
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
                        <div>Whether the task can be started by using either the Run command or the Context menu.</div>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>allow_hard_terminate</b>
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
                        <div>Whether the task can be terminated by using TerminateProcess.</div>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>author</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The author of the task.</div>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>compatibility</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>0</li>
                                    <li>1</li>
                                    <li>2</li>
                                    <li>3</li>
                                    <li>4</li>
                        </ul>
                </td>
                <td>
                        <div>The integer value with indicates which version of Task Scheduler a task is compatible with.</div>
                        <div><code>0</code> means the task is compatible with the AT command.</div>
                        <div><code>1</code> means the task is compatible with Task Scheduler 1.0(Windows Vista, Windows Server 2008 and older).</div>
                        <div><code>2</code> means the task is compatible with Task Scheduler 2.0(Windows Vista, Windows Server 2008).</div>
                        <div><code>3</code> means the task is compatible with Task Scheduler 2.0(Windows 7, Windows Server 2008 R2).</div>
                        <div><code>4</code> means the task is compatible with Task Scheduler 2.0(Windows 10, Windows Server 2016, Windows Server 2019).</div>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>date</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The date when the task was registered.</div>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>delete_expired_task_after</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The amount of time that the Task Scheduler will wait before deleting the task after it expires.</div>
                        <div>A task expires after the end_boundary has been exceeded for all triggers associated with the task.</div>
                        <div>This is in the ISO 8601 Duration format <code>P[n]Y[n]M[n]DT[n]H[n]M[n]S</code>.</div>
                </td>
            </tr>
            <tr>
                <td colspan="3">
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
                        <div>The description of the task.</div>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>disallow_start_if_on_batteries</b>
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
                        <div>Whether the task will not be started if the computer is running on battery power.</div>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>display_name</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The name of the user/group that is displayed in the Task Scheduler UI.</div>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>enabled</b>
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
                        <div>Whether the task is enabled, the task can only run when <code>yes</code>.</div>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>execution_time_limit</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The amount of time allowed to complete the task.</div>
                        <div>When set to `PT0S`, the time limit is infinite.</div>
                        <div>When omitted, the default time limit is 72 hours.</div>
                        <div>This is in the ISO 8601 Duration format <code>P[n]Y[n]M[n]DT[n]H[n]M[n]S</code>.</div>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>group</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The group that will run the task.</div>
                        <div><code>group</code> and <code>username</code> are exclusive to each other and cannot be set at the same time.</div>
                        <div><code>logon_type</code> can either be not set or equal <code>group</code>.</div>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>hidden</b>
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
                        <div>Whether the task will be hidden in the UI.</div>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>logon_type</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>none</li>
                                    <li>password</li>
                                    <li>s4u</li>
                                    <li>interactive_token</li>
                                    <li>group</li>
                                    <li>service_account</li>
                                    <li>token_or_password</li>
                        </ul>
                </td>
                <td>
                        <div>The logon method that the task will run with.</div>
                        <div><code>password</code> means the password will be stored and the task has access to network resources.</div>
                        <div><code>s4u</code> means the existing token will be used to run the task and no password will be stored with the task. Means no network or encrypted files access.</div>
                        <div><code>interactive_token</code> means the user must already be logged on interactively and will run in an existing interactive session.</div>
                        <div><code>group</code> means that the task will run as a group.</div>
                        <div><code>service_account</code> means that a service account like System, Local Service or Network Service will run the task.</div>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>multiple_instances</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>0</li>
                                    <li>1</li>
                                    <li>2</li>
                                    <li>3</li>
                        </ul>
                </td>
                <td>
                        <div>An integer that indicates the behaviour when starting a task that is already running.</div>
                        <div><code>0</code> will start a new instance in parallel with existing instances of that task.</div>
                        <div><code>1</code> will wait until other instances of that task to finish running before starting itself.</div>
                        <div><code>2</code> will not start a new instance if another is running.</div>
                        <div><code>3</code> will stop other instances of the task and start the new one.</div>
                </td>
            </tr>
            <tr>
                <td colspan="3">
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
                        <div>The name of the scheduled task without the path.</div>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>password</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The password for the user account to run the scheduled task as.</div>
                        <div>This is required when running a task without the user being logged in, excluding the builtin service accounts and Group Managed Service Accounts (gMSA).</div>
                        <div>If set, will always result in a change unless <code>update_password</code> is set to <code>no</code> and no other changes are required for the service.</div>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>path</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <b>Default:</b><br/><div style="color: blue">"\\"</div>
                </td>
                <td>
                        <div>Task folder in which this task will be stored.</div>
                        <div>Will create the folder when <code>state=present</code> and the folder does not already exist.</div>
                        <div>Will remove the folder when <code>state=absent</code> and there are no tasks left in the folder.</div>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>priority</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The priority level (0-10) of the task.</div>
                        <div>When creating a new task the default is <code>7</code>.</div>
                        <div>See <a href='https://msdn.microsoft.com/en-us/library/windows/desktop/aa383512.aspx'>https://msdn.microsoft.com/en-us/library/windows/desktop/aa383512.aspx</a> for details on the priority levels.</div>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>restart_count</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The number of times that the Task Scheduler will attempt to restart the task.</div>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>restart_interval</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>How long the Task Scheduler will attempt to restart the task.</div>
                        <div>If this is set then <code>restart_count</code> must also be set.</div>
                        <div>The maximum allowed time is 31 days.</div>
                        <div>The minimum allowed time is 1 minute.</div>
                        <div>This is in the ISO 8601 Duration format <code>P[n]Y[n]M[n]DT[n]H[n]M[n]S</code>.</div>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>run_level</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>limited</li>
                                    <li>highest</li>
                        </ul>
                </td>
                <td>
                        <div>The level of user rights used to run the task.</div>
                        <div>If not specified the task will be created with limited rights.</div>
                        <div style="font-size: small; color: darkgreen"><br/>aliases: runlevel</div>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>run_only_if_idle</b>
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
                        <div>Whether the task will run the task only if the computer is in an idle state.</div>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>run_only_if_network_available</b>
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
                        <div>Whether the task will run only when a network is available.</div>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>source</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The source of the task.</div>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>start_when_available</b>
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
                        <div>Whether the task can start at any time after its scheduled time has passed.</div>
                </td>
            </tr>
            <tr>
                <td colspan="3">
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
                        <div>When <code>state=present</code> will ensure the task exists.</div>
                        <div>When <code>state=absent</code> will ensure the task does not exist.</div>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>stop_if_going_on_batteries</b>
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
                        <div>Whether the task will be stopped if the computer begins to run on battery power.</div>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>triggers</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">list</span>
                         / <span style="color: purple">elements=dictionary</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>A list of triggers to configure for the task.</div>
                        <div>See suboptions for details on how to construct each list entry.</div>
                        <div>The ordering of this list is important, the module will ensure the order is kept when modifying the task.</div>
                        <div>There are multiple types of triggers, see <a href='https://msdn.microsoft.com/en-us/library/windows/desktop/aa383868.aspx'>https://msdn.microsoft.com/en-us/library/windows/desktop/aa383868.aspx</a> for a list of trigger types and their options.</div>
                        <div>The suboption options listed below are not required for all trigger types, read the description for more details.</div>
                </td>
            </tr>
                                <tr>
                    <td class="elbow-placeholder"></td>
                <td colspan="2">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>days_of_month</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The days of the month from 1 to 31 for the triggers.</div>
                        <div>If you wish to set the trigger for the last day of any month use <code>run_on_last_day_of_month</code>.</div>
                        <div>Can be a list or comma separated string of day numbers.</div>
                        <div>Required when <code>type=monthly</code>.</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                <td colspan="2">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>days_of_week</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The days of the week for the trigger.</div>
                        <div>Can be a list or comma separated string of full day names e.g. monday instead of mon.</div>
                        <div>Required when <code>type</code> is <code>weekly</code>.</div>
                        <div>Optional when <code>type=monthlydow</code>.</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                <td colspan="2">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>delay</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The time to delay the task from running once the trigger has been fired.</div>
                        <div>Optional when <code>type</code> is <code>boot</code>, <code>event</code>, <code>logon</code>, <code>registration</code>, <code>session_state_change</code>.</div>
                        <div>Is in the ISO 8601 Duration format <code>P[n]Y[n]M[n]DT[n]H[n]M[n]S</code>.</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                <td colspan="2">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>enabled</b>
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
                        <div>Whether to set the trigger to enabled or disabled</div>
                        <div>Used in all trigger types.</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                <td colspan="2">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>end_boundary</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The end time for when the trigger is deactivated.</div>
                        <div>This is in ISO 8601 DateTime format <code>YYYY-MM-DDThh:mm:ss</code>.</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                <td colspan="2">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>execution_time_limit</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The maximum amount of time that the task is allowed to run for.</div>
                        <div>Optional for all the trigger types.</div>
                        <div>Is in the ISO 8601 Duration format <code>P[n]Y[n]M[n]DT[n]H[n]M[n]S</code>.</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                <td colspan="2">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>months_of_year</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The months of the year for the trigger.</div>
                        <div>Can be a list or comma separated string of full month names e.g. march instead of mar.</div>
                        <div>Optional when <code>type</code> is <code>monthlydow</code>, <code>monthly</code>.</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                <td colspan="2">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>random_delay</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The delay time that is randomly added to the start time of the trigger.</div>
                        <div>Optional when <code>type</code> is <code>daily</code>, <code>monthlydow</code>, <code>monthly</code>, <code>time</code>, <code>weekly</code>.</div>
                        <div>Is in the ISO 8601 Duration format <code>P[n]Y[n]M[n]DT[n]H[n]M[n]S</code>.</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                <td colspan="2">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>repetition</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">-</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Allows you to define the repetition action of the trigger that defines how often the task is run and how long the repetition pattern is repeated after the task is started.</div>
                        <div>It takes in the following keys, <code>duration</code>, <code>interval</code>, <code>stop_at_duration_end</code></div>
                </td>
            </tr>
                                <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>duration</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Defines how long the pattern is repeated.</div>
                        <div>The value is in the ISO 8601 Duration format <code>P[n]Y[n]M[n]DT[n]H[n]M[n]S</code>.</div>
                        <div>By default this is not set which means it will repeat indefinitely.</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>interval</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The amount of time between each restart of the task.</div>
                        <div>The value is written in the ISO 8601 Duration format <code>P[n]Y[n]M[n]DT[n]H[n]M[n]S</code>.</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                    <td class="elbow-placeholder"></td>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>stop_at_duration_end</b>
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
                        <div>Whether a running instance of the task is stopped at the end of the repetition pattern.</div>
                </td>
            </tr>

            <tr>
                    <td class="elbow-placeholder"></td>
                <td colspan="2">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>run_on_last_day_of_month</b>
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
                        <div>Boolean value that sets whether the task runs on the last day of the month.</div>
                        <div>Optional when <code>type</code> is <code>monthly</code>.</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                <td colspan="2">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>run_on_last_week_of_month</b>
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
                        <div>Boolean value that sets whether the task runs on the last week of the month.</div>
                        <div>Optional when <code>type</code> is <code>monthlydow</code>.</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                <td colspan="2">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>start_boundary</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The start time for the task, even if the trigger meets the other start criteria, it won&#x27;t start until this time is met.</div>
                        <div>If you wish to run a task at 9am on a day you still need to specify the date on which the trigger is activated, you can set any date even ones in the past.</div>
                        <div>Required when <code>type</code> is <code>daily</code>, <code>monthlydow</code>, <code>monthly</code>, <code>time</code>, <code>weekly</code>.</div>
                        <div>Optional for the rest of the trigger types.</div>
                        <div>This is in ISO 8601 DateTime format <code>YYYY-MM-DDThh:mm:ss</code>.</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                <td colspan="2">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>state_change</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                    <div style="font-style: italic; font-size: small; color: darkgreen">added in 1.6.0</div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>console_connect</li>
                                    <li>console_disconnect</li>
                                    <li>remote_connect</li>
                                    <li>remote_disconnect</li>
                                    <li>session_lock</li>
                                    <li>session_unlock</li>
                        </ul>
                </td>
                <td>
                        <div>Allows you to define the kind of Terminal Server session change that triggers a task.</div>
                        <div>Optional when <code>type=session_state_change</code></div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                <td colspan="2">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>subscription</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Only used and is required for <code>type=event</code>.</div>
                        <div>The XML query string that identifies the event that fires the trigger.</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                <td colspan="2">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>type</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                         / <span style="color: red">required</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>boot</li>
                                    <li>daily</li>
                                    <li>event</li>
                                    <li>idle</li>
                                    <li>logon</li>
                                    <li>monthlydow</li>
                                    <li>monthly</li>
                                    <li>registration</li>
                                    <li>time</li>
                                    <li>weekly</li>
                                    <li>session_state_change</li>
                        </ul>
                </td>
                <td>
                        <div>The trigger type, this value controls what below options are required.</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                <td colspan="2">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>user_id</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The username that the trigger will target.</div>
                        <div>Optional when <code>type</code> is <code>logon</code>, <code>session_state_change</code>.</div>
                        <div>Can be the username or SID of a user.</div>
                        <div>When <code>type=logon</code> and you want the trigger to fire when a user in a group logs on, leave this as null and set <code>group</code> to the group you wish to trigger.</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                <td colspan="2">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>weeks_interval</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The interval of weeks to run on, e.g. <code>1</code> means every week while <code>2</code> means every other week.</div>
                        <div>Optional when <code>type=weekly</code>.</div>
                </td>
            </tr>
            <tr>
                    <td class="elbow-placeholder"></td>
                <td colspan="2">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>weeks_of_month</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The weeks of the month for the trigger.</div>
                        <div>Can be a list or comma separated string of the numbers 1 to 4 representing the first to 4th week of the month.</div>
                        <div>Optional when <code>type=monthlydow</code>.</div>
                </td>
            </tr>

            <tr>
                <td colspan="3">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>update_password</b>
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
                        <div>Whether to update the password even when not other changes have occurred.</div>
                        <div>When <code>yes</code> will always result in a change when executing the module.</div>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>username</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The user to run the scheduled task as.</div>
                        <div>Will default to the current user under an interactive token if not specified during creation.</div>
                        <div>The user account specified must have the <code>SeBatchLogonRight</code> logon right which can be added with <span class='module'>ansible.windows.win_user_right</span>.</div>
                        <div style="font-size: small; color: darkgreen"><br/>aliases: user</div>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>version</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The version number of the task.</div>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>wake_to_run</b>
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
                        <div>Whether the task will wake the computer when it is time to run the task.</div>
                </td>
            </tr>
    </table>
    <br/>


Notes
-----

.. note::
   - The option names and structure for actions and triggers of a service follow the ``RegisteredTask`` naming standard and requirements, it would be useful to read up on this guide if coming across any issues https://msdn.microsoft.com/en-us/library/windows/desktop/aa382542.aspx.
   - A Group Managed Service Account (gMSA) can be used by setting ``logon_type`` to ``password`` and omitting the password parameter. For more information on gMSAs, see https://techcommunity.microsoft.com/t5/Core-Infrastructure-and-Security/Windows-Server-2012-Group-Managed-Service-Accounts/ba-p/255910


See Also
--------

.. seealso::

   :ref:`community.windows.win_scheduled_task_stat_module`
      The official documentation on the **community.windows.win_scheduled_task_stat** module.
   :ref:`ansible.windows.win_user_right_module`
      The official documentation on the **ansible.windows.win_user_right** module.


Examples
--------

.. code-block:: yaml

    - name: Create a task to open 2 command prompts as SYSTEM
      community.windows.win_scheduled_task:
        name: TaskName
        description: open command prompt
        actions:
        - path: cmd.exe
          arguments: /c hostname
        - path: cmd.exe
          arguments: /c whoami
        triggers:
        - type: daily
          start_boundary: '2017-10-09T09:00:00'
        username: SYSTEM
        state: present
        enabled: yes

    - name: Create task to run a PS script as NETWORK service on boot
      community.windows.win_scheduled_task:
        name: TaskName2
        description: Run a PowerShell script
        actions:
        - path: C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
          arguments: -ExecutionPolicy Unrestricted -NonInteractive -File C:\TestDir\Test.ps1
        triggers:
        - type: boot
        username: NETWORK SERVICE
        run_level: highest
        state: present

    - name: Update Local Security Policy to allow users to run scheduled tasks
      ansible.windows.win_user_right:
        name: SeBatchLogonRight
        users:
        - LocalUser
        - DOMAIN\NetworkUser
        action: add

    - name: Change above task to run under a domain user account, storing the passwords
      community.windows.win_scheduled_task:
        name: TaskName2
        username: DOMAIN\User
        password: Password
        logon_type: password

    - name: Change the above task again, choosing not to store the password
      community.windows.win_scheduled_task:
        name: TaskName2
        username: DOMAIN\User
        logon_type: s4u

    - name: Change above task to use a gMSA, where the password is managed automatically
      community.windows.win_scheduled_task:
        name: TaskName2
        username: DOMAIN\gMsaSvcAcct$
        logon_type: password

    - name: Create task with multiple triggers
      community.windows.win_scheduled_task:
        name: TriggerTask
        path: \Custom
        actions:
        - path: cmd.exe
        triggers:
        - type: daily
        - type: monthlydow
        username: SYSTEM

    - name: Set logon type to password but don't force update the password
      community.windows.win_scheduled_task:
        name: TriggerTask
        path: \Custom
        actions:
        - path: cmd.exe
        username: Administrator
        password: password
        update_password: no

    - name: Disable a task that already exists
      community.windows.win_scheduled_task:
        name: TaskToDisable
        enabled: no

    - name: Create a task that will be repeated every minute for five minutes
      community.windows.win_scheduled_task:
        name: RepeatedTask
        description: open command prompt
        actions:
        - path: cmd.exe
          arguments: /c hostname
        triggers:
        - type: registration
          repetition:
            interval: PT1M
            duration: PT5M
            stop_at_duration_end: yes

    - name: Create task to run a PS script in Windows 10 compatibility on boot with a delay of 1min
      community.windows.win_scheduled_task:
        name: TriggerTask
        path: \Custom
        actions:
        - path: C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
          arguments: -ExecutionPolicy Unrestricted -NonInteractive -File C:\TestDir\Test.ps1
        triggers:
        - type: boot
          delay: PT1M
        username: SYSTEM
        compatibility: 4




Status
------


Authors
~~~~~~~

- Peter Mounce (@petemounce)
- Jordan Borean (@jborean93)
