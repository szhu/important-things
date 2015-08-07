#!/bin/bash
#
# Snippets:
# curl -fsSL http://git.io/vOjip
# bash -cx "$(curl -fsSL http://git.io/vOjip)" ssh fish git important
# bash -c "$(curl -fsSL http://git.io/vOjip)" ssh update fish git homedirs
#
# To undo (may be fairly destructive):
# rm -rf ~/.ssh/id_rsa ~/.gitconfig ~/.local/opt ~/.config/fish

set -e

warn() {
    echo 1>&2 $@
}

# Prepend `verbose` to any command to have it echoed as well as run.
verbose() {
  warn ' '
  warn $ $@
  $@
}

# Generate SSH key
ssh() {
    test -e ~/.ssh/id_rsa && return
    yes '' | verbose ssh-keygen
}

# Install things
update() {
    verbose sudo apt-get update > /dev/null
}

install-apt-add-repository() {
    dpkg -s python-software-properties software-properties-common &> /dev/null && return
    verbose sudo apt-get install -y python-software-properties software-properties-common
}

fish() {
    dpkg -s fish &> /dev/null && return
    install-apt-add-repository
    yes '' | verbose sudo apt-add-repository ppa:fish-shell/release-2 > /dev/null
    verbose sudo apt-get install -y fish
    verbose sudo chsh "$(whoami)" -s "$(which fish)"
}

git() {
    dpkg -s git &> /dev/null && return
    verbose sudo apt-get install -y git
}

subl() {
    yes '' | verbose sudo add-apt-repository ppa:webupd8team/sublime-text-3 > /dev/null
}

clone-important-things() {
    test -e ~/.local/opt/important-things && return
    verbose mkdir -p .local/opt
    verbose git clone -q https://github.com/szhu/important-things.git ~/.local/opt/important-things
}
symlink-gitconfig() {
    test -e ~/.gitconfig && return
    gitconfig='
    [include]
        path = .local/opt/important-things/git/gitconfig
    '
    verbose echo "$gitconfig" > ~/.gitconfig
}
symlink-fishconfig() {
    test -e ~/.config/fish && return
    verbose mkdir -p .config
    verbose ln -s ../.local/opt/important-things/fish ~/.config
}
symlink-sublconfig() {
    test -e ~/.local/share/sublime-text-3/Packages/User && return
    verbose mkdir -p ~/.local/share/sublime-text-3/Packages
    verbose ln -s ../../../../.local/opt/important-things/sublime-text/ ~/.local/share/sublime-text-3/Packages/User
}
important() {
    clone-important-things
    symlink-fishconfig
    symlink-gitconfig
    symlink-sublconfig
}

# Rearrange default directories in home folder
try-rmdir() {
    test -e "$1" && verbose rmdir -- "$1" || true
}
try-mvdir() {
    test -e "$2" && verbose rmdir -- "$1" && return || true
    test -e "$1" && verbose mv -- "$1" "$2" || true
}
homedirs() {
    try-rmdir Applications
    try-rmdir Backup
    try-rmdir Music
    try-rmdir Public
    try-rmdir Templates
    try-rmdir Videos

    try-mvdir Desktop desktop
    try-mvdir Downloads downloads
    try-mvdir Documents work

    user_dirs_contents='
# This file is written by xdg-user-dirs-update
# If you want to change or add directories, just edit the line you'\''re
# interested in. All local changes will be retained on the next run
# Format is XDG_xxx_DIR="$HOME/yyy", where yyy is a shell-escaped
# homedir-relative path, or XDG_xxx_DIR="/yyy", where /yyy is an
# absolute path. No other format is supported.
#
XDG_DESKTOP_DIR="$HOME/desktop"
XDG_DOWNLOAD_DIR="$HOME/downloads"
XDG_TEMPLATES_DIR="$HOME/work/templates"
XDG_PUBLICSHARE_DIR="$HOME/public_html"
XDG_DOCUMENTS_DIR="$HOME/work"
XDG_MUSIC_DIR="$HOME"
XDG_PICTURES_DIR="$HOME"
XDG_VIDEOS_DIR="$HOME"
    '
    verbose echo "$user_dirs_contents" > ~/.config/user-dirs.dirs
}

warn "Hello!"
warn "options:" $0 $@
for f in $0 $@; do
    warn ''
    warn '#############' $f '#############'
    $f
done
