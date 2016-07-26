DIR := $(shell basename $(PWD))/
ALL += ~/.duti.sh

PHONY += install
install: $(ALL)

~/.%:
	ln -sf -- .local/opt/important-things/$(DIR)$(patsubst $(HOME)/.%,%,$@) $@

PHONY += uninstall
uninstall:
	rm -- $(ALL)

.PHONY: $(PHONY)
