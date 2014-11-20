NAMES := brew brew-cask appstore gem npm pip pip3
ALL := $(patsubst %,%.txt,$(NAMES))
all: $(ALL)
.PHONY: $(ALL)

brew.txt:
	brew leaves > $@
brew-cask.txt:
	brew cask list > $@
appstore.txt: bin/get-appstore
	$< > $@
gem.txt: bin/get-gem-list
	$< > $@
npm.txt: bin/get-npm-list-leaves
	$< > $@
pip.txt: bin/get-nonsystem-python-packages
	$< 2.7 > $@
pip3.txt: bin/get-pip-freeze
	$< 3 > $@
