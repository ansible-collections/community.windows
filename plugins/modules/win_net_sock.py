#!/usr/bin/python
# -*- coding: utf-8 -*-

# (c) 2018, Ansible by Red Hat, inc
# GNU General Public License v3.0+ (see LICENSES/GPL-3.0-or-later.txt or https://www.gnu.org/licenses/gpl-3.0.txt)
# SPDX-License-Identifier: GPL-3.0-or-later

from __future__ import absolute_import, division, print_function


__metaclass__ = type


DOCUMENTATION = """
module: win_net_sock
author: Yannnyan
short_description: Create a listening socket in the remote machine
description:
- The following module provides a way to automate in ansible creating a listening sockets in both udp and tcp for testing of 
  networking.
version_added: 1.0.0
options:
  state:
    description:
    - describes whether to kill the process running a specific socket on port or start a new socket
    options:
    - absent
    - present
    required: true
  type:
    description:
    - Specifies the type of the socket can be either TCP or UDP socket type
    options:
    - tcp
    - udp
    required: true
  port:
    description:
    - Specifies on which port to open the socket to
    required: true
"""

EXAMPLES = """

"""


RETURN = """
"""