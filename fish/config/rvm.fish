function rvm --description='Ruby enVironment Manager'
    bass source ~/.rvm/scripts/rvm \; rvm $argv
end

function rvm-root
    set -l cwd $PWD
    while true
        if contains $cwd '' ~ /
            return 1
        else if test -e $cwd/.rvmrc -o -e $cwd/.ruby-version -o -e $cwd/.ruby-gemset -o -e $cwd/Gemfile
            echo $cwd
            return 0
        end
        set cwd (dirname "$cwd")
    end
end

function __rvm_greeting
    test "$TERM_PROGRAM" = "Apple_Terminal"
        and set -l __rvm_status_char "💎  "
        or set -l __rvm_status_char "rvm: "
    echo -ne "\r$__rvm_status_char...\r$__rvm_status_char"
end

function rvm-auto
    set -g __last_rvm_hint_cwd        
    set -g __last_rvm_cwd        

    set -l cwd (rvm-root)
    test -z "$cwd"; and return
    contains $cwd $RVM_AUTODIRS; and return

    set -Ux RVM_AUTODIRS $RVM_AUTODIRS $cwd
    echo
    __rvm_greeting; echo "RVM will always be run in $cwd."
    __rvm_greeting; echo "Use `rvm-noauto` to undo."
    __rvm_on_cd
end

function rvm-noauto
    test "$argv[1]" = "--all"; and set -Ux RVM_AUTODIRS; and return

    set -l cwd (rvm-root)
    test -z "$cwd"; and return
    set i (contains -i $cwd $RVM_AUTODIRS)
    test -z "$i"; and return

    set -Ue RVM_AUTODIRS[$i]
end

function __rvm_on_cd --on-variable PWD
    status --is-command-substitution; and return

    set -l cwd (rvm-root)

    count $cwd >/dev/null; and if not contains $cwd $RVM_AUTODIRS
        if test "$__last_rvm_hint_cwd" != "$cwd"
            echo
            __rvm_greeting; echo "Use `rvm current` to activate RVM; `rvm-auto` to always activate RVM here."
            set -g __last_rvm_hint_cwd "$cwd"
        end
    end

    if test -z "$__last_rvm_hint_cwd"
        test "$__last_rvm_cwd" = "$cwd"; and return
        set_color green --bold; echo

        if count $cwd >/dev/null
            test -n "$__last_rvm_cwd"; and rvm use system >/dev/null
            __rvm_greeting; rvm current
        else
            __rvm_greeting; rvm use system
            set -x -e GEM_HOME
            set -x -e GEM_PATH
        end

        set_color normal
    else
        not count $cwd >/dev/null; and set -g __last_rvm_hint_cwd        
    end

    set -g __last_rvm_cwd "$cwd"
end

__rvm_on_cd
