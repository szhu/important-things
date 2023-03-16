if contains $TERM_PROGRAM "vscode"
    is_command code
    and set -x EDITOR 'code' '--wait'
else
    if is_command micro
        set -x EDITOR 'micro'
    else if is_command nano
        set -x EDITOR 'nano'
    end
end
