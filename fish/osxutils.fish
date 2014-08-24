#!/usr/bin/env fish

# set -U SUDOER Administrator

# These functions take advantage of mdfind(1), a command line front-end to the Spotlight metadata framework.

function __osxutils_usage
    echo "usage: $argv" >&2
    return 1
end

function folders
    test (count $argv) -lt 2 ; and return (__osxutils_usage 'folders scope query')
    set -l onlyin $argv[1] ; set -e argv[1]
    mdfind -onlyin $onlyin 'kind:folder' -name "$argv"
end

function folder
    # $ cdto ~ launchagents
    # ~/Library/LaunchAgents
    test (count $argv) -lt 2 ; and return (__osxutils_usage 'folder scope query')
    set -l onlyin $argv[1] ; set -e argv[1]
    set -l output ( folders $onlyin "$argv" | __folder_select_algorithm )
    if [ -z $output ] ; return 1 ; end
    echo $output
end

function __folder_select_algorithm
    # Picks first Spotlight result
    # head -1
    # Picks shortest path
    # http://superuser.com/questions/135753
    awk '(NR == 1 || length < length(shortest)) { shortest = $0 } END { print shortest }'
    # Picks shortest path out of top 100 Spotlight results
    # head -100 | awk '(NR == 1 || length < length(shortest)) { shortest = $0 } END { print shortest }'
end

function cdto
    # $ cdto ~ launchagents; and pwd
    # ~/Library/LaunchAgents
    test (count $argv) -lt 2; and return (__osxutils_usage 'cdto scope query')
    set -l onlyin $argv[1] ; set -e argv[1]
    set -l path (folder $onlyin $argv) ; or return 1
    cd $path
end

alias cdto.='cdto .'
alias cdto~='cdto ~'

function pathtoapp
    # $ pathtoapp term
    # /Applications/Utilities/Terminal.app
    # $ pathtoapp keep
    # /Users/USER/Applications/Chrome Apps.localized/Default hmjkmjkepdijhoojdojkdfohbdgmmhki.app
    set -l path (mdfind 'kind:application' -name "$argv" | head -1)
    [ -z $path ] ; or [ $path = "/" ] ; and return 1
    echo $path
end
function appexecutable
    # $ appexecutable term
    # /Applications/Utilities/Terminal.app/Contents/MacOS/Terminal
    set -l path (pathtoapp $argv) ; or return 1
    set -l executable (defaults read "$path/Contents/Info" CFBundleExecutable)
    [ -z $executable ] ; and return 1
    echo "$path/Contents/MacOS/$executable"
end

function launch
    set -l executablepath (appexecutable $argv) ; or return 1
    echo $executablepath ; and \
    env $executablepath
end
function sudolaunch
    set -l executablepath (appexecutable $argv) ; or return 1
    echo $executablepath ; and \
    if [ -z $SUDOER ]
        sudo $executablepath
    else
        su $SUDOER -c 'sudo "'$executablepath'"'
    end
end

function quit
    set -l path (pathtoapp $argv) ; or return 1
    osascript -e 'quit app "'$path'"'
end
function idof
    # $ idof term
    # com.apple.Terminal
    set -l path (pathtoapp $argv) ; or return 1
    osascript -e 'id of app "'$path'"'
end

alias finder 'open -b com.apple.finder'
alias reveal 'open -R'
