test (uname) = "Darwin"; or exit


# Folder-finding magic
# These functions take advantage of mdfind(1), a command line front-end to the Spotlight metadata framework.

function folders-search-mdfind -a scope -a query
  mdfind -onlyin $scope 'kind:folder' -name $query | folders-search-mdfind-algorithm
end

function folders-search-exactmatch -a scope -a query
  echo (cd $scope 2>&-; cd $query 2>&-; and pwd)
end

function folders-search-smart
  set -l scope .
  while test (count $argv) -gt 0
    set -l query $argv[1]
    # echo >&2 DEBUG folder $scope $query
    set -l result
    test -z "$result"; and set result (folders-search-exactmatch $scope $query)
    test -z "$result"; and set result (folders-search-mdfind $scope $query)
    test -z "$result"; and return 1
    set scope $result
    set -e argv[1]
  end
  echo $scope
end
alias folder folders-search-smart

function folders-search-mdfind-algorithm
  # Picks first Spotlight result
  head -1

  # Picks shortest path
  # http://superuser.com/questions/135753
  # awk '(NR == 1 || length < length(shortest)) { shortest = $0 } END { print shortest }'

  # Picks shortest path out of top 100 Spotlight results
  # head -100 | awk '(NR == 1 || length < length(shortest)) { shortest = $0 } END { print shortest }'

  # head -5 | awk '(NR == 1 || length < length(shortest)) { shortest = $0 } END { print shortest }'
end

function folders-search-smart-and-cd
  set -l result (folders-search-smart $argv)
  test -n "$result"; and cd $result
end
alias cdto folders-search-smart-and-cd
abbr cdto~ cdto '~'
