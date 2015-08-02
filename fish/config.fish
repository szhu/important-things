# Backwards compatibility for fish 2.0.0
not contains source (builtin -n)
and alias source .

for src in (find ~/.config/fish/config -name '*.fish')
    source $src
end
