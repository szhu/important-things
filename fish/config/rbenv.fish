is_command rbenv; or exit
contains ~/.rbenv/shims $PATH; and exit

# rbenv should have been loaded in .bash_profile or .bashrc, for GUI program compatibility.
# Loading rbenv in this file is done only just in case.
echo
echo "Warning: rbenv is installed but was not loaded in a parent shell."
echo rbenv init | env $SHELL

status --is-interactive; and source (rbenv init -|psub)
