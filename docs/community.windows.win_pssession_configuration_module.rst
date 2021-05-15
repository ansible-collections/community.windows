.. _community.windows.win_pssession_configuration_module:


*********************************************
community.windows.win_pssession_configuration
*********************************************

**Manage PSSession Configurations**



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- Register, unregister, and modify PSSession Configurations for PowerShell remoting.




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
                    <b>access_mode</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>disabled</li>
                                    <li>local</li>
                                    <li>remote</li>
                        </ul>
                </td>
                <td>
                        <div>Controls whether the session configuration allows connection from the <code>local</code> machine only, both local and <code>remote</code>, or none (<code>disabled</code>).</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>alias_definitions</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">dictionary</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>A dict that defines aliases for each session.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>assemblies_to_load</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">list</span>
                         / <span style="color: purple">elements=string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The assemblies that should be loaded into each session.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>async_poll</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>
                        <b>Default:</b><br/><div style="color: blue">1</div>
                </td>
                <td>
                        <div>Sets a delay in seconds between each check of the asynchronous execution status.</div>
                        <div>Replicates the functionality of the <code>poll</code> keyword.</div>
                        <div>Has no effect in check mode.</div>
                        <div><em>async_poll=0</em> is not supported.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>async_timeout</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">integer</span>
                    </div>
                </td>
                <td>
                        <b>Default:</b><br/><div style="color: blue">300</div>
                </td>
                <td>
                        <div>Sets a timeout for how long in seconds to wait for asynchronous module execution and waiting for the connection to recover.</div>
                        <div>Replicates the functionality of the <code>async</code> keyword.</div>
                        <div>Has no effect in check mode.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
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
                        <div>The author of the session configuration.</div>
                        <div>This value is metadata and does not affect the functionality of the session configuration.</div>
                        <div>If not set, a value may be generated automatically.</div>
                        <div>See also <em>lenient_config_fields</em>.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>company_name</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The company that authored the session configuration.</div>
                        <div>This value is metadata and does not affect the functionality of the session configuration.</div>
                        <div>If not set, a value may be generated automatically.</div>
                        <div>See also <em>lenient_config_fields</em>.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>copyright</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The copyright statement of the session configuration.</div>
                        <div>This value is metadata and does not affect the functionality of the session configuration.</div>
                        <div>If not set, a value may be generated automatically.</div>
                        <div>See also <em>lenient_config_fields</em>.</div>
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
                        <div>The description of the session configuration.</div>
                        <div>This value is metadata and does not affect the functionality of the session configuration.</div>
                        <div>See also <em>lenient_config_fields</em>.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>environment_variables</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">dictionary</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>A dict that defines environment variables for each session.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>execution_policy</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>default</li>
                                    <li>remote_signed</li>
                                    <li>restricted</li>
                                    <li>undefined</li>
                                    <li>unrestricted</li>
                        </ul>
                </td>
                <td>
                        <div>The execution policy controlling script execution in the PowerShell session.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>formats_to_process</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">list</span>
                         / <span style="color: purple">elements=path</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Paths to format definition files to process for each session.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>function_definitions</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">dictionary</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>A dict that defines functions for each session.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>group_managed_service_account</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>If the session will run as a group managed service account (gMSA) then this is the name.</div>
                        <div>Do not use <em>run_as_credential_username</em> and <em>run_as_credential_password</em> to specify a gMSA.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>guid</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">raw</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The GUID (UUID) of the session configuration file.</div>
                        <div>This value is metadata, so it only matters if you use it externally.</div>
                        <div>If not set, a value will be generated automatically.</div>
                        <div>Acceptable GUID formats are flexible. Any string of 32 hexadecimal digits will be accepted, with all hyphens <code>-</code> and opening/closing <code>{}</code> ignored.</div>
                        <div>See also <em>lenient_config_fields</em>.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>language_mode</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>no_language</li>
                                    <li>restricted_language</li>
                                    <li>constrained_language</li>
                                    <li>full_language</li>
                        </ul>
                </td>
                <td>
                        <div>Determines the language mode of the PowerShell session.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>lenient_config_fields</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">list</span>
                         / <span style="color: purple">elements=string</span>
                    </div>
                </td>
                <td>
                        <b>Default:</b><br/><div style="color: blue">["guid", "author", "company_name", "copyright", "description"]</div>
                </td>
                <td>
                        <div>Some fields used in the session configuration do not affect its function, and are sometimes auto-generated when not specified.</div>
                        <div>To avoid unnecessarily changing the configuration on each run, the values of these options will only be enforced when they are explicitly specified.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>maximum_received_data_size_per_command_mb</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">raw</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Sets the maximum received data size per command in MB.</div>
                        <div>Must fit into a double precision floating point value.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>maximum_received_object_size_mb</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">raw</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Sets the maximum object size in MB.</div>
                        <div>Must fit into a double precision floating point value.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>modules_to_import</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">list</span>
                         / <span style="color: purple">elements=raw</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>A list of modules that should be imported into the session.</div>
                        <div>Any valid PowerShell module spec can be used here, so simple str names or dicts can be used.</div>
                        <div>If a dict is used, no snake_case conversion is done, so the original PowerShell names must be used.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>mount_user_drive</b>
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
                        <div>If <code>yes</code> the session creates and mounts a user-specific PSDrive for use with file transfers.</div>
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
                        <div>The name of the session configuration to manage.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>powershell_version</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">raw</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The minimum required PowerShell version for this session.</div>
                        <div>Must be a valid .Net System.Version string.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>processor_architecure</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>amd64</li>
                                    <li>x86</li>
                        </ul>
                </td>
                <td>
                        <div>The processor architecture of the session (32 bit vs. 64 bit).</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>required_groups</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">dictionary</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>For JEA sessions, defines conditional access rules about which groups a connecting user must belong to.</div>
                        <div>For more information see <a href='https://docs.microsoft.com/en-us/powershell/scripting/learn/remoting/jea/session-configurations#conditional-access-rules'>https://docs.microsoft.com/en-us/powershell/scripting/learn/remoting/jea/session-configurations#conditional-access-rules</a>.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>role_definitions</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">dictionary</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>A dict defining the roles for JEA sessions.</div>
                        <div>For more information see <a href='https://docs.microsoft.com/en-us/powershell/scripting/learn/remoting/jea/session-configurations#role-definitions'>https://docs.microsoft.com/en-us/powershell/scripting/learn/remoting/jea/session-configurations#role-definitions</a>.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>run_as_credential_password</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The password for <em>run_as_credential_username</em>.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>run_as_credential_username</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Used to set a RunAs account for the session. All commands executed in the session will be run as this user.</div>
                        <div>To use a gMSA, see <em>group_managed_service_account</em>.</div>
                        <div>To use a virtual account, see <em>run_as_virtual_account</em> and <em>run_as_virtual_account_groups</em>.</div>
                        <div>Status will always be <code>changed</code> when a RunAs credential is set because the password cannot be retrieved for comparison.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>run_as_virtual_account</b>
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
                        <div>If <code>yes</code> the session runs as a virtual account.</div>
                        <div>Do not use <em>run_as_credential_username</em> and <em>run_as_credential_password</em> to specify a virtual account.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>run_as_virtual_account_groups</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">list</span>
                         / <span style="color: purple">elements=string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>If <em>run_as_virtual_account=yes</em> this is a list of groups to add the virtual account to.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>schema_version</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">raw</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The schema version of the session configuration file.</div>
                        <div>If not set, a value will be generated automatically.</div>
                        <div>Must be a valid .Net System.Version string.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>scripts_to_process</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">list</span>
                         / <span style="color: purple">elements=string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>A list of paths to script files ending in <code>.ps1</code> that should be applied to the session.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>security_descriptor_sddl</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>An SDDL string that controls which users and groups can connect to the session.</div>
                        <div>If <em>role_definitions</em> is specified the security descriptor will be set based on that.</div>
                        <div>If this option is not specified the default security descriptor will be applied.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>session_type</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>default</li>
                                    <li>empty</li>
                                    <li>restricted_remote_server</li>
                        </ul>
                </td>
                <td>
                        <div>Controls what type of session this is.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>startup_script</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">path</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>A script that gets run on session startup.</div>
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
                                    <li><div style="color: blue"><b>present</b>&nbsp;&larr;</div></li>
                                    <li>absent</li>
                        </ul>
                </td>
                <td>
                        <div>The desired state of the configuration.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>thread_apartment_state</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>mta</li>
                                    <li>sta</li>
                        </ul>
                </td>
                <td>
                        <div>The apartment state for the PowerShell session.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>thread_options</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">string</span>
                    </div>
                </td>
                <td>
                        <ul style="margin: 0; padding: 0"><b>Choices:</b>
                                    <li>default</li>
                                    <li>reuse_thread</li>
                                    <li>use_current_thread</li>
                                    <li>use_new_thread</li>
                        </ul>
                </td>
                <td>
                        <div>Sets thread options for the session.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>transcript_directory</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">path</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Automatic session transcripts will be written to this directory.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>types_to_process</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">list</span>
                         / <span style="color: purple">elements=path</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>Paths to type definition files to process for each session.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>use_shared_process</b>
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
                        <div>If <code>yes</code> then the session shares a process for each session.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>user_drive_maximum_size</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">raw</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The maximum size of the user drive in bytes.</div>
                        <div>Must fit into an Int64.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>variable_definitions</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">list</span>
                         / <span style="color: purple">elements=dictionary</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>A list of dicts where each elements defines a variable for each session.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>visible_aliases</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">list</span>
                         / <span style="color: purple">elements=string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The aliases that can be used in the session.</div>
                        <div>For more information see <a href='https://docs.microsoft.com/en-us/powershell/scripting/learn/remoting/jea/role-capabilities'>https://docs.microsoft.com/en-us/powershell/scripting/learn/remoting/jea/role-capabilities</a>.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>visible_cmdlets</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">list</span>
                         / <span style="color: purple">elements=raw</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The cmdlets that can be used in the session.</div>
                        <div>The elements can be simple names or complex command specifications.</div>
                        <div>For more information see <a href='https://docs.microsoft.com/en-us/powershell/scripting/learn/remoting/jea/role-capabilities'>https://docs.microsoft.com/en-us/powershell/scripting/learn/remoting/jea/role-capabilities</a>.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>visible_external_commands</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">list</span>
                         / <span style="color: purple">elements=string</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The external commands and scripts that can be used in the session.</div>
                        <div>For more information see <a href='https://docs.microsoft.com/en-us/powershell/scripting/learn/remoting/jea/role-capabilities'>https://docs.microsoft.com/en-us/powershell/scripting/learn/remoting/jea/role-capabilities</a>.</div>
                </td>
            </tr>
            <tr>
                <td colspan="1">
                    <div class="ansibleOptionAnchor" id="parameter-"></div>
                    <b>visible_functions</b>
                    <a class="ansibleOptionLink" href="#parameter-" title="Permalink to this option"></a>
                    <div style="font-size: small">
                        <span style="color: purple">list</span>
                         / <span style="color: purple">elements=raw</span>
                    </div>
                </td>
                <td>
                </td>
                <td>
                        <div>The functions that can be used in the session.</div>
                        <div>The elements can be simple names or complex command specifications.</div>
                        <div>For more information see <a href='https://docs.microsoft.com/en-us/powershell/scripting/learn/remoting/jea/role-capabilities'>https://docs.microsoft.com/en-us/powershell/scripting/learn/remoting/jea/role-capabilities</a>.</div>
                </td>
            </tr>
    </table>
    <br/>


