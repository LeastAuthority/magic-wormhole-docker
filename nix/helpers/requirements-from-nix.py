#!/usr/bin/env python

import os
import re

# Pattern for Python modules
p = re.compile('python[0-9]+\.[0-9]+-(.+)-([0-9]+(\.[0-9]+){0,2})(-.+)?')

# Iterate through Nix store
for dir in os.listdir("/nix/store"):
    # Remove the fix hash part
    pkg = dir[33:]
    # Match Python modules
    m = p.match(pkg)
    # Print as requirement
    if m:
        name = m.group(1)
        version = m.group(2)
        suffix = m.group(4) or ""
        print('{}=={}{}'.format(name, version, suffix))
