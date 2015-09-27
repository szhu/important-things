DIR := $(shell basename $(PWD))/
ALL += ~/.config/flake8
ALL += ~/.haml-lint.yml
ALL += ~/.rubocop.yml

PHONY += install
install: $(ALL)

~/.config/%:
	ln -sf -- ../.local/opt/important-things/$(DIR)$(patsubst $(HOME)/.config/%,%,$@) $@

~/.%:
	ln -sf -- .local/opt/important-things/$(DIR)$(patsubst $(HOME)/.%,%,$@) $@

PHONY += uninstall
uninstall:
	rm -- $(ALL)

.PHONY: $(PHONY)
