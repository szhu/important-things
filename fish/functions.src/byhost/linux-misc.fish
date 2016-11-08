command -s gvfs-trash >/dev/null
and alias trash gvfs-trash


command -s rmate >/dev/null
and function subl
    if set -x -q SSH_CLIENT
        if contains -- --wait $argv
            rmate $argv
        else if not count $argv >/dev/null
            rmate $argv
        else
            for arg in $argv
                rmate $arg
            end
        end
    else
        command subl $argv
    end
end
