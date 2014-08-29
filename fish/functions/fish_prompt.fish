function fish_prompt --description 'Write out the prompt'
  echo '        '

  cd (pwd)

  set -l last_status $status

  # Just calculate these once, to save a few cycles when displaying the prompt
  if not set -q __fish_prompt_hostname
    set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
  end

  if [ "$TERM_PROGRAM" = 'Apple_Terminal' ]; and [ -z "$INSIDE_EMACS" ]
    printf "\e]7;file://%s\a" (echo -n $PWD | sed 's/ /%20/g')
  end

  if not set -q __fish_prompt_normal
    set -g __fish_prompt_normal (set_color normal)
  end

  if not set -q __fish_prompt_cwd
    set -g __fish_prompt_cwd (set_color $fish_color_cwd)
  end

  if [ -n "$SSH_CLIENT" ]; or [ -n "$SSH_TTY" ]
    set_color $fish_color_autosuggestion[1]
    echo -n "$USER@$__fish_prompt_hostname"
    set_color normal
    echo -n ' '
  end

  # PWD
  set_color $fish_color_cwd[1]
  printf '%s' (prompt_pwd)
  set_color normal

  printf '%s ' (__terlar_git_prompt)

  if not [ $last_status -eq 0 ]
    set_color $fish_color_error[1]
  end

  echo
  set_color $fish_color_autosuggestion[1]
  printf '%s ' (date +%H:%M)
  set_color normal
  printf '$ '
end
