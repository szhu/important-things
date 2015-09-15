function docker-up -S
    screen -- /bin/bash -c "'/Applications/Docker/Docker Quickstart Terminal.app/Contents/Resources/Scripts/start.sh'; sleep 1"
    eval (docker-machine env default --shell=fish)
end

abbr dockerup docker-up
