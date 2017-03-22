#!/bin/bash

# Check caller
(ps -o comm= -p $PPID | grep -qE '^(login|sshd|su|script|tmux|tmate|screen|gnome-terminal|(.*/)?(Atom Helper|HyperTerm))$' || test -n "$DOCKER_HOST" -a "$SHLVL" = 2) &&
# Check terminal
echo "$TERM" | grep -qE '^(xterm|screen)(-(256)?color)?(-bce)?$' &&
# Check for fish
for path in ~/.local/bin/fish /usr/local/bin/fish /usr/bin/fish; do
    test -e "$path" && exec "$path" 
done
