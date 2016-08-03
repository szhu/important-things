function fish_title --description 'Write out the title'
  if count $__fish_title > /dev/null
      echo -n "$__fish_title"
  else
      echo
  end
end
# Overwrite the built-in function
funcsave fish_title

# http://superuser.com/q/223308#comment352223_223314
function fish_tab_title
  if count $__fish_title > /dev/null
    appleterminal-tabtitle $__fish_title
  else
    appleterminal-tabtitle (pwd-basename)
  end  
end

function title --description 'Set a manual window title'
  set -g __fish_title $argv
end

# When running these programs, the working dir isn't relevant
for cmd in vagrant rsyncer ssh
    eval "
    function $cmd
        set -l old_title \$__fish_title
        title $cmd
        command $cmd \$argv
        title $old_title
    end"
end
