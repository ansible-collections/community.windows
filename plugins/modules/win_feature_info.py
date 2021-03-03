#!/usr/bin/python
# -*- coding: utf-8 -*-

# Copyright: (c) 2020, Ansible Project
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

DOCUMENTATION = r'''
---
module: win_feature_info
short_description: Gather information about Windows features
description:
- Gather information about all or a specific installed Windows feature(s).
options:
  name:
    description:
    - If specified, this is used to match the C(name) of the Windows feature to get the info for.
    - Can be a wildcard to match multiple features but the wildcard will only be matched on the C(name) of the feature.
    - If omitted then all features will returned.
    type: str
    default: '*'
seealso:
- module: ansible.windows.win_feature
author:
- Larry Lane (@gamethis)
'''

EXAMPLES = r'''
- name: Get info for all installed features
  community.windows.win_feature_info:
  register: feature_info
- name: Get info for a single feature
  community.windows.win_feature_info:
    name: DNS
  register: feature_info
- name: Find all features that start with 'FS'
  ansible.windows.win_feature_info:
    name: FS*
'''

RETURN = r'''
exists:
  description: Whether any features were found based on the criteria specified.
  returned: always
  type: bool
  sample: true
features:
  description:
  - A list of feature(s) that were found based on the criteria.
  - Will be an empty list if no features were found.
  returned: always
  type: list
  elements: dict
  contains:
    name:
      description:
      - Name of feature found.
      type: str
      sample: AD-Certificate
    display_name:
      description:
      - The Display name of feature found.
      type: str
      sample: Active Directory Certificate Services
    description:
      description:
      - The description of the feature.
      type: str
      sample: Example description of the Windows feature.
    installed:
      description:
      - Whether the feature by C(name) is installed.
      type: bool
      sample: false
    install_state:
      description:
      - The Install State of C(name).
      - Values will be one of C(Available), C(Removed), C(Installed).
      type: str
      sample: Installed
    feature_type:
      description:
      - The Feature Type of C(name).
      - Values will be one of C(Role), C(Role Service), C(Feature).
      type: str
      sample: Feature
    path:
      description:
      - The Path of C(name) feature.
      type: str
      sample: WoW64 Support
    depth:
      description:
      - Depth of C(name) feature.
      type: int
      sample: 1
    depends_on:
      description:
      - The command line that will be run when a C(run_command) failure action is fired.
      type: list
      elements: str
      sample: ['Web-Static-Content', 'Web-Default-Doc']
    parent:
      description:
      - The parent of feature C(name) if present.
      type: str
      sample: PowerShellRoot
    server_component_descriptor:
      description:
      - Descriptor of C(name) feature.
      type: str
      sample: ServerComponent_AD_Certificate
    sub_features:
      description:
      - List of sub features names of feature C(name).
      type: list
      elements: str
      sample: ['WAS-Process-Model', 'WAS-NET-Environment', 'WAS-Config-APIs']
    system_service:
      description:
      - The name of the service installed by feature C(name).
      type: list
      elements: str
      sample: ['iisadmin', 'w3svc']
    notification:
      description:
      - Notifications from feature.
      - The binary part can be quoted to ensure any spaces in path are not treated as arguments.
      type: list
      element: str
      sample: []
    best_practices_model_id:
      description:
      - BestPracticesModelId for feature C(name).
      type: str
      sample: Microsoft/Windows/UpdateServices
    event_query:
      description:
      - The EventQuery for feature C(name).
      - This will be C(null) if None Present
      type: str
      sample: IPAMServer.Events.xml
    post_configuration_needed:
      description:
      - Tells if Post Configuration is needed for feature C(name).
      type: bool
      sample: False
    additional_info:
      description:
      - A list of privileges that the feature requires and will run with
      type: dict
      contains:
        major_version:
          description:
          - Major Version of feature C(name).
          type: int
          sample: 8
        minor_version:
          description:
          - Minor Version of feature C(name).
          type: int
          sample: 0
        number_id_version:
          description:
          - Numberic Id of feature C(name).
          type: int
          sample: 16
        install_name:
          description:
          - The action to perform once triggered, can be C(start_feature) or C(stop_feature).
          type: str
          sample: ADCertificateServicesRole
      contains: str
      sample: ['SeBackupPrivilege', 'SeRestorePrivilege']
    feature_exit_code:
      description:
      - A feature-specific error code that is set while the feature is starting or stopping.
      type: int
      sample: 0
    feature_flags:
      description:
      - Shows more information about the behaviour of a running feature.
      - Currently the only flag that can be set is C(runs_in_system_process).
      type: list
      elements: str
      sample: [ 'runs_in_system_process' ]
    feature_type:
      description:
      - The type of feature.
      - Common types are C(win32_own_process), C(win32_share_process), C(user_own_process), C(user_share_process),
        C(kernel_driver).
      type: str
      sample: win32_own_process
    sid_info:
      description:
      - The behavior of how the feature's access token is generated and how to add the feature SID to the token.
      - Common values are C(none), C(restricted), or C(unrestricted).
      type: str
      sample: none
    start_mode:
      description:
      - When the feature is set to start.
      - Common values are C(auto), C(manual), C(disabled), C(delayed).
      type: str
      sample: auto
    state:
      description:
      - The current running state of the feature.
      - Common values are C(stopped), C(start_pending), C(stop_pending), C(started), C(continue_pending),
        C(pause_pending), C(paused).
      type: str
      sample: started
    triggers:
      description:
      - A list of triggers defined for the feature.
      type: list
      elements: dict
      contains:
        action:
          description:
          - The action to perform once triggered, can be C(start_feature) or C(stop_feature).
          type: str
          sample: start_feature
        data_items:
          description:
          - A list of trigger data items that contain trigger specific data.
          - A trigger can contain 0 or multiple data items.
          type: list
          elements: dict
          contains:
            data:
              description:
              - The trigger data item value.
              - Can be a string, list of string, int, or base64 string of binary data.
              type: complex
              sample: named pipe
            type:
              description:
              - The type of C(data) for the trigger.
              - Common values are C(string), C(binary), C(level), C(keyword_any), or C(keyword_all).
              type: str
              sample: string
        sub_type:
          description:
          - The trigger event sub type that is specific to each C(type).
          - Common values are C(named_pipe_event), C(domain_join), C(domain_leave), C(firewall_port_open), and others.
          type: str
          sample:
        sub_type_guid:
          description:
          - The guid which represents the trigger sub type.
          type: str
          sample: 1ce20aba-9851-4421-9430-1ddeb766e809
        type:
          description:
          - The trigger event type.
          - Common values are C(custom), C(rpc_interface_event), C(domain_join), C(group_policy), and others.
          type: str
          sample: domain_join
    username:
      description:
      - The username used to run the feature.
      - Can be null for user features and certain driver features.
      type: str
      sample: NT AUTHORITY\SYSTEM
    wait_hint_ms:
      description:
      - The estimated time in milliseconds required for a pending start, stop, pause,or continue operations.
      type: int
      sample: 0
    win32_exitcode:
      description:
      - The error code returned from the feature binary once it has stopped.
      - When set to C(1066) then a feature specific error is returned on C(feature_exit_code).
      type: int
      sample: 0
'''
