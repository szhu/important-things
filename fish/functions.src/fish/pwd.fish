function pwd-pretty --description 'Print the current working directory'
	echo -n $PWD | sed -e "s|^$HOME|~|" -e 's|^/private||' # -e 's-\([^/.]\)[^/]*/-\1/-g'
end

function pwd-pretty-short --description 'Print the current working directory, shortened to fit the prompt'
  echo -n $PWD | sed -e "s|^$HOME|~|" -e 's|^/private||' -e 's-\([^/.]\)[^/]*/-\1/-g'
end

function pwd-basename
	echo -n $PWD | xargs -0 basename
end

function pwd-forprompt
  set -l long (pwd-pretty)
  set -l short (pwd-pretty-short)

  if test (math (echo -n $long | wc -m)" + "(status-git-nocolor | wc -m)) -le $COLUMNS
    echo $long
  else
    echo $short
  end
end
