# https://raw.githubusercontent.com/lunks/fish-nuggets/master/functions/rvm.fish

function rvm --description='Ruby enVironment Manager'
  # run RVM and capture the resulting environment
  set --local env_file (mktemp -t rvm.fish.XXXXXXXXXX)
  bash -c 'source ~/.rvm/scripts/rvm; rvm "$@"; status=$?; env > "$0"; exit $status' $env_file $argv

  # apply rvm_* and *PATH variables from the captured environment
  and eval (grep '^rvm\|^[^=]*PATH\|^GEM_HOME' $env_file | grep -v '_clr=' | sed '/^[^=]*PATH/s/:/" "/g; s/^/set -xg /; s/=/ "/; s/$/" ;/; s/(//; s/)//')
  # clean up
  rm -f $env_file
end

function __rvm_autogreeting
  test "$TERM_PROGRAM" = "Apple_Terminal"; and set -l __rvm_status_char "💎  "; or set -l __rvm_status_char "rvm: "
  echo -ne "\n$__rvm_status_char...\r$__rvm_status_char"
end

function __rvm_on_cd --on-variable PWD
  # Source a .rvmrc file in a directory after changing to it, if it exists.
  # To disable this fature, set rvm_project_rvmrc=0 in $HOME/.rvmrc

  test "$rvm_project_rvmrc" = 0; and return
  status --is-command-substitution; and return

  set -l cwd $PWD
  while true
    if contains $cwd '' ~ /
      test "$__last_rvm_cwd" = $cwd -o -z "$__last_rvm_cwd"; and return
      set_color green --bold
      __rvm_autogreeting
      rvm use system
      set -x -e GEM_HOME
      set -x -e GEM_PATH
      set_color normal
      set -g __last_rvm_cwd $cwd
      break
    else if test -e $cwd/.rvmrc -o -e $cwd/.ruby-version -o -e $cwd/.ruby-gemset -o -e $cwd/Gemfile
      test "$__last_rvm_cwd" = $cwd; and return
      set_color green --bold
      __rvm_autogreeting
      test -n "$__last_rvm_cwd"; and rvm use system > /dev/null
      rvm current
      set_color normal
      set -g __last_rvm_cwd $cwd
      break
    end
    set cwd (dirname "$cwd")
  end
end
