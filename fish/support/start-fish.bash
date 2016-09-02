#!/bin/bash

# Check caller
(ps -o comm= -p $PPID | grep -qE '^(login|sshd|su|tmux|(.*/)?(Atom Helper|HyperTerm))$' || test -n "$DOCKER_HOST" -a "$SHLVL" = 2) &&
# Check terminal
[[ "$TERM" = "xterm-256color" || "$TERM" = "xterm-color" || "$TERM" = "screen" ]] &&
# Check for fish
for path in ~/.local/bin/fish /usr/local/bin/fish /usr/bin/fish; do
    test -e "$path" && exec "$path" 
done
