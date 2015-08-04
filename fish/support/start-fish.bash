#!/bin/bash

[[ "$SHLVL" = 1 ]] &&
[[ ( "$TERM" = "xterm-256color" || -n "$ATOM_HOME" ) ]] &&
[[ -z "$INSIDE_EMACS" ]] &&
exec /usr/local/bin/fish
