#!/usr/bin/python
# -*- coding: utf-8 -*-

# Copyright: (c) 2020, Brian Scholer <@briantist>
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

DOCUMENTATION = r'''
---
module: win_psrepository_copy
short_description: Copies registered PSRepositories to other user profiles
description:
  - Copies specified registered PSRepositories to other user profiles on the system.
  - Can include the C(Default) profile so that new users start with the selected repositories.
  - Can include special service accounts like the local SYSTEM user, LocalService, NetworkService.
options:
  source:
    description:
      - The full path to the source repositories XML file.
      - Defaults to the repositories registered to the current user.
    type: path
    default: '%LOCALAPPDATA%\Microsoft\Windows\PowerShell\PowerShellGet\PSRepositories.xml'
  name:
    description:
      - The names of repositories to copy.
      - Names are interpreted as wildcards.
    type: list
    elements: str
    default: ['*']
  exclude:
    description:
      - The names of repositories to exclude.
      - Names are interpreted as wildcards.
      - If a name matches both an include (I(name)) and I(exclude), it will be excluded.
    type: list
    elements: str
  profiles:
    description:
      - The names of user profiles to populate with repositories.
      - Names are interpreted as wildcards.
      - The C(Default) profile can also be matched.
      - The C(Public) and C(All Users) profiles cannot be targeted, as PSRepositories are not loaded from them.
    type: list
    elements: str
    default: ['*']
  exclude_profiles:
    description:
      - The names of user profiles to exclude.
      - If a profile matches both an include (I(profiles)) and I(exclude_profiles), it will be excluded.
      - By default, the service account profiles are excluded.
      - To explcitly exclude nothing, set I(exclude_profiles=[]).
    type: list
    elements: str
    default:
      - systemprofile
      - LocalService
      - NetworkService
notes:
  - Does not require the C(PowerShellGet) module or any other external dependencies.
  - User profiles are loaded from the registry. If a given path does not exist (like if the profile directory was deleted), it is silently skipped.
  - If setting service account profiles, you may need C(become=yes). See examples.
  - "When PowerShellGet first sets up a repositories file, it always adds C(PSGallery), however if this module creates a new repos file and your selected
    repositories don't include C(PSGallery), it won't be in your destination."
  - "The values searched in I(profiles) (and I(exclude_profiles)) are profile names, not necessarily user names. This can happen when the profile is
    deliberately changed or when domain user names conflict with users from the local computer or another domain. In this case the second+ user may have the
    domain name or local computer name appended, like C(JoeUser.Contoso) vs. C(JoeUser).
    If you intend to filter user profiles, ensure your filters catch the right names."
  - "In the case of the service accounts, the specific profiles are C(systemprofile) (for the C(SYSTEM) user), and C(LocalService) or C(NetworkService)
    for those accounts respectively."
seealso:
  - module: community.windows.win_psrepository
  - module: community.windiws.win_psrepository_info
author:
  - Brian Scholer (@briantist)
'''

EXAMPLES = r'''
'''

RETURN = r'''
'''
