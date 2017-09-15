PHONY += all
all: Preferences.sublime-settings.last-normalized install


# Normalize Sublime settings

%.sublime-settings.last-normalized: %.sublime-settings
	bin/normalize_json $<
	touch $@

PHONY += clean
clean:
	rm -f -- *.last-normalized


# Install Sublime settings

DIR := $(shell basename $(PWD))/
ALL += ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User

PHONY += install
install: $(ALL)

~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User:
	@# dirname "$@" | xargs mkdir -p
	mkdir -p "$HOME/Library/Application Support/Sublime Text 3/Packages"
	ln -sf -- ../../../../.local/opt/important-things/$(DIR) "$@"

PHONY += uninstall
uninstall:
	rm -- $(ALL)

.PHONY: $(PHONY)
