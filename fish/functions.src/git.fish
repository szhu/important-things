# Doge git
abbr wow git status
abbr much git
abbr such git
abbr wuf git commit -m

# Abbreviations for built-in git commands
abbr g/ 'git status'

abbr gk 'git checkout'
abbr gkb 'git checkout -b'

abbr gs 'git stash'
abbr gsp 'git stash pop'
abbr gsa 'git stash apply'

abbr gb 'git branch'
abbr gbm 'git branch -m'

abbr gr 'git rebase'
abbr gri 'git rebase -i'
abbr gra 'git rebase --abort'

abbr gm 'git merge'
abbr gma 'git merge --abort'

abbr gy 'git cherry-pick'
abbr gya 'git cherry-pick --abort'

abbr gp 'git push'
abbr gpu 'git push -u'

abbr gl 'git pull'
abbr glr 'git pull --rebase'

abbr gca 'git commit --amend --no-edit --allow-empty'

abbr ga 'git add'
abbr gaa 'git add --all'
abbr gas 'git add --all && git stash'

abbr git-root 'git rev-parse --show-toplevel'
abbr git-last 'git log -1'
abbr git-current-sha 'git rev-parse HEAD'
abbr git-delete-merged 'git branch --merged | grep -v "^* " | xargs git branch -d'
abbr git-unset-upstream-all 'git branch --format "%(refname:short)" | xargs -L 1 git branch --unset-upstream'
abbr git-unfetch-all 'trash .git/refs/remotes'
abbr git-backup-branches 'git branch --format "%(refname:short)" | xargs -L 1 bash -c "git tag \"\$0\" \"\$0\""'
abbr git-open-branches 'git rev-parse --show-toplevel | xargs -L 1 bash -c "open \"\$0/.git/refs/heads\""'

# Abbreviations for custom git commands
abbr gll git log-graph-long
abbr gls git log-graph-short
abbr guu git branch-track-origin

# https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=565699
set -ge LESS
set -Ux LESS RS
