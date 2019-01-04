# Hostnames

function status-is-remote
  test -n "$SSH_CLIENT"; or test -n "$SSH_TTY"
end

# set -Ux PROMPT_HOSTNAME_PARTS 1-2
function status-hostname
  set -xq PROMPT_HOSTNAME_PARTS; or set -l PROMPT_HOSTNAME_PARTS 1
  hostname | cut -d . -f "$PROMPT_HOSTNAME_PARTS"
end

function status-user-hostname
  set -gq status__user_hostname
  or set -g status__user_hostname $USER@(status-hostname)
  echo $status__user_hostname
end

function status-user-hostname-if-remote
  if status-is-remote
    set_color $fish_color_autosuggestion[1]
    echo (status-user-hostname) ''
  end
end

function status-user-hostname-nocolor
  if command -s uncolor >/dev/null
    status-user-hostname-if-remote | uncolor
  else
    status-user-hostname-if-remote
  end
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
  # Do nothing if $GIT_NO_PROMPT contains $PWD
  for loc in $GIT_NO_PROMPT
    echo $PWD | grep -Fq $loc; and return
  end
  # Do nothing if not a git repo
  set -l git_root (git rev-parse --show-toplevel 2>/dev/null); or return
  # Do nothing if $git_root/.git/noprompt exists
  test -e $git_root/.git/noprompt; and return
  # and __fish_git_prompt
  # and false
  if is_command timeout
    timeout 0.2 fish -c "__fish_git_prompt"
  else if is_command gtimeout
    gtimeout 0.2 fish -c "__fish_git_prompt"
  else
    __fish_git_prompt
  end
end

function status-git-outofdate
  # Out of date if timestamp not set
  not set -q __status_git_updated
  and return 0

  # Out of date if timestamp older that current time
  test "$__status_git_updated" -le (date +%s)
  and return 0

  return 1
end

function status-git-touch
  set -g __status_git_updated (date +%s)
end

function status-git
  # Do nothing if NO_PROMPT_GIT globally set
  set -x -q NO_PROMPT_GIT; and exit

  status-git-outofdate
  and set -g __status_git (status-git-forced)
  and status-git-touch

  echo -n $__status_git
end

function status-git-nocolor
  if is_command uncolor
    status-git | uncolor
  else
    status-git
  end
end

function status-prommptchar
  echo ' $ '
end
