test (hostname) = "mac.szhu.me" -o (hostname) = "szhu-c02.local"; or exit

# ------ SYNCING ------ #

## Rsyncer helpers

abbr rs rsyncer
function rs-cd
  if test -z "$argv"
    echo "usage: rs-cd name"
    return 1
  else
    cd (rsyncer $argv[1] pwd)
  end
end
function rs-config
  open ~/".config/rsyncer/hosts.yaml"
end

## Rsyncer aliases

for cmd in int sz cs ee
  abbr   $cmd rsyncer   $cmd
end
for cmd in 61b 164
  abbr cs$cmd rsyncer cs$cmd
  abbr   $cmd rsyncer cs$cmd
end


# ------ SHORTCUTS ------ #

## others

function reapache
  killall httpd
  sleep 0.5
  httpd -f ~/'.local/etc/apache2/httpd.conf'
end


# ------ SWITCH TO ADMIN USER ------ #

set -Ux ADMIN_USER Administrator
set -Ux ADMIN_HOME ~Administrator
set -Ux ADMIN_CD_SCRIPT ~Administrator/.local/bin/launch-with-wd.bash

# This account cannot sudo
abbr sudo '# sudo not allowed'

# Except when it can
function ado-with-wd
  set -l wd $argv[1]; set -e argv[1]
  set -l cmd (which $argv[1]); set -e argv[1]
  test -z "$cmd"; and return 1
  set -q ADMIN_DEBUG
  and echo sudo -u $ADMIN_USER (which login) -fq $ADMIN_USER $ADMIN_CD_SCRIPT $wd $cmd $argv
  sudo -u $ADMIN_USER (which login) -fq $ADMIN_USER $ADMIN_CD_SCRIPT $wd $cmd $argv
end

function ado
  ado-with-wd (pwd) $argv
end

function ado-at-home
  ado-with-wd $ADMIN_HOME $argv
end


# Some shortcuts

function admin
  ado fish
end
abbr a admin

function brew
  ado-at-home brew $argv
end
abbr brewupp 'brew update; and brew upgrade --all --cleanup; and brew cleanup -s --force; and brew cask cleanup'
abbr brewup  'brew update; and brew upgrade --all --cleanup'

function gem
  # if not rvm
  if test (which gem) = /usr/bin/gem
    ado gem $argv
  else
    command gem $argv
  end
end

function npm
  # if --global
  if begin; contains -- -g $argv; or contains -- --global $argv; end
    ado-at-home npm $argv
  else
    command npm $argv
  end
end

function pip
  # if not venv
  if test (which pip) = /usr/local/bin/pip
    ado pip $argv
  else
    command pip $argv
  end
end

function pip2
  # if not venv
  if test (which pip2) = /usr/local/bin/pip2
    ado pip2 $argv
  else
    command pip2 $argv
  end
end

function pip3
  # if not venv
  if test (which pip3) = /usr/local/bin/pip3
    ado pip3 $argv
  else
    command pip3 $argv
  end
end
