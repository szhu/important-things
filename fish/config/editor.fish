if contains $TERM_PROGRAM "vscode"
    is_command code
    and set -x EDITOR 'code' '--wait'
else if contains $TERM_PROGRAM "Apple_Terminal" "iTerm.app"
    is_command nano
    set -x EDITOR 'nano'
else
    is_command subl
    and set -x EDITOR 'subl' '--wait'
end
