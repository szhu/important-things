#!/bin/bash
#
# Run with:
# bash -c "$(curl -fsSL https://goo.gl/zo57s2)"

if [[ -e ~/.bootstrapped ]] ; then
    echo 'Already bootstrapped! Delete ~/.bootstrap to attempt to delete and reinstall.'
    exit 1
fi

set -e
set -v

mkdir -p ~/.config
mkdir -p ~/.local/opt

cd ~/.local/opt
rm -rf important-things
git clone -q https://github.com/szhu/important-things.git

cd ~/.local/opt/important-things
rm -rf important-things ~/.config/fish
ln -s ../.local/opt/important-things/fish ~/.config
rm -rf important-things ~/.gitconfig
ln -s .local/opt/important-things/git/gitconfig ~/.gitconfig

cd ~
if [[ -z "$(which brew)" ]]; then
    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
fi
brew install fish
brew install caskroom/cask/brew-cask
# To prepare cask, run ~/.local/opt/important-things/bootstrap/prepare-package-managers.sh
touch .bootstrapped


defaults write com.apple.Terminal Shell /usr/local/bin/fish
/usr/local/bin/fish
