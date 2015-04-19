set -x PATH ~/.local/bin ~/.local/opt/*/bin /usr/local/bin /usr/local/sbin $PATH
set -X LANG 'en_US.UTF-8'
set -g functions_builtins hostname la ll ls man

function __funcssetmark
    set -g __functions_old (mktemp /tmp/fish.funcmark.XXXXXX)
    functions -a > $__functions_old
end

function __funcsdiffmark
    set -l __functions_new (mktemp /tmp/fish.funcmark.XXXXXX)
    functions -a > $__functions_new
    diff --changed-group-format='%>' --unchanged-group-format='' $__functions_old $__functions_new
    echo -n
end

function __funcsmarksave
    for func in (__funcsdiffmark)
        funcsave $func
    end
    for func in $functions_builtins
        if functions -q $func
            funcsave $func
        end
    end
end

function funcsnuke
    set functions_dir ~/.config/fish/functions
    rm -rf $argv -- $functions_dir
end

function funcsupdate
    set functions_dir ~/.config/fish/functions/
    set srcs ~/.config/fish/src/*.fish ~/.config/fish/src/*/*.fish
    if [ (uname) = "Darwin" ]
        set srcs $srcs ~/.config/fish/src.local/osx.fish
    else if [ (uname) = "Linux" ]
        set srcs $srcs ~/.config/fish/src.local/linux.fish
    end

    __funcssetmark

    mkdir -p $functions_dir
    cp ~/.config/fish/src/fish/* $functions_dir
    for src in $srcs
        source $src
    end

    __funcsmarksave
end

function funcsreset
    funcsnuke $argv
    and funcsupdate
end
