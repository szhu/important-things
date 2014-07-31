#!/bin/bash
PY_VERSION="$1"
cd "/Library/Python/${PY_VERSION}"
find . -name "*-py${PY_VERSION}.egg-info" | sed "s#.*/##; s#-[^-]*-py${PY_VERSION}.egg-info##"
