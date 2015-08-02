test (hostname) = "mac.szhu.me"; or exit

alias a "command ssh -q a@localhost"

# ------ SYNCING ------ #

## Rsyncer helpers

abbr rs rsyncer
function rs-cd
    if [ (count $argv) -lt 1 ]
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
    abbr $cmd rsyncer $cmd
end
for cmd in 199
    abbr cs$cmd rsyncer cs$cmd
    eval "
    function cs$cmd-host
        set servername \$argv[1]
        set -e argv[1]
        env servername=\$servername rsyncer cs$cmd \$argv
    end"
    abbr $cmd cs$cmd
    abbr $cmd-host cs$cmd-host
end

# abbr dcmount='sshfs -p 2222 root@localhost:/srv/wp ~/.Volumes/dailycal-vagrant -o volname=devkit'
function dcvm
    set -l oldcwd (pwd)
    cdto ~/Code dev-kit
    vagrant $argv
    cd $oldcwd
end

# set HIVE_ROOT_61C ~/'Dropbox/School/2013-2014/CS 61C LA/cs61c-lc'
# abbr hiveclone61c='cd "$HIVE_ROOT_61C"; bash "$HIVE_ROOT_61C/code/mygit" clone'
# set HIVE_ROOT_188 ~/'Dropbox/School/2013-2014/CS 188/ee130-aw'
# abbr hiveclone188='cd "$HIVE_ROOT_188"; bash "$HIVE_ROOT_188/code/mygit" clone'


# ------ SHORTCUTS ------ #

## others

function reapache
    killall httpd
    sleep 0.5
    httpd -f ~/'.local/etc/apache2/httpd.conf'
end

# function ado
#     if [ (count $argv) -eq 0 ]
#         nc -U /usr/local/var/adminer
#     else
#         echo -e "$argv" | nc -U /usr/local/var/adminer
#     end
# end

# Normal
for cmd in brew brewup npm
    eval "function sudo$cmd; ado \"$cmd \$argv\"; end"
end

# Be interactive for these
for cmd in pip pip3
    eval "function sudo$cmd; ado -i \"$cmd \$argv\"; end"
end

# Use current cd for these
for cmd in gem bundle
    eval "function sudo$cmd; ado \"cd \\\"\$PWD\\\"\" \"and $cmd \$argv\"; end"
end

# for cmd in brew npm pip pip3 gem bundle
#     alias my$cmd (which $cmd)
# end
