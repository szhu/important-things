REPO := .local/opt/important-things
DIR := $(shell env echo -n "$(PWD)" | xargs -0 basename)
ALL += ~/.screenrc
ALL += ~/.tmux.conf

PHONY += install
install: $(ALL)

~/.%:
	ln -sf -- $(REPO)/$(DIR)/$(patsubst $(HOME)/.%,%,$@) $@

PHONY += import-screenrc
import-screenrc: ~/.screenrc
	mv -- $< $(patsubst $(HOME)/.%,%,$<)

PHONY += import-tmux.conf
import-tmux.conf: ~/.tmux.conf
	mv -- $< $(patsubst $(HOME)/.%,%,$<)

PHONY += uninstall
uninstall:
	rm -- $(ALL)

.PHONY: $(PHONY)
