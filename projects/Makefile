PHONY += install
install:
	$(MAKE) -C apache $@ | sed 's/^/   /'
	$(MAKE) -C actively $@ | sed 's/^/   /'
	$(MAKE) -C prefsync $@ | sed 's/^/   /'

PHONY += uninstall
uninstall:
	$(MAKE) -C apache $@ | sed 's/^/   /'
	$(MAKE) -C actively $@ | sed 's/^/   /'
	$(MAKE) -C prefsync $@ | sed 's/^/   /'

.PHONY: $(PHONY)
