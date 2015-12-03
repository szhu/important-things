# Backwards compatibility for fish 2.0.0
not contains source (builtin -n)
and alias source .

# Backwards compatibility for fish <2.2.0
not functions -q abbr
and function abbr -a the_alias
    set -e argv[1]
    alias $the_alias "$argv"
end

# Fix for weird bug: find: .: Invalid argument
find /dev/null >/dev/null

for src in (find ~/.config/fish/config -name '*.fish')
    source $src
end
