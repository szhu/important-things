for cmd in rails rake rspec
    abbr $cmd bundle exec $cmd
end
