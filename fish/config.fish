set -x PATH ~/.local/bin ~/.local/opt/*/bin /usr/local/bin /usr/local/sbin $PATH


function funcmarkset
    set -g __functions_old (mktemp /tmp/fish.funcmark.XXXXXX)
    functions -a > $__functions_old
end

function funcmarkdiff
    set -l __functions_new (mktemp /tmp/fish.funcmark.XXXXXX)
    functions -a > $__functions_new
    diff --changed-group-format='%>' --unchanged-group-format='' $__functions_old $__functions_new
    echo -n
end

function funcmarksave
    for func in (funcmarkdiff)
        funcsave $func
    end
end

function funcnuke
    set functions_dir ~/.config/fish/functions
    rm -v $argv -- $functions_dir
end

function update-functions
    set functions_dir ~/.config/fish/functions/
    set srcs ~/.config/fish/src/*.fish ~/.config/fish/src/*/*.fish

    funcmarkset

    mkdir -p $functions_dir
    cp ~/.config/fish/src/fish/* $functions_dir
    for src in $srcs
        source $src
    end

    funcmarksave
end

function reset-functions
    funcnuke $argv
    and update-functions
end
