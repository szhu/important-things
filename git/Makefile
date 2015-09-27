DIR := $(shell basename $(PWD))/
ALL += ~/.gitconfig

PHONY += install
install: $(ALL)

~/.gitconfig: gitconfig.local.example
	cp -i -- $< $@

PHONY += uninstall
uninstall:
	rm -- $(ALL)

.PHONY: $(PHONY)
