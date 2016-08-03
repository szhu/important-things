function pwd-pretty --description 'Print the current working directory'
	echo $PWD | sed -e "s|^$HOME|~|" -e 's|^/private||' # -e 's-\([^/.]\)[^/]*/-\1/-g'
end

function pwd-pretty-short --description 'Print the current working directory, shortened to fit the prompt'
  echo $PWD | sed -e "s|^$HOME|~|" -e 's|^/private||' -e 's-\([^/.]\)[^/]*/-\1/-g'
end

function pwd-basename
	echo $PWD | xargs basename
end

function pwd-forprompt
  set -l long (pwd-pretty)
  set -l short (pwd-pretty-short)

  if [ (math (echo -n $long | wc -m)" + 10 < $COLUMNS") = 1 ]
    echo -n $short
  else
    echo -n $long
  end
end
