function funcsnuke
  rm -rf -- ~/.config/fish/functions
  for abbr in (abbr -l); abbr -e $abbr; end
end

function funcsupdate
  set -l functions_dir ~/.config/fish/functions/
  set -l builtins (functions -a)

  for src in (find ~/.config/fish/functions.src -name '*.fish')
  set -l pretty_src (string replace -r "^$HOME" '~' $src)
    echo -ne '\r\033[K'
    echo -n "source $pretty_src "
    source $src
  end

  for func in (functions -a)
    contains $func $builtins; and continue
    echo -ne '\r\033[K'
    echo -n "funcsave $func "
    funcsave $func
  end

  echo
end

function funcsreset
  funcsnuke
  set -Ux NOHUSH
  and fish -lc 'funcsupdate'
  set -Uxe NOHUSH  # Force fish to read from disk

  set -Ux NOHUSH
  exec fish
end

function pullover -a repo_path
  test -e repo_path; or return 0

  set -l old_pwd $PWD

  printf '$ cd %s\n' $repo_path
  cd $repo_path; or return
  printf "Git status:%s\n" (status-git-forced)
  echo

  echo '$ git pull'
  git pull; or return
  echo

  cd $old_pwd; or return
end

function funcspull
  pullover ~/.config/fish/functions.src/work; or return
  pullover ~/.local/opt/important-things; or return
end
