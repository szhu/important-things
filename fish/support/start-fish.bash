#!/bin/bash

PARENT="$(ps -o comm= $PPID)"
[[ "$PARENT" = 'login' || "$PARENT" = 'tmux' || ( -n "$DOCKER_HOST" && "$SHLVL" = 2 ) ]] &&
[[ "$TERM" = "xterm-256color" || "$TERM" = "xterm-color" || "$TERM" = "screen" ]] &&
for path in /usr/local/bin/fish /usr/bin/fish ~/.local/bin/fish; do
    test -e "$path" && exec "$path" || true
done
