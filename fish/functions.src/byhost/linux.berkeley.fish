test (uname) = "Linux"; or exit
hostname | grep -q '.cs.berkeley.edu$'; or exit

set SUBL ~/.local/share/sublime-text-3/sublime_text

alias subl $SUBL

if [ -n "$SSH_CLIENT" ]; or [ -n "$SSH_TTY" ]
	set -x EDITOR nano
else
	set -x EDITOR $SUBL --wait
end

function screen
	if count $argv > /dev/null
		command screen $argv
	else
		command screen ~/.local/bin/fish
	end
end
