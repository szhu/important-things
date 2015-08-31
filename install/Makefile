NAMES := apm brew brew-cask brew-tap appstore gem npm pip pip3
all: $(patsubst %,%.list,$(NAMES))


# RECORD WHAT I INSTALL

PHONY += apm.list
apm.list: bin/get-apm-list
	$< > $@

PHONY += appstore.list
appstore.list: bin/get-appstore
	$< > $@

PHONY += brew.list
brew.list:
	brew leaves > $@

PHONY += brew-cask.list
brew-cask.list:
	brew cask list > $@

PHONY += brew-tap.list
brew-tap.list:
	brew tap > $@

PHONY += gem.list
gem.list: bin/get-gem-list
	$< > $@

PHONY += npm.list
npm.list: bin/get-npm-list-leaves
	$< > $@

PHONY += pip.list
pip.list: bin/get-nonsystem-python-packages
	$< 2.7 > $@

PHONY += pip3.list
pip3.list: bin/get-pip-freeze
	$< 3 > $@


# INSTALL THINGS

PHONY += apm-install
apm-install:
	cat apm.list | xargs apm install

PHONY += brew-install
brew-install:
	cat brew.list | xargs brew install

PHONY += brew-cask-install
brew-cask-install:
	cat brew-cask.list | xargs brew cask install

PHONY += brew-tap-install
brew-tap-install:
	cat brew-tap.list | xargs brew tap

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

PHONY += appstore-install
appstore-install:
	@echo "Install these apps from the App Store:"
	@cat appstore.list | sed 's/^/  /'


# INSTALL EVERYTHING

PHONY += user-install
user-install: apm-install

PHONY += system-install
system-install: brew-install brew-cask-install brew-tap-install appstore-install gem-install npm-install pip-install pip3-install

.PHONY: $(PHONY)
