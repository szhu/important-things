function fish_prompt --description 'Write out the prompt'
  set -l last_status $status
  cd (pwd)
  __fish_prompt_init
  # Fish was excessively truncating the prompt, because it doesn't know that the
  # output of __fish_prompt_mac_pwd_icon is invisible, so this is disabled for
  # now.
  # __fish_prompt_mac_pwd_icon

  echo '        '
  __fish_prompt_status_if_error $last_status

  __fish_prompt_user_hostname
  __fish_prompt_pwd
  __fish_prompt_git
  
  echo

  __fish_prompt_time
  echo -n ' $ '
end

function __fish_prompt_status_if_error
  if not [ $argv[1] -eq 0 ]
    echo_with_color $fish_color_error[1] "[Error $argv[1]]"
    echo
    echo
  end
end

function __fish_prompt_mac_pwd_icon
  if [ "$TERM_PROGRAM" = 'Apple_Terminal' ]; and [ -z "$INSIDE_EMACS" ]
    printf "\e]7;file://%s\a" (echo -n $PWD | sed 's/ /%20/g')
  end
end

function __fish_prompt_user_hostname
  echo -n $__fish_prompt_user_hostname
end

function __fish_prompt_pwd
  set -l long (prompt_pwd)
  set -l short (prompt_pwd_short)

  if [ (math (echo -n "$long" | wc -m)" + 10 < $COLUMNS") = 1 ]
    echo_with_color $fish_color_cwd[1] (prompt_pwd)
  else
    echo_with_color $fish_color_cwd[1] (prompt_pwd_short)
  end
end

function __fish_prompt_git
  __terlar_git_prompt
end

function __fish_prompt_time
  echo_with_color $fish_color_autosuggestion[1] (date +%H:%M)
end


function __fish_prompt_init
  if not set -q __fish_prompt_initialized
    # Just calculate these once, to save a few cycles when displaying the prompt
    if not set -q __fish_prompt_user_hostname
      if [ -n "$SSH_CLIENT" ]; or [ -n "$SSH_TTY" ]
        set -g __fish_prompt_user_hostname (set_color $fish_color_autosuggestion[1])"$USER@"(hostname|cut -d . -f 1)(set_color normal)" "
      end
    end

    if not set -q __fish_prompt_normal
      set -g __fish_prompt_normal (set_color normal)
    end

    if not set -q __fish_prompt_cwd
      set -g __fish_prompt_cwd (set_color $fish_color_cwd)
    end

    set -g __fish_prompt_initialized 1
  end
end

function echo_with_color
  set_color $argv[1]
  echo -n $argv[2]
  set_color normal
end
