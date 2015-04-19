function title
    set -g __fish_title $argv
    if count $argv > /dev/null
        fish_mac_icon $PWD[1]
    else
        fish_mac_icon
    end
end
