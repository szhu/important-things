is_command rbenv; or exit

if contains ~/.rbenv/shims $PATH
  # Move it to the front. In fish 3.0, the order of PATH gets shuffled around when fish starts.
  # We need ~/.rbenv/shims before /usr/bin and /usr/local/bin!
  set -x PATH ~/.rbenv/shims $PATH

else
  # rbenv should have been loaded in .bash_profile or .bashrc, for GUI program compatibility.
  # Loading rbenv in this file is done only just in case.
  echo
  echo "Warning: rbenv is installed but was not loaded in a parent shell."
  echo rbenv init | env $SHELL

  status --is-interactive; and source (rbenv init -|psub)
end
