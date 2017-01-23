REPO := .local/opt/important-things
DIR := $(shell env echo -n "$(PWD)" | xargs -0 basename)
ALL += ~/.phoenix.js

PHONY += install
install: $(ALL)

# Use wmake to watch!
~/.%.js: %.coffee
	 coffee -c --bare --stdio < $< > $@

PHONY += uninstall
uninstall:
	rm -- $(ALL)

.PHONY: $(PHONY)
