function fish_prompt-init
  # Just calculate these once, to save a few cycles when displaying the prompt
  set -q fish_prompt__user_hostname; and return

  if [ -n "$SSH_CLIENT" ]; or [ -n "$SSH_TTY" ]
    set -g fish_prompt__user_hostname "$USER@"(hostname|cut -d . -f 1)" "
    set -g __fish_title_hostname (hostname | cut -d . -f 1):
  end
end

function fish_prompt --description 'Write out the prompt'
  set -l last_status $status
  cd (pwd)

  # Fish was excessively truncating the prompt, because it doesn't know that the
  # output of fish_prompt__mac_pwd_icon is invisible, so this is disabled for
  # now.
  appleterminal-icon $PWD
  fish_tab_title


  # Begin visible prompt

  clearline

  newline-clearline

  if test $last_status -ne 0
    set_color red
    status-returncode-error $last_status

    newline-clearline
    newline-clearline
  end

  if status-is-remote
    set_color $fish_color_autosuggestion[1]
    echo -n (status-user-hostname) ''
  end

  set_color $fish_color_cwd
  echo -n (pwd-forprompt)

  set_color normal
  echo -n (status-git)

  newline-clearline

  set_color $fish_color_autosuggestion[1]
  echo -n (status-time)

  set_color normal
  echo -n (status-prommptchar)
end
# Overwrite built-in function
funcsave fish_prompt