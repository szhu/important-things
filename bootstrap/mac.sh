#!/bin/bash
#
# Run with:
# bash -c "$(curl -fsSL https://goo.gl/zo57s2)"
#
# To undo (may be fairly destructive):
# rm -f ~/.bootstrapped
# rm -rf ~/.local/opt
# rm -rf ~/.config/fish
# rm -f ~/.gitconfig
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

mkdir -p ~/.config
mkdir -p ~/.local/opt

cd ~/.local/opt
2> /dev/null git clone https://github.com/szhu/important-things.git

cd ~/.local/opt/important-things
ln -s ../.local/opt/important-things/fish ~/.config
ln -s .local/opt/important-things/git/gitconfig ~/.gitconfig

ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
brew install fish
brew install caskroom/cask/brew-cask

cd ~

touch ~/.bootstrapped

~/.local/bin/fish
