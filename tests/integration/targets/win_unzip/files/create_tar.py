#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Copyright: (c) 2025, Ansible Project
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

from __future__ import (absolute_import, division, print_function)
__metaclass__ = type

import io
import sys
import tarfile


def main():
    content = b'hello from tar'

    with tarfile.open(sys.argv[1], 'w:gz') as tar:
        info = tarfile.TarInfo(name='hello.txt')
        info.size = len(content)
        tar.addfile(info, io.BytesIO(content))


if __name__ == '__main__':
    main()
