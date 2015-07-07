#!/bin/bash
#
# Run with:
# bash -c "$(curl -fsSL https://goo.gl/FUIwla)"
#
# To undo (may be fairly destructive):
# rm -f ~/.bootstrapped
# rm -rf ~/.local/opt
# rm -rf ~/.config/fish
# rm -f ~/.gitconfig
# ... and remove lines from ~/.bashrc and ~/.bash_profile
#
# all in one line:
# rm -f ~/.bootstrapped ~/.gitconfig && rm -rf ~/.local/opt ~/.config/fish && bash -c "$(curl -fsSL https://goo.gl/FUIwla)"

last_command=$_

if [[ -e ~/.bootstrapped ]] ; then
    echo 'Already bootstrapped!'
    [[ "$last_command" != "$0" ]] && return 1 || exit 1
fi

set -e
set -v

cd ~


# Make directories

mkdir -p .config
mkdir -p .local/opt
mkdir -p work


# Symlink config files to files in important-things repo

cd ~/.local/opt
git clone -q https://github.com/szhu/important-things.git
cd important-things
ln -s ../.local/opt/important-things/fish ~/.config
ln -s .local/opt/important-things/git/gitconfig ~/.gitconfig

mkdir -p ~/.local/share/sublime-text-3/Packages
if [ ! -e ~/.local/share/sublime-text-3/Packages/User ]; then
    ln -s ../../../../.local/opt/important-things/sublime-text/ ~/.local/share/sublime-text-3/Packages/User
fi

# Install fish shell

if [ ! -e ~/.local/bin/fish ]; then
    cd ~/.local/opt
    git clone -q https://github.com/rogerhub/cs-build.git berkeley-cs-build
    cd berkeley-cs-build
    curses/build.sh
    fish/build.sh
    rm -rf ~/.local/opt/berkeley-cs-build
fi


# Make fish the pseudo-default shell

cd ~
fish_bootstrap_cmd='
if [ -e ~/.local/bin/fish ] && [ "$(arch)" = x86_64 ] && [ -t 1 ] && [ "$SHLVL" -eq 1 ]; then
    clear
    exec ~/.local/bin/fish
fi
'

for rc_file in .bashrc .bash_profile; do
    if grep -Fq '~/.local/bin/fish' "$rc_file"; then
        echo "$rc_file already invokes fish shell; will not modify"
    else
        cp -f "$rc_file" "$rc_file~"
        echo "$fish_bootstrap_cmd" >> "$rc_file"
    fi
done


# Rearrange default directories in home folder

rmdir_if_exists() {
    if [[ -d "$1" ]] ; then
        rmdir "$1"
    else
        echo "$1 gone; will not modify"
    fi
}
mvdir_if_exists() {
    if [[ -d "$1" ]] ; then
        mv "$1" "$2"
    else
        echo "$1 gone; will not modify"
    fi
}
rmdir_if_exists Music
rmdir_if_exists Public
rmdir_if_exists Templates
rmdir_if_exists Videos

mvdir_if_exists Desktop desktop
mvdir_if_exists Downloads downloads
mvdir_if_exists Documents work

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
echo "$user_dirs_contents" > ~/.config/user-dirs.dirs


# Make SSH identity

if [ ! -e .ssh/id_rsa ]; then
    yes '' | ssh-keygen
fi


# Mark user as bootstrapped

touch .bootstrapped


# Start fish shell

.local/bin/fish
