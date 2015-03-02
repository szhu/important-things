#!/usr/bin/env bash

# rsync -rvx --progress --delete-during ~/'Library/Application Support/Adium 2.0/' ~/'Dropbox/Library/Application Support/Adium'
# rsync -rvx --progress --delete-during ~/'Library/Application Support/Quicksilver/' ~/'Dropbox/Library/Application Support/Quicksilver'

cd "$(dirname "$0")"

OPTS=(-rluxy --delete-during --delete-excluded --force --exclude-from exclude)

# Application Support #
rsync ${OPTS[*]} ~/'Library/Application Support/Adium 2.0/'       ~/'Dropbox/Library/Mac/Adium'
rsync ${OPTS[*]} ~/'Library/Application Support/Quicksilver/'     ~/'Dropbox/Library/Mac/Quicksilver'
rsync ${OPTS[*]} ~/'Library/Application Support/BetterTouchTool/' ~/'Dropbox/Library/Mac/BetterTouchTool'
