function pretty_pwd --description 'Print the current working directory'
  echo $PWD | sed -e "s|^$HOME|~|" -e 's|^/private||' # -e 's-\([^/.]\)[^/]*/-\1/-g'
end
