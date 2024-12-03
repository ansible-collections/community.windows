#!/usr/bin/python
# -*- coding: utf-8 -*-

# (c) 2018, Ansible by Red Hat, inc
# GNU General Public License v3.0+ (see LICENSES/GPL-3.0-or-later.txt or https://www.gnu.org/licenses/gpl-3.0.txt)
# SPDX-License-Identifier: GPL-3.0-or-later

from __future__ import absolute_import, division, print_function


__metaclass__ = type


DOCUMENTATION = """
module: win_net_tcp
author:
  - Yan (@Yannnyan)
short_description: Open a socket to check connectivity from one machine to a destination machine
description:
- The following module provides details about connection from the source machine to the destination as quickly as possible.
  The details would cover standard tcp protocol responses. Allowing network administrators to troubleshoot connections via
  automation.
version_added: 1.0.0
options:
  dest:
    description:
    - Specifies the destination machine to connect the socket to
    required: true
  port:
    description:
    - Specifies on which port to connect to on the destination machine
    required: true
"""

EXAMPLES = """

"""


RETURN = """
"""
