FILES += ~/Library/KeyBindings/DefaultKeyBinding.dict

PHONY += install
install: $(FILES)

~/Library/KeyBindings/%: %
	@dirname $@ | xargs mkdir -p
	cp -- $< $@

PHONY += uninstall
uninstall:
	rm -f -- $(FILES)

.PHONY: $(PHONY)
