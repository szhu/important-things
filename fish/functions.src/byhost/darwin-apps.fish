test (uname) = "Darwin"; or exit


# App-finding magic

function apps-pathto
  # $ apps-pathto term
  # /Applications/Utilities/Terminal.app
  # $ apps-pathto keep
  # /Users/USER/Applications/Chrome Apps.localized/Default hmjkmjkepdijhoojdojkdfohbdgmmhki.app
  set -l path (mdfind 'kind:application' -name "$argv" | head -1)
  [ -z $path ]; or [ $path = "/" ]; and return 1
  echo $path
end

function apps-pathtoexe
  # $ apps-pathtoexe term
  # /Applications/Utilities/Terminal.app/Contents/MacOS/Terminal
  set -l path (apps-pathto $argv); or return 1
  set -l executable (defaults read "$path/Contents/Info" CFBundleExecutable)
  [ -z $executable ]; and return 1
  test -e "$path/Contents/MacOS/$executable"; and echo "$path/Contents/MacOS/$executable"; and return
  test -e "$path/Contents/$executable"; and echo "$path/Contents/$executable"; and return
  return 1
end

function apps-launch
  set -l apppath (apps-pathto $argv[1]); or return 1
  set -e argv[1]
  echo open $apppath --args $argv
  open $apppath --args $argv
end

function apps-launchexe 
  set -l appexe (apps-pathtoexe $argv[1]); or return 1
  set -e argv[1]
  echo env $appexe $argv
  env $appexe $argv
end

function apps-sudolaunch
  set -l executablepath (apps-pathtoexe $argv); or return 1
  echo $executablepath
  and if [ -z $SUDOER ]
    sudo $executablepath
  else
    su $SUDOER -c 'sudo "'$executablepath'"'
  end
end

function apps-quit
  # set -l path (apps-pathto $argv); or set -l path $argv
  osascript -e 'quit app "'$argv'"'
end
alias quit apps-quit

function apps-idof
  # $ idof term
  # com.apple.Terminal
  set -l path (apps-pathto $argv); or return 1
  osascript -e 'id of app "'$path'"'
end
alias idof apps-idof
