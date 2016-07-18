REPO := .local/opt/important-things
DIR := $(shell env echo -n "$(PWD)" | xargs -0 basename)
ALL += ~/.hyperterm.js

PHONY += install
install: $(ALL)

~/.%:
	ln -sf -- $(REPO)/$(DIR)/$(patsubst $(HOME)/.%,%,$@) $@

PHONY += import
import: ~/.hyperterm.js
	cp -- $< $(patsubst $(HOME)/.%,%,$<)

PHONY += uninstall
uninstall:
	rm -- $(ALL)

.PHONY: $(PHONY)
