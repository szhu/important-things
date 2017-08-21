function uncolor-if-possible
  if begin; command -sq perl; and command -sq uncolor; end
    # ok great
    uncolor
  else
    # if not is ok too
    cat
  end
end

function pwd-pretty --description 'Print the current working directory'
  set -l str (pwd)
  set -l str (string replace -r "^$HOME" '~' $str)
  set -l str (string replace -r "^/private" '' $str)
  echo $str
end

function pwd-pretty-short --description 'Print the current working directory, shortened to fit the prompt'
  set -l str (pwd-pretty)
  set -l str (string replace -r --all '([^/.])[^/]*/' '$1/' $str)
  echo $str
end

function pwd-basename
	echo $PWD | xargs -0 basename
end

function pwd-forprompt
  set -l long (pwd-pretty)
  set -l short (pwd-pretty-short)

  set -l longprompt (status-user-hostname-if-remote) $long (status-git)
  set -l longpromptcols (math (echo $longprompt | uncolor-if-possible | wc -m))
  if test "$longpromptcols" -le "$COLUMNS"
    echo $long
  else
    echo $short
  end
end
