function funcsnuke
    rm -rf -- ~/.config/fish/functions
end

function funcsupdate
    set functions_dir ~/.config/fish/functions/
    set excluded_functions . __fish_git_prompt

    for src in (find ~/.config/fish/functions.src -name '*.fish')
        echo 'source:' $src
        source $src
    end
    or return 1

    for func in (functions -a)
        echo 'save:' $func
        not contains $func $excluded_functions
        and functions -q $func
        and funcsave $func
    end
end

function funcsreset
    funcsnuke
    and funcsupdate
end