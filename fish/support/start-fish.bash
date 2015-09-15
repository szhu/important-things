#!/bin/bash

[[ "$SHLVL" = 1 || -n "$TMUX" || ( -n "$DOCKER_HOST" && "$SHLVL" = 2 ) ]] &&
[[ ( "$TERM" = "xterm-256color" || "$TERM" = "screen" || -n "$ATOM_HOME" ) ]] &&
[[ -z "$INSIDE_EMACS" ]] &&
for path in /usr/local/bin/fish /usr/bin/fish ~/.local/bin/fish; do
    test -e "$path" && exec "$path" || true
done
