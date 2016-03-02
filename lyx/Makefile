DIR := $(shell basename $(PWD))/
ALL += ~/Library/Application\ Support/LyX-2.1/bind/user.bind
ALL += ~/Library/Application\ Support/LyX-2.1/preferences

PHONY += install
install: $(ALL)

~/Library/Application\ Support/LyX-2.1/%:
	mkdir -p "$(shell dirname "$@")"
	ln -sf -- "../.local/opt/important-things/$(DIR)$(patsubst $(HOME)/Library/Application Support/LyX-2.1/%,%,$@)" "$@"

PHONY += uninstall
uninstall:
	rm -- $(ALL)

.PHONY: $(PHONY)
