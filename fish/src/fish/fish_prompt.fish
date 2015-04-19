set -U __fish_git_prompt_show_informative_status 1
set -U __fish_git_prompt_hide_untrackedfiles 1

set -U __fish_git_prompt_color_branch magenta bold
set -U __fish_git_prompt_showupstream "informative"
set -U __fish_git_prompt_char_upstream_ahead ">"
set -U __fish_git_prompt_char_upstream_behind "<"
set -U __fish_git_prompt_char_upstream_prefix ""

set -U __fish_git_prompt_char_stagedstate ":"
set -U __fish_git_prompt_char_dirtystate "+"
set -U __fish_git_prompt_char_untrackedfiles "~"
set -U __fish_git_prompt_char_conflictedstate ":("
set -U __fish_git_prompt_char_cleanstate "^^"

set -U __fish_git_prompt_color_dirtystate red
set -U __fish_git_prompt_color_stagedstate yellow
set -U __fish_git_prompt_color_invalidstate red
set -U __fish_git_prompt_color_untrackedfiles red
set -U __fish_git_prompt_color_cleanstate green bold


function fish_prompt --description 'Write out the prompt'
  set -l last_status $status
  cd (pwd)
  __fish_prompt_init
  # Fish was excessively truncating the prompt, because it doesn't know that the
  # output of __fish_prompt_mac_pwd_icon is invisible, so this is disabled for
  # now.
  # fish_mac_icon $argv[1]

  echo '        '
  __fish_prompt_status_if_error $last_status

  __fish_prompt_user_hostname
  __fish_pretty_pwd
  __fish_git_prompt
  
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

function __fish_prompt_user_hostname
  echo -n $__fish_prompt_user_hostname
end

function __fish_pretty_pwd
  set -l long (pretty_pwd)
  set -l short (pretty_pwd_short)

  if [ (math (echo -n "$long" | wc -m)" + 10 < $COLUMNS") = 1 ]
    echo_with_color $fish_color_cwd[1] (pretty_pwd)
  else
    echo_with_color $fish_color_cwd[1] (pretty_pwd_short)
  end
end

function __fish_prompt_time
  echo_with_color $fish_color_autosuggestion[1] (date +%H:%M)
end

set -U __fish_prompt_normal (set_color normal)
set -U __fish_prompt_cwd (set_color $fish_color_cwd)


function __fish_prompt_init
  # Just calculate these once, to save a few cycles when displaying the prompt
  if not set -q __fish_prompt_user_hostname
    if [ -n "$SSH_CLIENT" ]; or [ -n "$SSH_TTY" ]
      set -g __fish_prompt_user_hostname (set_color $fish_color_autosuggestion[1])"$USER@"(hostname|cut -d . -f 1)(set_color normal)" "
    end
  end
end

function echo_with_color
  set_color $argv[1]
  echo -n $argv[2]
  set_color normal
end
