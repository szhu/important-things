function fish_mac_icon
  if [ "$TERM_PROGRAM" = 'Apple_Terminal' ]; and [ -z "$INSIDE_EMACS" ]
    if count $argv > /dev/null
        printf "\e]7;file://%s\a" (echo -n $argv[1] | sed 's/ /%20/g')
    else
        printf "\e]7;\a"
    end
  end
end
