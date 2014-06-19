function fish_prompt --description 'Write out the prompt'
  echo

  set -l last_status $status

  if [ $TERM_PROGRAM = 'Apple_Terminal' ]; and [ -z '$INSIDE_EMACS' ]
    printf "\e]7;file://%s\a" (echo -n $PWD | sed 's/ /%20/g')
  end

  if not set -q __fish_prompt_normal
    set -g __fish_prompt_normal (set_color normal)
  end

  # PWD
  set_color $fish_color_cwd
  printf '%s' (prompt_pwd)
  set_color normal

  printf '%s ' (__terlar_git_prompt)

  if not test $last_status -eq 0
  set_color $fish_color_error
  end

  echo
  set_color $fish_color_autosuggestion
  printf '%s ' (date +%H:%M)
  set_color normal
  printf '$ '
end
