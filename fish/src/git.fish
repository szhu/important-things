alias wow   'git status'
function wuf ; git commit -m "$argv" ; end

alias gaa   'git add --all :/'
alias gbr   'git branch'
alias gc    'git commit'
alias gca   'git commit --amend -m ""'
alias gco   'git checkout'
alias gd    'git diff'
alias gf    'git fetch'
alias gg    'git log'
alias gm    'git merge'
alias gl    'git pull'
alias gp    'git push'
alias gr    'git rebase'
for n in 1 2 3 4 5 6 7 8 9
    alias "gr~"$n "git rebase -i HEAD~"$n
end
alias gs    'git stash'
alias gsp   'git stash pop'
alias gsd   'git stash drop'
alias gsa   'git stash apply'
alias gu    'git up'
