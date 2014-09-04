#!/bin/bash

if [[ -e ~/.bootstrapped ]] ; then
    echo 'already bootstrapped'
    [[ $_ != $0 ]] && return 1 || exit 1
fi

set -e
set -x

mkdir -p ~/.config
mkdir -p ~/.local/opt
mkdir -p ~/work

cd ~/.local/opt
git clone https://github.com/rogerhub/cs-build.git
git clone https://github.com/szhu/important-things.git

cd ~/.local/opt/important-things
ln -s ../.local/opt/important-things/fish ~/.config
ln -s .local/opt/important-things/git/gitconfig ~/.gitconfig

cd ~/.local/opt/cs-build
curses/build.sh
fish/build.sh

echo <<EOS >> ~/.bashrc

if [ -t 1 ] ; then
    clear
    ~/.local/bin/fish
    exit
fi
EOS
echo <<EOS >> ~/.bash_profile

if [ -t 1 ] ; then
    clear
    ~/.local/bin/fish
    exit
fi
EOS

cd ~
touch .bootstrapped

~/.local/bin/fish
