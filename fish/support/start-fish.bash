#!/bin/bash

# Only attempt to do this once per outer shell
[[ "$FISH_AUTOINVOKED" != 1 ]] &&

# Check terminal
[[ -n "$PS1" ]] &&
echo "$TERM" | grep -qE '^(xterm|screen)(-(256)?color)?(-bce)?$' &&

# Check for fish
for path in ~/.local/bin/fish /usr/local/bin/fish /usr/bin/fish; do
    [[ -e "$path" ]] && FISH_AUTOINVOKED=1 exec "$path"
done
