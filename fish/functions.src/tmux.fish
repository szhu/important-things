function tm
    if test (count $argv) = 0
        set argv main
    end
    # screen -d -RR $argv
    tmux new-session -A -s $argv
end

function stm
    set -l host $argv[1]
    set -e argv[1]

    if test (count $argv) = 0
        set argv main
    end
    # ssh $host -t -- screen -d -RR $argv $argv
    ssh $host -t -- tmux new-session -A -s $argv
end
