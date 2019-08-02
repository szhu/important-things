#!/bin/bash

# Only attempt to do this once per outer shell.
[[ "$FISH_AUTOINVOKED" != 1 ]] &&

# Check terminal interactivity. Programs that pipe into bash expect to interact with bash. But if
# the interminal's input is interactive, then a human is on the other side, and fish can be used.
# Use one of the following:
# [[ -n "$PS1" ]] &&
[[ -t 0 ]] &&

# Check terminal type.
# Fish is buggy in certain, more basic shells. This isn't as common anymore.
echo "$TERM" | grep -qE '^(xterm|screen)(-(256)?color)?(-bce)?$' &&

# Check for fish, and start it.
for path in ~/.local/bin/fish /usr/local/bin/fish /usr/bin/fish; do
    [[ -e "$path" ]] && FISH_AUTOINVOKED=1 exec "$path"
done
