function appleterminal-icon -a path
  test "$TERM_PROGRAM" != 'Apple_Terminal'; and return 0
  test -n "$INSIDE_EMACS"; and return 0

  printf "\e]7;file://%s\a" (echo -n "$path" | sed 's/ /%20/g')
end

# http://superuser.com/q/223308#comment352223_223314
function appleterminal-tabtitle -a title
  test "$TERM_PROGRAM" != 'Apple_Terminal'; and return 0

  printf "\033]1;%s\007" "$title"
end
