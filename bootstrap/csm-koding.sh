#!/bin/bash

set -e

# Prepend `verbose` to any command to have it echoed as well as run.
verbose() {
  echo 1>&2 ' '
  echo 1>&2 $ $@
  $@
}

# Generate SSH key
if test ! -e ~/.ssh/id_rsa; then
    verbose ssh-keygen
fi

# Check if SSH key is linked to a GitHub account
if ! ssh git@github.com 2>&1 | grep -q "You've successfully authenticated"; then
    echo "This needs to be linked to GitHub:"
    echo '##### SSH PUBLIC KEY #####'
    cat ~/.ssh/id_rsa.pub
    echo '##### SSH PUBLIC KEY #####'
fi

# Set git identity for CSM Bot
if ssh git@github.com 2>&1 | grep -q "Hi csm-bot! You've successfully authenticated"; then
  git config --global user.name "CSM Bot"
  git config --global user.email "csm.bot@szhu.me"
fi

# Install dependencies
PACKAGES="fish pandoc make texlive texlive-xetex texlive-latex-extra fondu"
if ! dpkg -s $PACKAGES &> /dev/null; then
    # sudo apt-add-repository ppa:fish-shell/release-2
    verbose sudo apt-get update -q=2
    verbose sudo apt-get install -y -q=2 $PACKAGES
fi

# Use fish as default shell
if test "$SHELL" != "$(which fish)"; then
    verbose sudo chsh "$(whoami)" --shell "$(which fish)"
fi

# Clone github.com/szhu/important-things
if test ! -e ~/.local/opt/important-things; then
    verbose git clone -q https://github.com/szhu/important-things.git ~/.local/opt/important-things
fi

# Use fish config from github.com/szhu/important-things
if test ! -e ~/.config/fish; then
    verbose ln -s ../.local/opt/important-things/fish ~/.config
fi

# Remove unused folders
for dir in Applications Backup Documents; do
    test -e "$dir" && verbose rmdir $dir
done

# Make ~/CSM
if test ! -e ~/CSM; then
    verbose mkdir ~/CSM
fi

# symlink ~/Web -> ~/CSM
if test ! -h ~/Web; then
    verbose mv ~/Web ~/Web.bak
    verbose ln -s CSM ~/Web
fi

# Install Helvetica (the font used in the worksheets)
# Set the $HELVETICA env var to the URL where Helvetica.dfont can be downloaded.
if ! test -e /tmp/fondu/Helvetica.ttf; then
    verbose mkdir -p /tmp/fondu
    cd /tmp/fondu
    verbose curl -sL "$HELVETICA" -o Helvetica.dfont
    verbose fondu Helvetica.dfont
    verbose sudo cp *.ttf /usr/share/fonts/truetype
fi
