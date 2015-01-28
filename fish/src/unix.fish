alias ls  'ls -FGh'
alias ll  'ls -oFGh'
alias py  'python'
alias py3 'python3'

function cattail
    cat $argv
    and tail -f -n 0 $argv
end

function edit
    env (echo $EDITOR | tr ' ' '\n') $argv
end
