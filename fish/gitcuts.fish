function g
  git $argv
end

function gP
  git pull $argv
end

function gp
  git push $argv
end

function gu
  git up $argv
end

function wow
  git status $argv
end

function wuf
  git commit -am "$argv"
end
