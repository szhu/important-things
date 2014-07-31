#!/bin/bash
PY_VERSION="$1"
"pip${PY_VERSION}" freeze | sed 's#==[^=]*$##'
