if contains $TERM_PROGRAM "vscode"
    is_command code
    and set -Ux EDITOR 'code --wait'
else if contains $TERM_PROGRAM "Apple_Terminal" "iTerm.app"
    is_command nano
    set -Ux EDITOR 'nano'
else
    is_command subl
    and set -Ux EDITOR 'subl --wait'
end
