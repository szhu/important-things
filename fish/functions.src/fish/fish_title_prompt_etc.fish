set -U __fish_git_prompt_show_informative_status 1
set -U __fish_git_prompt_hide_untrackedfiles 1

set -U __fish_git_prompt_showupstream "informative"
set -U __fish_git_prompt_char_upstream_ahead ">"
set -U __fish_git_prompt_char_upstream_behind "<"
set -U __fish_git_prompt_char_upstream_prefix ""

set -U __fish_git_prompt_char_stagedstate ":"
set -U __fish_git_prompt_char_dirtystate "+"
set -U __fish_git_prompt_char_untrackedfiles "~"
set -U __fish_git_prompt_char_conflictedstate ":("
set -U __fish_git_prompt_char_cleanstate "^^"

set -U __fish_git_prompt_color_branch "magenta" "--bold"
set -U __fish_git_prompt_color_dirtystate "red"
set -U __fish_git_prompt_color_stagedstate "yellow"
set -U __fish_git_prompt_color_invalidstate "red"
set -U __fish_git_prompt_color_untrackedfiles "red"
set -U __fish_git_prompt_color_cleanstate "green" "--bold"


function fish_prompt --description 'Write out the prompt'
  set -l last_status $status
  cd (pwd)
  __fish_prompt_init
  fish_mac_icon
  fish_mac_tab_title

  echo -ne '\r\033[K\n\033[K'
  __fish_prompt_status_if_error $last_status

  __fish_prompt_user_hostname
  __fish_pretty_pwd
  which git >/dev/null; and __fish_git_prompt

  echo
  echo -ne '\033[K'

  __fish_prompt_time
  echo -ne '\033[K'
  echo -n ' $ '
end

function __fish_prompt_status_if_error -a errno
  test $errno -eq 0; and return
  echo (set_color red)"[Error $errno]"(set_color normal)
  echo
end

function __fish_prompt_user_hostname
  echo -n $__fish_prompt_user_hostname
end

function __fish_pretty_pwd
  set -l long (pretty_pwd)
  set -l short (pretty_pwd_short)

  if [ (math (echo -n $long | wc -m)" + 10 < $COLUMNS") = 1 ]
    echo -n (set_color $fish_color_cwd)(pretty_pwd)(set_color normal)
  else
    echo -n (set_color $fish_color_cwd)(pretty_pwd_short)(set_color normal)
  end
end

function __fish_prompt_time
  echo -n (set_color $fish_color_autosuggestion)(date +%H:%M)(set_color normal)
end

function __fish_prompt_init
  # Just calculate these once, to save a few cycles when displaying the prompt
  if not set -q __fish_prompt_user_hostname
    if [ -n "$SSH_CLIENT" ]; or [ -n "$SSH_TTY" ]
      set -g __fish_prompt_user_hostname (set_color $fish_color_autosuggestion[1])"$USER@"(hostname|cut -d . -f 1)(set_color normal)" "
      set -g __fish_title_hostname (hostname | cut -d . -f 1):
    end
  end
end

function pretty_pwd --description 'Print the current working directory'
	echo $PWD | sed -e "s|^$HOME|~|" -e 's|^/private||' # -e 's-\([^/.]\)[^/]*/-\1/-g'
end

function pretty_pwd_short --description 'Print the current working directory, shortened to fit the prompt'
  echo $PWD | sed -e "s|^$HOME|~|" -e 's|^/private||' -e 's-\([^/.]\)[^/]*/-\1/-g'
end

function pwd_basename
	echo $PWD | xargs basename
end


function fish_mac_icon
  if [ "$TERM_PROGRAM" = 'Apple_Terminal' ]; and [ -z "$INSIDE_EMACS" ]
    printf "\e]7;file://%s\a" (echo -n $PWD[1] | sed 's/ /%20/g')
  end
  true
end

# http://superuser.com/q/223308#comment352223_223314
function fish_mac_tab_title
  if count $__fish_title > /dev/null
    printf "\033]1;%s\007" "$__fish_title"
  else
    printf "\033]1;%s\007" (pwd_basename)
  end  
end

function fish_title --description 'Write out the title'
  if count $__fish_title > /dev/null
      echo -n "$__fish_title"
  else
      echo -n
  end
end

function title --description 'Set a manual window title'
  set -g __fish_title $argv
end
