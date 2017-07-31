command -sq rmate; or exit


function rmate
  set -l flags
  contains -- --wait $argv; and set flags $flags --wait
  contains -- -f $argv; and set flags $flags -f

  set -l invoked_rmate
  for arg in $argv
    contains -- --wait $arg; and continue
    contains -- -f $arg; and continue
    set invoked_rmate 1
    command rmate $flags (realpath $arg)
  end

  if test -n invoked_rmate
    rmates-save
  else
    command rmate $argv
  end
end

function rmates-fmt
  pgrep -x rmate | xargs -r ps $argv -p | perl -pe 's#/.*'(which rmate)'.*?/#/#g'
end

function rmates-save
  mkdir -p ~/.local/etc/rmates
  rmates-fmt -o command= > ~/.local/etc/rmates/open-files
end

function rmates-saved
  cat ~/.local/etc/rmates/open-files
end

function rmates-print
  rmates-fmt -o pid= -o command=
end

function rmates-reopen
  for file in (rmates-saved)
    rmate $file
  end
end

alias rmates rmates-print


# alias subl to rmate

function subl
  if set -x -q SSH_CLIENT
    rmate $argv
  else
    command subl $argv
  end
end

alias subls rmates
alias subls-reopen rmates-reopen
alias subls-saved rmates-saved
