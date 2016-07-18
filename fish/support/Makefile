REPO := .local/opt/important-things
DIR := $(shell env echo -n "$(PWD)" | xargs -0 dirname | xargs -0 basename)/support
ALL += ~/.bash_fish_launcher

PHONY += install
install: $(ALL)

# ~/.bash_fish_launcher:
# 	cp -- start-fish.bash $@

~/.bash_fish_launcher:
	ln -s -- $(REPO)/$(DIR)/start-fish.bash $@

PHONY += uninstall
uninstall:
	rm -- $(ALL)

.PHONY: $(PHONY)
