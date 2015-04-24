function fish_title --description 'Write out the title'
    if count $__fish_title > /dev/null
        echo -n "$__fish_title"
    else
        pretty_pwd
    end
end