Notes
-----

.. note::
   - This module will restart the WinRM service on any change. This will terminate all WinRM connections including those by other Ansible runs.
   - Internally this module uses ``async`` when not in check mode to ensure things go smoothly when restarting the WinRM service.
   - The standard ``async`` and ``poll`` keywords cannot be used; instead use the *async_timeout* and *async_poll* options to control asynchronous execution.
   - Options that don't list a default value here will use the defaults of ``New-PSSessionConfigurationFile`` and ``Register-PSSessionConfiguration``.
   - If a value can be specified in both a session config file and directly in the session options, this module will prefer the setting be in the config file.


See Also
--------

.. seealso::

   `C(New-PSSessionConfigurationFile) Reference <https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/new-pssessionconfigurationfile>`_
       Details and defaults for options that end up in the session configuration file.
   `C(Register-PSSessionConfiguration) Reference <https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/register-pssessionconfiguration>`_
       Details and defaults for options that are not specified in the session config file.
   `PowerShell Just Enough Administration (JEA) <https://docs.microsoft.com/en-us/powershell/scripting/learn/remoting/jea/overview>`_
       Refer to the JEA documentation for advanced usage of some options
   `About Session Configurations <https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_session_configurations>`_
       General information about session configurations.
   `About Session Configuration Files <https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_session_configuration_files>`_
       General information about session configuration files.


