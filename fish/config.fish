# Backwards compatibility for fish 2.0.0
not contains source (builtin -n)
and function source
    . $argv
end

for src in ~/.config/fish/config/*.fish
    source $src
end
