function fish_mac_icon
  if [ "$TERM_PROGRAM" = 'Apple_Terminal' ]; and [ -z "$INSIDE_EMACS" ]
    if count $__fish_title > /dev/null
        printf "\e]7;file://%s\a" (echo -n $PWD[1] | sed 's/ /%20/g')
    else
        printf "\e]7;\a"
    end
  end
end
