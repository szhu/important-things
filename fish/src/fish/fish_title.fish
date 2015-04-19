function fish_title --description 'Write out the title'
    if [ -n "$__fish_title" ]
        echo -n "$__fish_title"
    else if [ -e .fish_title ]
        cat .fish_title
    else
        pretty_pwd
    end
end
