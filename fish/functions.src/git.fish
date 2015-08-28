abbr wow   git status
abbr much  git
abbr such  git
abbr wuf   git commit -m

abbr gaa   git add --all :/
abbr gb    git branch
abbr gc    git commit
abbr gca   git commit --amend -m '""'
abbr gco   git checkout
abbr gd    git diff
abbr gf    git fetch
abbr gg    git log
abbr gm    git merge
abbr gma   git merge --abort
abbr gmnf  git merge --no-ff
abbr gmnc  git merge --no-commit
abbr gmncf git merge --no-commit --no-ff
abbr gmnfc git merge --no-ff --no-commit
abbr gl    git pull
abbr glr   git pull --rebase
abbr gp    git push
abbr gr    git rebase
abbr gra   git rebase --abort
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
abbr gu    git up
