#!/bin/bash

# This line can really help debugging
# osascript -e 'display notification "'"$(ps -o comm= -p $PPID)"'" with title "Invoked by"'

# Check caller
(ps -o comm= -p $PPID | grep -qE '^((/usr/bin/)?login|sshd|su|script|tmux(: server)|tmate|screen|(gnome|xfce4)-terminal|(.*/)?(Atom Helper|Hyper(Term)?))$' ||
 test -n "$DOCKER_HOST" -a "$SHLVL" = 2 ||
 test "$C9_SH_EXECUTED" = 1 -a "$SHLVL" = 4) &&
# Check terminal
echo "$TERM" | grep -qE '^(xterm|screen)(-(256)?color)?(-bce)?$' &&
# Check for fish
for path in ~/.local/bin/fish /usr/local/bin/fish /usr/bin/fish; do
    test -e "$path" && exec "$path"
done
