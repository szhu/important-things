#!/bin/bash
set -x

# defaults write -g NSDisableAutomaticTermination -bool FALSE  # attempt to keep imessages from showing error dialog
defaults write -g AppleMiniaturizeOnDoubleClick -bool YES
defaults write -g InitialKeyRepeat -float 15
defaults write -g KeyRepeat -float 2

defaults write com.apple.dashboard devmode -bool YES
defaults write com.apple.DiskUtility DUDebugMenuEnabled 1
defaults write com.apple.finder QLEnableTextSelection -bool YES

defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool NO
defaults write org.chromium.Chromium AppleEnableSwipeNavigateWithScrolls -bool NO
defaults write org.n8gray.QLColorCode font Menlo
defaults write org.n8gray.QLColorCode fontSizePoints 8

sudo /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport en1 prefs RequireAdminPowerToggle=NO DisconnectOnLogout=NO RememberRecentNetworks=NO

sudo defaults write /Library/Preferences/com.apple.loginwindow SHOWOTHERUSERS_MANAGED -bool FALSE

sudo scutil --set HostName mac.szhu.me
sudo scutil --set LocalHostName '???'
sudo scutil --set ComputerName '???'

sudo dscl . create /Users/Guest IsHidden 1
sudo dscl . create /Users/Administrator IsHidden 1

# https://trac.cyberduck.io/ticket/7302
defaults write ch.sudo.cyberduck rendezvous.notification.limit 0
