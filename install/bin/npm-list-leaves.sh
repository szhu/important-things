#!/bin/bash
npm list -g 2>/dev/null | egrep '^(└|├)─┬ ' | sed 's#^└─┬ ##; s#^├─┬ ##; s#@[^@]*$##' | sort
