# # Overwrite built-in function
# functions -e fish_prompt
#
function fish_prompt --description 'Write out the prompt'
  set -l last_status $status
  test -e (pwd); and cd (pwd)

  # Fish was excessively truncating the prompt, because it doesn't know that the
  # output of fish_prompt__mac_pwd_icon is invisible, so this is disabled for
  # now.
  appleterminal-icon $PWD
  fish_tab_title


  # Begin visible prompt

  clearline

  newline-clearline

  if test $last_status -ne 0
    set_color --reverse red
    status-returncode-error $last_status
    set_color normal

    newline-clearline
    newline-clearline
  end

  if set -q fish_color_autosuggestion
    set_color $fish_color_autosuggestion
  end
  echo -n (status-time)

  echo -n ' '

  echo -n (status-user-hostname-if-remote)

  if set -q fish_color_cwd
    set_color $fish_color_cwd
  end
  echo -n (pwd-forprompt)
  test -e (pwd); or echo -n ' (!)'

  set_color normal
  echo -n (status-git)

  newline-clearline

  if set -q fish_color_autosuggestion
    set_color $fish_color_autosuggestion
  end
  echo -n (status-promptchar)
  set_color normal
end

# Overwrite built-in function
funcsave fish_prompt
