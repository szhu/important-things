#!/usr/bin/env python

from sys import argv

for fname in argv[1:]:
    import yaml
    with open(fname) as f:
        data = yaml.load(f)
    with open(fname, 'w') as f:
        f.write(yaml.dump(data, default_flow_style=None))
