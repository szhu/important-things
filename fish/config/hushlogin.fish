if set -q NOHUSH
    set -e NOHUSH
else
    test -e ~/.hushlogin
    and sleep 0
    and echo -ne  '\\033c'
end
