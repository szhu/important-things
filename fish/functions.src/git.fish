alias wow   'git status'
alias much  'git'
alias such  'git'
function wuf
    git commit -m "$argv"
end

alias gaa   'git add --all :/'
alias gb    'git branch'
alias gc    'git commit'
alias gca   'git commit --amend -m ""'
alias gco   'git checkout'
alias gd    'git diff'
alias gf    'git fetch'
alias gg    'git log'
# alias gm    'git merge'
alias gl    'git pull'
alias gp    'git push'
# alias gr    'git rebase'
for n in 1 2 3 4 5 6 7 8 9
    alias "gr~"$n "git rebase -i HEAD~"$n
end
alias gra   'git remote add'
alias grao  'git remote add origin'
alias grau  'git remote add upstream'
alias grs   'git remote set-url'
alias grso  'git remote set-url origin'
alias grsu  'git remote set-url upstream'
alias grr   'git remote rename'
alias gs    'git stash'
alias gsp   'git stash pop'
alias gsd   'git stash drop'
alias gsa   'git stash apply'
alias gu    'git up'
