NAMES := apm gem npm pip pip3
all: $(patsubst %,%.list,$(NAMES)) Brewfile


# RECORD WHAT I INSTALL

PHONY += apm.list
apm.list: bin/get-apm-list
	$< > $@

PHONY += Brewfile
Brewfile:
	brew bundle dump --all --force

PHONY += gem.list
gem.list: bin/get-gem-list
	$< > $@

PHONY += npm.list
npm.list: bin/get-npm-list-leaves
	$< > $@

PHONY += pip.list
pip.list: bin/get-pip-freeze
	$< 2 > $@

PHONY += pip3.list
pip3.list: bin/get-pip-freeze
	$< 3 > $@


# INSTALL THINGS

PHONY += apm-install
apm-install:
	cat apm.list | xargs apm install

PHONY += brew-install
brew-install:
	brew bundle

PHONY += gem-install
gem-install:
	cat gem.list | xargs gem install

PHONY += npm-install
npm-install:
	cat npm.list | xargs npm -g install

PHONY += pip-install
pip-install:
	cat pip.list | xargs pip install

PHONY += pip3-install
pip3-install:
	cat pip3.list | xargs pip3 install


# INSTALL EVERYTHING

PHONY += user-install
user-install: apm-install

PHONY += system-install
system-install: brew-install gem-install npm-install pip-install pip3-install

.PHONY: $(PHONY)
