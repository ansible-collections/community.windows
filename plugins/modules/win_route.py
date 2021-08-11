#!/usr/bin/python
# -*- coding: utf-8 -*-

# Copyright: (c) 2017, Daniele Lazzari <lazzari@mailup.com>
# Modified by: Vicente Danzmann Vivian (@iVcente)
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

DOCUMENTATION = r'''
---
module: win_route
short_description: Add or remove a static route
description:
    - Add or remove a static route.
options:
  network:
    description:
      - Destination network.
    type: str
    required: yes
  mask:
    description:
      - Destination network's mask.
    type: str
    required: yes
  gateway:
    description:
        - The gateway used by the static route.
    type: str
    required: yes
  metric:
    description:
        - Metric used by the static route.
    type: int
    default: 1
  state:
    description:
      - If C(absent), it removes a network static route.
      - If C(present), it adds a network static route.
    type: str
    choices: [ absent, present ]
    default: present
notes:
  - Works only with Windows 2012 R2 and newer.
author:
- Daniele Lazzari (@dlazz)
- Vicente Danzmann Vivian (@iVcente)
'''

EXAMPLES = r'''
---
- name: Add a network static route.
  community.windows.win_route:
    network: 192.168.24.0
    mask: 255.255.255.0
    gateway: 192.168.24.1
    metric: 1
    state: present

- name: Remove a network static route.
  community.windows.win_route:
    network: 192.168.24.0
    mask: 255.255.255.0
    gateway: 192.168.24.1
    state: absent
'''
RETURN = r'''
output:
    description: A message describing the task result.
    returned: always
    type: str
    sample: "Route added!"
'''
