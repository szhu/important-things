DIR := $(shell basename $(PWD))/
ALL += ~/.config/fish

PHONY += install
install: $(ALL)

~/.config/fish:
	ln -sf -- ../.local/opt/important-things/$(DIR) $@

PHONY += uninstall
uninstall:
	rm -- $(ALL)

.PHONY: $(PHONY)
