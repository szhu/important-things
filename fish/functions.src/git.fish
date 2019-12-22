# Doge git
abbr wow   git status
abbr much  git
abbr such  git
abbr wuf   git commit -m

# Abbreviations for built-in git commands
abbr gaa   git add --all :/
abbr gb    git branch
abbr gc    git commit
abbr gca   git commit --amend --no-edit
abbr gco   git checkout
abbr gcp   git cherry-pick
abbr gcpa  git cherry-pick --abort
abbr gcpc  git cherry-pick --continue
abbr gd    git diff
abbr gf    git fetch
abbr gg    git log
abbr gm    git merge
abbr gmt   git mergetool
abbr gma   git merge --abort
abbr gmc   git merge --continue
abbr gl    git pull
abbr glr   git pull --rebase
abbr gp    git push
abbr gpu   git push -u
abbr gr    git rebase
abbr gra   git rebase --abort
abbr grc   git rebase --continue
for n in 1 2 3 4 5 6 7 8 9
    abbr gr~$n git rebase -i HEAD~$n
end
abbr gta   git remote add
abbr gtao  git remote add origin
abbr gtau  git remote add upstream
abbr gts   git remote set-url
abbr gtso  git remote set-url origin
abbr gtsu  git remote set-url upstream
abbr gtr   git remote rename
abbr gs    git stash
abbr gsp   git stash pop
abbr gsd   git stash drop
abbr gsa   git stash apply

# Abbreviations for custom git commands
abbr gll   git log-graph-long
abbr gls   git log-graph-short
abbr guu   git branch-track-origin

# https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=565699
set -ge LESS
set -Ux LESS RS
