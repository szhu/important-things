# alias l   (which ls)
alias l   'ls -FGh'
alias ll  'ls -oFGh'
alias py  'python'
alias py3 'python3'

function edit
    eval $EDITOR $argv
end

## finding files

alias find_DS_Store         "find . -name '.DS_Store'   -type f -print"
alias find_AppleDouble      "find . -name '._*'         -type f -print"
alias find_pyc              "find . -name '*.pyc'       -type f -print"
alias find_pycache          "find . -name '__pycache__' -type d -print"
alias find_symlinks         "find .                     -type l -exec ls -l {} \;"
alias find_brokensymlinks   "find . -L                  -type l"
