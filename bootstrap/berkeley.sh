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

mkdir -p ~/.config
mkdir -p ~/.local/opt
mkdir -p ~/work

cd ~/.local/opt
2> /dev/null git clone https://github.com/szhu/berkeley-cs-build.git
2> /dev/null git clone https://github.com/szhu/important-things.git

cd ~/.local/opt/important-things
ln -s ../.local/opt/important-things/fish ~/.config
ln -s .local/opt/important-things/git/gitconfig ~/.gitconfig

cd ~/.local/opt/berkeley-cs-build
if [ ! -e ~/.local/bin/fish ]; then
    curses/build.sh
    fish/build.sh
fi

cd ~
fish_bootstrap_cmd='
if [ -e ~/.local/bin/fish ] && [ "$(arch)" = x86_64 ] && [ -t 1 ] && [ "$SHLVL" -eq 1 ]; then
    clear
    ~/.local/bin/fish
    exit
fi
'

for rc_file in ~/.bashrc ~/.bash_profile; do
    if grep -Fq '~/.local/bin/fish' "$rc_file"; then
        echo "$rc_file already invokes fish shell; will not modify"
    else
        cp -f "$rc_file" "$rc_file~"
        echo "$fish_bootstrap_cmd" >> ~/.bashrc
    fi
done

touch ~/.bootstrapped

~/.local/bin/fish