Examples
--------

.. code-block:: yaml

    - name: Register a session configuration that loads modules automatically
      community.windows.win_pssession_configuration:
        name: WebAdmin
        modules_to_import:
          - WebAdministration
          - IISAdministration
        description: This endpoint has IIS modules pre-loaded

    - name: Set up an admin endpoint with a restricted execution policy
      community.windows.win_pssession_configuration:
        name: GloboCorp.Admin
        company_name: Globo Corp
        description: Admin Endpoint
        execution_policy: restricted

    - name: Create a complex JEA endpoint
      community.windows.win_pssession_configuration:
        name: RBAC.Endpoint
        session_type: restricted_remote_server
        run_as_virtual_account: True
        transcript_directory: '\\server\share\Transcripts'
        language_mode: no_language
        execution_policy: restricted
        role_definitions:
          'CORP\IT Support':
            RoleCapabilities:
              - PasswordResetter
              - EmployeeOffboarder
          'CORP\Webhosts':
            RoleCapabilities: IISAdmin
        visible_functions:
          - tabexpansion2
          - help
        visible_cmdlets:
          - Get-Help
          - Name: Get-Service
            Parameters:
              - Name: DependentServices
              - Name: RequiredServices
              - Name: Name
                ValidateSet:
                  - WinRM
                  - W3SVC
                  - WAS
        visible_aliases:
          - gsv
        state: present

    - name: Remove a session configuration
      community.windows.win_pssession_configuration:
        name: UnusedEndpoint
        state: absent

    - name: Set a sessions configuration with tweaked async values
      community.windows.win_pssession_configuration:
        name: MySession
        description: A sample session
        async_timeout: 500
        async_poll: 5




Status
------


Authors
~~~~~~~

- Brian Scholer (@briantist)
