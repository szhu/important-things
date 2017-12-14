is_command rmate; or exit


function rmate
  set -l flags
  set -l files

  for arg in $argv
    if string match -q -- '-*' $arg
      set flags $flags $arg
    else
      set files $files $arg
    end
  end

  if test (count $files) = 0
    command rmate $flags
  else
    for file in $files
      command rmate $flags (realpath $file)
    end
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
