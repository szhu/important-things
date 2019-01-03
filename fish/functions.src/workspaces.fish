function workspaces --wraps git
  is_command workspaces; or command workspaces $argv

  set -l NEW_PWD_FILE (mktemp)
  rm -f "$NEW_PWD_FILE"
  env "NEW_PWD_FILE=$NEW_PWD_FILE" workspaces $argv
  if test -e "$NEW_PWD_FILE"
    cd (cat $NEW_PWD_FILE)
    rm -f "$NEW_PWD_FILE"
  end
end
