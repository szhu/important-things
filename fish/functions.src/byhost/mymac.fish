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
    and echo sudo -u $ADMIN_USER (which login) -f $ADMIN_USER $ADMIN_CD_SCRIPT $wd $cmd $argv
    sudo -u $ADMIN_USER (which login) -f $ADMIN_USER $ADMIN_CD_SCRIPT $wd $cmd $argv
end

function ado
    ado-with-wd (pwd) $argv
end

# Some shortcuts
# alias admin "command ssh -q admin@localhost"
alias admin "ado fish"
abbr a admin
alias brew 'ado-with-wd $ADMIN_HOME brew'
