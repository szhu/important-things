# This is @szhu's standard Ubuntu provisoner for cs.Berkeley.EDU computers.
#
# To use,  choose one of the following:
# f=$(mktemp) && echo $f && curl -fsSLo $f git.io/vGgvB && make -f $f
# f=$(mktemp) && echo $f && wget -qO $f git.io/vGgvB && make -f $f
# wget -qO Makefile git.io/vGgvB && make
#
# Custom:
# f=$(mktemp) && wget -qO $f git.io/vGgvB && make -f $f rule1 rule2 ...


# Short options

## Things to get or make
important-things := ~/.local/opt/important-things
cs-build := ~/.local/opt/berkeley-cs-build
ssh-key := ~/.ssh/id_rsa
start-fish-stub := ~/.bash_fish_launcher

## Config files
fish-config := ~/.config/fish
git-config := ~/.gitconfig
subl-config := ~/.local/share/sublime-text-3/Packages/User
user-dirs := ~/.config/user-dirs.dirs

# Command locations
fish := ~/.local/bin/fish
git := /usr/bin/git
rsubl := ~/.local/bin/rsubl


# File bodies

define git_config_body
[include]
	path = .local/opt/important-things/git/gitconfig
endef
export git_config_body

define user_dirs_body
# This file is written by xdg-user-dirs-update
# If you want to change or add directories, just edit the line you'\''re
# interested in. All local changes will be retained on the next run
# Format is XDG_xxx_DIR="$HOME/yyy", where yyy is a shell-escaped
# homedir-relative path, or XDG_xxx_DIR="/yyy", where /yyy is an
# absolute path. No other format is supported.
#
XDG_DESKTOP_DIR="$HOME/desktop"
XDG_DOWNLOAD_DIR="$HOME/downloads"
XDG_TEMPLATES_DIR="$HOME/work/templates"
XDG_PUBLICSHARE_DIR="$HOME/public_html"
XDG_DOCUMENTS_DIR="$HOME/work"
XDG_MUSIC_DIR="$HOME"
XDG_PICTURES_DIR="$HOME"
XDG_VIDEOS_DIR="$HOME"
endef
export user_dirs_body

define start_fish_body

# Start fish if the conditions are right
source ~/.bash_fish_launcher
endef
export start_fish_body

# Rules

PHONIES += default
default: ssh-key fish-set-default git-config fish-config subl-config user-dirs

PHONIES += work
work: fish fish-set-default git-config fish-config rsubl

PHONIES += ssh-key
ssh-key: $(ssh-key)
$(ssh-key):
	@echo; echo '## ssh-key: $@'
	ssh-keygen -N '' -f $@
	ssh-copy-id localhost

PHONIES += fish
fish: $(fish)
$(fish): $(cs-build)
	@echo; echo '## fish: $@'
	cd ~/.local/opt/berkeley-cs-build && curses/build.sh && fish/build.sh
	touch $@
	@ # rm -rf ~/.local/opt/berkeley-cs-build

PHONIES += important-things
important-things: $(important-things)
$(important-things): $(git)
	@echo; echo '## important-things: $@'
	mkdir -p $(shell echo "$@" | xargs -0 dirname)
	test ! -e $@ && git clone -q https://github.com/szhu/important-things.git $@ || true
	touch $@

PHONIES += cs-build
cs-build: $(cs-build)
$(cs-build): $(git)
	@echo; echo '## cs-build: $@'
	mkdir -p $(shell echo "$@" | xargs -0 dirname)
	test ! -e $@ && git clone -q https://github.com/szhu/cs-build.git $@ || true
	touch $@

PHONIES += git-config
git-config: $(git-config)
$(git-config): $(important-things)
	@echo; echo '## git-config: $@'
	mkdir -p $(shell echo "$@" | xargs -0 dirname)
	echo "$$git_config_body" >$@
	touch $@

PHONIES += fish-config
fish-config: $(fish-config)
$(fish-config): $(important-things)
	@echo; echo '## fish-config: $@'
	mkdir -p $(shell echo "$@" | xargs -0 dirname)
	rm -f -- $@
	ln -s ../.local/opt/important-things/fish $@
	touch $@

PHONIES += start-fish-stub
start-fish-stub: $(start-fish-stub)
$(start-fish-stub): $(important-things)
	@echo; echo '## start-fish-stub: $@'
	mkdir -p $(shell echo "$@" | xargs -0 dirname)
	rm -f -- $@
	cp -- ~/.local/opt/important-things/fish/support/start-fish.bash $@

PHONIES += fish-set-default
fish-set-default: $(start-fish-stub)
	@echo; echo '## fish-set-default'
	touch ~/.bashrc ~/.bash_profile
	grep -Fq "source ~/.bash_fish_launcher" ~/.bashrc || echo "$$start_fish_body" >> ~/.bashrc
	grep -Fq "source ~/.bash_fish_launcher" ~/.bash_profile || echo "$$start_fish_body" >> ~/.bash_profile

PHONIES += subl-config
subl-config: $(subl-config)
$(subl-config): $(important-things)
	@echo; echo '## subl-config: $@'
	mkdir -p $(shell echo "$@" | xargs -0 dirname)
	rm -f -- $@
	ln -s ../../../../.local/opt/important-things/sublime-text/ $@
	touch $@

PHONIES += rsubl
rsubl: $(rsubl)
$(rsubl):
	@# https://wrgms.com/editing-files-remotely-via-ssh-on-sublimetext-3/
	mkdir -p $(shell echo "$@" | xargs -0 dirname)
	wget -O $@ https://raw.github.com/aurora/rmate/master/rmate
	chmod a+x $@

PHONIES += user-dirs
user-dirs: $(user-dirs)
$(user-dirs):
	@echo; echo '## user-dirs: $@'
	rmdir -- ~/Applications ~/Backup ~/Music ~/Public ~/Templates ~/Videos || true
	mv -- ~/Desktop ~/desktop || true
	mv -- ~/Downloads ~/downloads || true
	mv -- ~/Documents ~/work || true
	mkdir -p $(shell echo "$@" | xargs -0 dirname)
	echo "$$user_dirs_body" >$@

print-%:
	@echo $*=$($*)

rm-%:
	rm -ri $($*)

.PHONY: $(PHONIES)
