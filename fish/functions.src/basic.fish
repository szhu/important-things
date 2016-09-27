# alias l   (which ls)
alias l  'ls -FGh'
alias ll 'ls -lFGh'
abbr la  l -A
abbr lsa ls -A
abbr lla ll -A
abbr py  'python'
abbr py3 'python3'

function edit
    eval $EDITOR $argv
end

function touchmod
	set -l mode $argv[1]
	set -e argv[1]
	for arg in $argv
		test -e $arg; and echo "The file $arg already exists" >&2; and return 1
		touch -- $arg
		and chmod -- $mode $arg
	end
end

function mkcd
	mkdir -p $argv
	and cd $argv
end

## finding files

alias find-DS_Store         "find . -name '.DS_Store'   -type f -print"
alias find-AppleDouble      "find . -name '._*'         -type f -print"
alias find-pyc              "find . -name '*.pyc'       -type f -print"
alias find-pycache          "find . -name '__pycache__' -type d -print"
alias find-symlinks         "find .                     -type l -exec ls -l {} \;"
alias find-brokensymlinks   "find . -L                  -type l"
