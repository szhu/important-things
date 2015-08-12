test (hostname) = "mac.szhu.me"; or exit

abbr a admin
alias admin "command ssh -q admin@localhost"

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
    abbr   $cmd exec rsyncer   $cmd
end
for cmd in 199
    abbr cs$cmd exec rsyncer cs$cmd
    abbr   $cmd exec rsyncer cs$cmd
end


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
