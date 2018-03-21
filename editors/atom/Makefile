DIR := $(shell basename $(PWD))/
ALL += ~/.atom/config.cson
ALL += ~/.atom/init.coffee
ALL += ~/.atom/keymap.cson
ALL += ~/.atom/snippets.cson
ALL += ~/.atom/styles.less

PHONY += install
install: $(ALL)

~/.atom/%:
	ln -sf -- ../.local/opt/important-things/$(DIR)$(patsubst $(HOME)/.atom/%,%,$@) $@

PHONY += uninstall
uninstall:
	rm -- $(ALL)

.PHONY: $(PHONY)
