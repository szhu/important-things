function funcsnuke
    rm -rf -- ~/.config/fish/functions
    for abbr in (abbr -l); abbr -e $abbr; end
end

function funcsupdate
    set -l functions_dir ~/.config/fish/functions/
    # set -l excluded_functions . _ __fish_pwd __fish_git_prompt abbr alias eval funced funcsave funcsnuke funcsupdate funcsreset math
    set -l excluded_functions (functions -a)

    for src in (find ~/.config/fish/functions.src -name '*.fish')
        echo -ne '\r\033[K'
        echo -n 'source' $src ''
        source $src
    end

    for func in (functions -a)
        contains $func $excluded_functions; and continue
        # echo $func | grep -q '^__fish_'; and continue
        not functions -q $func; and continue
        echo -ne '\r\033[K'
        echo -n 'save' $func ''
        funcsave $func
    end

    echo
end

function funcsreset
    funcsnuke
    set -Ux NOHUSH
    and fish -lc 'funcsupdate'
    set -Uxe NOHUSH  # Force fish to read from disk

    set -Ux NOHUSH
    exec fish
end
