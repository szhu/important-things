-- These work great when attached to keyboard shortcuts.

-- Wi-Fi on
do shell script "networksetup -setairportpower en0 on"

-- Wi-Fi off
do shell script "networksetup -setairportpower en0 off"

-- Bluetooth on
do shell script "/usr/local/bin/blueutil power 1"

-- Bluetooth off
do shell script "/usr/local/bin/blueutil power 0"
