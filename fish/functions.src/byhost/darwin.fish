test (uname) = "Darwin"; or exit

# set -U SUDOER Administrator

# These functions take advantage of mdfind(1), a command line front-end to the Spotlight metadata framework.

function __osxutils_usage
    echo "usage: $argv" >&2
    return 1
end

function __folder_search_mdfind -a scope -a query
    mdfind -onlyin $scope 'kind:folder' -name $query | __folder_select_algorithm
end

function __folder_search_exactmatch -a scope -a query
    echo (cd $scope ^&-; cd $query ^&-; and pwd)
end

function folder
    set -l scope .
    while test (count $argv) -gt 0
        set -l query $argv[1]
        # echo >&2 DEBUG folder $scope $query
        set -l result
        test -z "$result"; and set result (__folder_search_exactmatch $scope $query)
        test -z "$result"; and set result (__folder_search_mdfind $scope $query)
        test -z "$result"; and return 1
        set scope $result
        set -e argv[1]
    end
    echo $scope
end

function __folder_select_algorithm
    # Picks first Spotlight result
    head -1

    # Picks shortest path
    # http://superuser.com/questions/135753
    # awk '(NR == 1 || length < length(shortest)) { shortest = $0 } END { print shortest }'

    # Picks shortest path out of top 100 Spotlight results
    # head -100 | awk '(NR == 1 || length < length(shortest)) { shortest = $0 } END { print shortest }'

    # head -5 | awk '(NR == 1 || length < length(shortest)) { shortest = $0 } END { print shortest }'
end

function cdto
    set -l result (folder $argv)
    test -n "$result"; and cd $result
end

abbr cdto~ cdto '~'

function pathtoapp
    # $ pathtoapp term
    # /Applications/Utilities/Terminal.app
    # $ pathtoapp keep
    # /Users/USER/Applications/Chrome Apps.localized/Default hmjkmjkepdijhoojdojkdfohbdgmmhki.app
    set -l path (mdfind 'kind:application' -name "$argv" | head -1)
    [ -z $path ]; or [ $path = "/" ]; and return 1
    echo $path
end
function appexecutable
    # $ appexecutable term
    # /Applications/Utilities/Terminal.app/Contents/MacOS/Terminal
    set -l path (pathtoapp $argv); or return 1
    set -l executable (defaults read "$path/Contents/Info" CFBundleExecutable)
    [ -z $executable ]; and return 1
    test -e "$path/Contents/MacOS/$executable"; and echo "$path/Contents/MacOS/$executable"; and return
    test -e "$path/Contents/$executable"; and echo "$path/Contents/$executable"; and return
    return 1
end

function launch
    set -l apppath (pathtoapp $argv[1]); or return 1
    set -e argv[1]
    echo open $apppath --args $argv
    open $apppath --args $argv
end
function sudolaunch
    set -l executablepath (appexecutable $argv); or return 1
    echo $executablepath
    and if [ -z $SUDOER ]
        sudo $executablepath
    else
        su $SUDOER -c 'sudo "'$executablepath'"'
    end
end

function quit
    # set -l path (pathtoapp $argv); or set -l path $argv
    osascript -e 'quit app "'$argv'"'
end
function idof
    # $ idof term
    # com.apple.Terminal
    set -l path (pathtoapp $argv); or return 1
    osascript -e 'id of app "'$path'"'
end

alias subl   'open -b com.sublimetext.3'
alias finder 'open -b com.apple.finder'
alias github 'open -b com.github.GitHub (git rev-parse --show-toplevel)'
# abbr gh github
abbr g gitup
function reveal
    osascript -e 'launch app id "com.apple.Finder"'
    open -R $argv
end
abbr lc     'launchctl'

## Mac OS

abbr       v chflags -h hidden
abbr       V chflags -h nohidden
abbr aedebug env AEDebugReceives=1

for cmd in vagrant rsyncer ssh
    eval "
    function $cmd
        set -l old_title \$__fish_title
        title $cmd
        command $cmd \$argv
        title $old_title
    end"
end
