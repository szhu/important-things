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

function status-git
  which git >/dev/null; and __fish_git_prompt
end

function status-git-nocolor
  status-git | uncolor
end

function status-prommptchar
  echo ' $ '
end
