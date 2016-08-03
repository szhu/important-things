test (uname) = "Darwin"; or exit


# Apps

function subl
  open -b 'com.sublimetext.3' $argv
end

function finder
  open -b 'com.apple.finder' $argv
end

function reveal
    osascript -e 'launch app id "com.apple.Finder"'
    open -R $argv
end

# function github
#   open -b 'com.github.GitHub' (git rev-parse --show-toplevel)
# end
# abbr gh github

abbr g gitup


# Command line

abbr lc       launchctl
abbr v        chflags -h hidden
abbr V        chflags -h nohidden
abbr aedebug  env AEDebugReceives=1
