command -s gvfs-trash >/dev/null
and alias trash gvfs-trash


command -s rmate >/dev/null
and function subl
    if set -x -q SSH_CLIENT
        rmate $argv
    else
        command subl $argv
    end
end
