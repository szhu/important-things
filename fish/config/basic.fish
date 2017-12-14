set -x PATH ~/.local/bin ~/.local/opt/*/bin /usr/local/bin /usr/local/sbin $PATH
set -x LANG 'en_US.UTF-8'

function is_command
  command -s $argv > /dev/null
end

test -e ~/.config/fish/functions/fish_prompt.fish
and source ~/.config/fish/functions/fish_prompt.fish
