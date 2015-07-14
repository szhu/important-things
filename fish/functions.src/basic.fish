# alias l   (which ls)
alias l   'ls -FGh'
alias ll  'ls -oFGh'
abbr py  'python'
abbr py3 'python3'

function edit
    eval $EDITOR $argv
end

## finding files

alias find-DS_Store         "find . -name '.DS_Store'   -type f -print"
alias find-AppleDouble      "find . -name '._*'         -type f -print"
alias find-pyc              "find . -name '*.pyc'       -type f -print"
alias find-pycache          "find . -name '__pycache__' -type d -print"
alias find-symlinks         "find .                     -type l -exec ls -l {} \;"
alias find-brokensymlinks   "find . -L                  -type l"
