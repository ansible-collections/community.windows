#!/usr/bin/python
# -*- coding: utf-8 -*-

# Copyright: (c) 2022 VMware, Inc. All Rights Reserved.
# SPDX-License-Identifier: Internal

DOCUMENTATION = r'''
---
module: win_iis_mimetype_info
author: Chris Gallagher (@git-cgallagher)
short_description: Get info about a MIME type or associated extension
description: The module is used to look up associated values of a MIME Type or Extension on an IIS web server
options:
  path:
    description:
      - The path under which the MIME type is configured.
    type: str
    default: MACHINE/WEBROOT/APPHOST
  mime_type:
    description:
      - The MIME type, such as text/html.
    type: str
  extension:
    description:
      - The file extension, such as .html or .xml.
    type: str
notes:
- This module requires and attempts to import the WebAdministration module
  to manage the local IIS instance. This module is typically installed 
  by default with the Web Server (IIS) feature and Management Tools.
  Should this be required independent of this module,
  you can use the M(community.windows.win_psmodule) to do so.
'''

EXAMPLES = r'''
- name: Get all results from custom site
  win_iis_mimetype_info:
    path: IIS:\sites\Default Web Site

- name: Get MIME Type Info for Extension from Custom Site
  win_iis_mimetype_info:
    path: IIS:\sites\Default Web Site
    extension: .csg

- name: Get Mime Type Info for Extension
  win_iis_mimetype_info:
    extension: .csg

- name: Get Extensions of MIME Type
  win_iis_mimetype_info:
    mime_type: text/unique
'''

RETURN = r'''
mimetypes:
  description: List of matching MIME type values found using specified params
  returned: always
  type: list
  elements: dict
  sample:
    - extension: .csg
      mime_type: text/plain
      path: MACHINE/WEBROOT/APPHOST
    - extension: .csg2
      mime_type: text/plain
      path: MACHINE/WEBROOT/APPHOST
'''
