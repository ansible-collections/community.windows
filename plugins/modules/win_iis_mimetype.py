#!/usr/bin/python
# -*- coding: utf-8 -*-

# Copyright: (c) 2022 VMware, Inc. All Rights Reserved.
# SPDX-License-Identifier: Internal

DOCUMENTATION = r'''
---
module: win_iis_mimetype
author: Chris Gallagher (@git-cgallagher)
short_description: Configure IIS Web Application MIME Types
description:
  - Creates, removes and reconfigures an IIS Web Application MIME Types.
options:
  path:
    description:
      - The path under which the MIME type is configured.
    type: str
    default: MACHINE/WEBROOT/APPHOST
  mime_type:
    description:
      - The MIME type to map that extension to such as text/html.
      - Required when I(state) is set to C(present).
    type: str
  extension:
    description:
      - The file extension to map such as .html or .xml.
    type: str
    required: yes
  state:
    description:
      - The state of the MIME type mapping.
      - If C(absent) will ensure the MIME type is removed.
      - If C(present) will ensure the MIME type is configured and exists.
    type: str
    choices: [ absent, present ]
    default: present

'''

EXAMPLES = r'''
- name: Ensure MIME type mapping for .xml is Present
  community.windows.win_iis_mimetype:
    mime_type: text/xml
    extension: .xml

- name: Ensure MIME type mapping for .xml is Absent
  community.windows.win_iis_mimetype:
    extension: .xml
    state: absent

- name: Ensure MIME type mapping for .log is Present in My Awesome Website
  community.windows.win_iis_mimetype:
    site: IIS:\sites\My Awesome Website
    mime_type: text/plain
    extension: .log

- name: Ensure MIME type mapping for .gif is Present
  community.windows.win_iis_mimetype:
    mime_type: image/gif
    extension: .gif

- name: Ensure MIME type mapping for .gif is Absent in My Awesome Site
  community.windows.win_iis_mimetype:
    site: IIS:\sites\My Awesome Website
    mime_type: image/gif
    extension: .gif
    state: absent

'''