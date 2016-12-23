#!/bin/bash

# Check caller
(ps -o comm= -p $PPID | grep -qE '^(login|sshd|su|script|tmux|tmate|screen|gnome-terminal|(.*/)?(Atom Helper|Hyper(Term)?))$' ||
 test -n "$DOCKER_HOST" -a "$SHLVL" = 2 ||
 test "$C9_SH_EXECUTED" = 1 -a "$SHLVL" = 4) &&
# Check terminal
echo "$TERM" | grep -qE '^(xterm|screen)(-(256)?color)?(-bce)?$' &&
# Check for fish
for path in ~/.local/bin/fish /usr/local/bin/fish /usr/bin/fish; do
    test -e "$path" && exec "$path" 
done
