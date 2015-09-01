# This is @szhu's standard Ubuntu provisoner.
#
# To use, first...
# sudo apt-get update && sudo apt-get install wget make
# ...then choose one of the following:
# f=$(mktemp) && echo $f && curl -fsSLo $f git.io/vGgvG && make -f $f
# f=$(mktemp) && echo $f && wget -qO $f git.io/vGgvG && make -f $f
# wget -qO Makefile git.io/vGgvG && make
#
# Custom:
# f=$(mktemp) && wget -qO $f git.io/vGgvG && make -f $f rule1 rule2 ...


# Short options

## Things to get or make
important-things := ~/.local/opt/important-things
ssh-key := ~/.ssh/id_rsa

## Config files
fish-config := ~/.config/fish
git-config := ~/.gitconfig
subl-config := ~/.local/share/sublime-text-3/Packages/User
user-dirs := ~/.config/user-dirs.dirs

## APT repository locations
fish-apt-source := /etc/apt/sources.list.d/fish-shell-release-2-$(shell lsb_release -c -s).list
subl-apt-source := /etc/apt/sources.list.d/webupd8team-sublime-text-3-$(shell lsb_release -c -s).list

# Command locations
apt-add-repository := /usr/bin/apt-add-repository
fish := /usr/bin/fish
git := /usr/bin/git
subl := /usr/local/bin/subl


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


# Rules

PHONIES += default
default: ssh-key fish git-config fish-config subl-config

PHONIES += ssh-key
ssh-key: $(ssh-key)
$(ssh-key):
	@echo; echo '## ssh-key: $@'
	ssh-keygen -N '' -f $@

PHONIES += apt-add-repository
apt-add-repository: $(apt-add-repository)
$(apt-add-repository):
	@echo; echo '## apt-add-repository: $@'
	sudo apt-get install -y python-software-properties software-properties-common

PHONIES += fish-apt-source
fish-apt-source: $(fish-apt-source)
$(fish-apt-source): $(apt-add-repository)
	@echo; echo '## fish-apt-source: $@'
	sudo apt-add-repository ppa:fish-shell/release-2 -y >/dev/null
	sudo apt-get update >/dev/null

PHONIES += fish
fish: $(fish)
$(fish): $(fish-apt-source)
	@echo; echo '## fish: $@'
	sudo apt-get install -y fish
	sudo touch $@
	sudo chsh $(shell whoami) -s "$$(which fish)"

PHONIES += git
git: $(git)
$(git):
	@echo; echo '## git: $@'
	sudo apt-get install -y git
	sudo touch $@

PHONIES += subl-apt-source
subl-apt-source: $(subl-apt-source)
$(subl-apt-source): $(apt-add-repository)
	@echo; echo '## subl-apt-source: $@'
	sudo add-apt-repository -y ppa:webupd8team/sublime-text-3 >/dev/null
	sudo apt-get update >/dev/null

PHONIES += subl
subl: $(subl)
$(subl): $(subl-apt-source)
	@echo; echo '## subl: $@'
	for px in 16 32 48 128 256; do sudo mkdir -p /usr/share/icons/hicolor/$${px}x$${px}/apps/; done
	sudo apt-get install -y sublime-text-installer
	sudo touch $@
	sudo apt-get remove -y sublime-text-installer

PHONIES += important-things
important-things: $(important-things)
$(important-things): $(git)
	@echo; echo '## important-things: $@'
	mkdir -p $(shell echo "$@" | xargs -0 dirname)
	test ! -e $@ && git clone -q https://github.com/szhu/important-things.git $@ || true
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

PHONIES += subl-config
subl-config: $(subl-config)
$(subl-config): $(important-things)
	@echo; echo '## subl-config: $@'
	mkdir -p $(shell echo "$@" | xargs -0 dirname)
	rm -f -- $@
	ln -s ../../../../.local/opt/important-things/sublime-text/ $@
	touch $@

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
