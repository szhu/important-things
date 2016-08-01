#!/bin/bash
# mkdir -p ~/.local/bin
# nano ~/.local/bin/launch-with-wd.bash
# chmod a+x ~/.local/bin/launch-with-wd.bash

set -e

error() {
    echo Error: "$@"
    return 1
}

# Check number of args
test "$#" -ge 2 ||
error "not enough arguments"

# Get new working dir
NEW_WD="$1"
shift

# Get command
CMD="$1"
echo "$CMD" | grep -qE '^(/usr/bin/(bundle|gem)|/usr/local/bin/(brew|fish|npm|pip|pip3))$' ||
error "command not allowed"



# Set $PATH
if [ -x /usr/libexec/path_helper ]; then
    eval "$(/usr/libexec/path_helper -s)"
fi

# Set working dir
cd "$NEW_WD"

# Run command
exec "$@"
