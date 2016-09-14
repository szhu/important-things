REPO := .local/opt/important-things
DIR := $(shell env echo -n "$(PWD)" | xargs -0 basename)
ALL += ~/.screenrc

PHONY += install
install: $(ALL)

~/.%:
	ln -sf -- $(REPO)/$(DIR)/$(patsubst $(HOME)/.%,%,$@) $@

PHONY += import
import: ~/.screenrc
	mv -- $< $(patsubst $(HOME)/.%,%,$<)

PHONY += uninstall
uninstall:
	rm -- $(ALL)

.PHONY: $(PHONY)
