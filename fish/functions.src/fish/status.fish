# Hostnames

function status-is-remote
  test -n "$SSH_CLIENT"; or test -n "$SSH_TTY"
end

function status-hostname
  hostname | cut -d . -f 1
end

function status-user-hostname
  echo (whoami)@(status-hostname)
end


# Other

function status-returncode-error -a errno
  test $errno -eq 0; and return
  echo -n "[Error $errno]"
end

function status-time
  echo (date +%H:%M)
end

function status-git-forced
  # Do nothing if not a git repo
  set -l git_root (git rev-parse --show-toplevel ^/dev/null); or return
  # Do nothing if $git_root/.git/noprompt exists
  test -e $git_root/.git/noprompt; and return
  # and __fish_git_prompt
  # and false
  python3 -c '
from subprocess import call, check_output
try:
    call(["env", "NOHUSH=1", "fish", "-c", "__fish_git_prompt"], timeout=0.2)
except:
    print(" (%s)" % "git timeout")
'
end

function status-git
  # Do nothing if NO_PROMPT_GIT globally set
  set -x -q NO_PROMPT_GIT; and exit

  if test "$__status_git_updated" -le (date +%s)
    set -g __status_git (status-git-forced)
    set -g __status_git_updated (date +%s)
  end
  echo -n $__status_git
end

function status-git-nocolor
  status-git | uncolor
end

function status-prommptchar
  echo ' $ '
end
