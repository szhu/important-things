function screen-multiplexer--helper -a sshvar -a multiplexervar -a host -a name
    set -e argv[1..4]

    set -l ssh ssh $host -t --
    set -l nossh
    set -l tmux tmux new-session -A -s
    set -l screen scrn -q -d -RR
    if not count $name >/dev/null
        set name main
    end
    echo $$sshvar $$multiplexervar $name $argv >&2
    env -- $$sshvar $$multiplexervar $name $argv
end

function tm --wraps tmux
    screen-multiplexer--helper nossh tmux - $argv
end

function stm --wraps tmux
    screen-multiplexer--helper ssh tmux $argv
end

function sc --wraps screen
    screen-multiplexer--helper nossh screen - $argv
end

function ssc --wraps screen
    screen-multiplexer--helper ssh screen $argv
end
