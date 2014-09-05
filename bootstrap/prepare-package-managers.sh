#!/bin/bash

set -e

global_opt1="$1"

warn() {
  shift
  >&2 echo "!! $@"
  # >&2 echo "!!"
  # >&2 echo "!! warning: $@"
  # >&2 echo "!!"
}
allow_admin() {
  sudo chgrp admin "$1"
  sudo chmod ug+rw "$1"
}
allow_admin_recursive() {
  if test "$global_opt1" = '-R'; then
    sudo chgrp -R admin "$1"
    sudo chmod -R ug+rw "$1"
  else
    warn "$1" "not processed recurively; use -R to do so"
    allow_admin "$1"
  fi
}
replace_peruser() {
  peruser=~/"$1"
  peruser_literal="~/$1"
  global=/"$1"
  if test -L "$peruser"; then
    true
    # rm "$peruser"
  elif test -d "$peruser"; then
    sudo rm -f "$peruser"/.localized "$peruser"/.DS_Store
    sudo rmdir "$peruser"
  fi

  if test -e "$peruser"; then
    warn "$peruser_literal -> $global" "not processed because it could not be safely removed"
  else
    ln -s "$global" "$peruser"
  fi
}
symlink_brew_cask_dir() {
  allow_admin /"$1"
  replace_peruser "$1"
}
sudo_hide() {
  if test -e "$1"; then
    sudo chflags -h hidden "$1"
  else
    warn "$1" "not processed because it doesn't exist"
  fi
}
hide() {
  if test -e "$1"; then
    chflags -h hidden "$1"
  else
    warn "$1" "not processed because it doesn't exist"
  fi
}

set -v
symlink_brew_cask_dir 'Applications'
hide ~/'Applications'
symlink_brew_cask_dir 'Library/ColorPickers'
symlink_brew_cask_dir 'Library/QuickLook'
symlink_brew_cask_dir 'Library/PreferencePanes'

allow_admin '/usr/bin'
allow_admin_recursive '/Library/Ruby'/*
allow_admin_recursive '/Library/Python'/*
allow_admin_recursive '/usr/local/texlive'/*

sudo_hide '/opt'
sudo_hide '/Applications/Flip4Mac'
sudo_hide '/Applications/Vagrant'
