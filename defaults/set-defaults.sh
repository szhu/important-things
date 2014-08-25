#!/bin/bash

defaults write -g NSDisableAutomaticTermination -bool FALSE  # attempt to keep imessages from showing error dialog
defaults write com.apple.dashboard devmode -bool YES
defaults write com.apple.DiskUtility DUDebugMenuEnabled 1
defaults write com.apple.finder QLEnableTextSelection -bool YES
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool NO
defaults write org.chromium.Chromium AppleEnableSwipeNavigateWithScrolls -bool NO
defaults write org.n8gray.QLColorCode font Menlo
defaults write org.n8gray.QLColorCode fontSizePoints 8
