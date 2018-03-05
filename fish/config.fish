status --is-interactive; or status --is-login; or exit

set -x PATH ~/.local/bin ~/.local/opt/*/bin /usr/local/bin $PATH
set -x LANG 'en_US.UTF-8'

# Backwards compatibility for fish 2.0.0
not contains source (builtin -n)
and alias source .

# Backwards compatibility for fish <2.2.0
not functions -q abbr
and function abbr -a the_alias
    set -e argv[1]
    alias $the_alias "$argv"
end

# Abstracting this command so it can be changed to command -sq $argv once older versions
# of fish are phased out
function is_command
  command -s $argv > /dev/null
end

# Fix for weird bug: find: .: Invalid argument
find /dev/null >/dev/null

for src in (find ~/.config/fish/config -name '*.fish')
    source $src
end
