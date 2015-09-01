#!/bin/bash

set -e

global_opt1="$1"

log-cmd() {
  if test -z "$DEBUG" && test "$1" = "$"; then
    shift
    test -z "$*" && return 0
    "$@"
  else
    test -n "$1" && >&2 echo -n "$1 "
    shift
    test -z "$*" && >&2 echo && return 0
    >&2 echo "$@"
    "$@"
  fi
}

allow-admin() {
  for file in "$@"; do
    test ! -e "$file" && log-cmd "! $file doesn't exist; skipping" && continue
    log-cmd $ sudo chgrp -- admin "$file"
    log-cmd $ sudo chmod -- ug+rw "$file"
  done
}

allow-admin-recursive() {
  for file in "$@"; do
    test ! -e "$file" && log-cmd "! $file doesn't exist; skipping" && continue
    if test "$global_opt1" = '-R'; then
      log-cmd $ sudo chgrp -R -- admin "$file"
      log-cmd $ sudo chmod -R -- ug+rw "$file"
    else
      log-cmd "! $file not processed recurively; use -R to do so"
      log-cmd $ sudo chgrp -- admin "$file"
      log-cmd $ sudo chmod -- ug+rw "$file"
    fi
  done
}

replace-peruser() {
  peruser=~/"$1"
  peruser_literal="~/$1"
  global=/"$1"
  test -L "$peruser" && return
  if test -d "$peruser"; then
    log-cmd $ sudo rm -f -- "$peruser"/.localized "$peruser"/.DS-Store
    log-cmd $ mv -v -- "$peruser"/* "$global"/
    log-cmd $ sudo rmdir -- "$peruser"
  fi
  test -e "$peruser" && log-cmd "! $peruser_literal could not be safely removed; skipping"
  ln -s "$global" "$peruser"
}

symlink-brew-cask-dir() {
  allow-admin /"$1"
  replace-peruser "$1"
}

sudo-hide() {
  test ! -e "$1" && log-cmd "! $1 doesn't exist; skipping" && return 1
  log-cmd $ sudo chflags -h -- hidden "$1"
}

hide() {
  test ! -e "$1" && log-cmd "! $1 doesn't exist; skipping" && return 1
  log-cmd $ chflags -h -- hidden "$1"
}

log-cmd '' symlink-brew-cask-dir 'Applications'
log-cmd '' hide ~/'Applications'
log-cmd '' symlink-brew-cask-dir 'Library/ColorPickers'
log-cmd '' symlink-brew-cask-dir 'Library/QuickLook'
log-cmd '' symlink-brew-cask-dir 'Library/PreferencePanes'

log-cmd '' allow-admin '/usr/bin'
log-cmd '' allow-admin '/Library/Ruby'
log-cmd '' allow-admin-recursive '/Library/Ruby/Gems'/* '/Library/Ruby/Site'/*
log-cmd '' allow-admin '/Library/Python'
log-cmd '' allow-admin-recursive '/Library/Python'/*
log-cmd '' allow-admin-recursive '/usr/local/texlive'/*

log-cmd '' sudo-hide '/opt'
log-cmd '' sudo-hide '/Applications/Flip4Mac'
log-cmd '' sudo-hide '/Applications/Vagrant'
