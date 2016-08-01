#!/bin/bash
# mkdir -p ~/.local/bin
# nano ~/.local/bin/launch-with-wd.bash
# chmod a+x ~/.local/bin/launch-with-wd.bash

set -e

error() {
    echo Error: "$@"
    return 1
}

test "$#" -ge 2 ||
error "not enough arguments"

NEW_WD="$1"
shift

CMD="$1"
echo "$CMD" | grep -qE '^(/usr/bin/(bundle|gem)|/usr/local/bin/(brew|fish|npm|pip|pip3))$' ||
error "command not allowed"

cd "$NEW_WD"

exec "$@"
