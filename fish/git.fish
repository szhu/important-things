alias wow   'git status'
alias such  'git'
alias very  'git'
function wuf ; git commit -m "$argv" ; end
# alias wuf   'git commit -am'

alias gaa   'git add --all :/'
alias gbr   'git branch'
alias gc    'git commit'
alias gch   'git checkout'
alias gd    'git diff'
alias gl    'git log'
alias gm    'git merge'
alias gP    'git pull'
alias gp    'git push'
alias gr    'git rebase'
for n in 1 2 3 4 5 6 7 8 9
    alias "gr~"$n "git rebase -i HEAD~"$n
end
alias gs    'git status'
alias gu    'git up'
