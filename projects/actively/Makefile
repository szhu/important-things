LABEL := com.interestinglythere.actively

DIR_FILES := $(HOME)/.local/opt/actively
FILES += $(DIR_FILES)/com.interestinglythere.actively.py
FILES += $(DIR_FILES)/com.interestinglythere.actively.scpt
FILES += $(DIR_FILES)/bin/activ
PLIST_DEPENDENCIES := $(FILES)

DIR_PLIST := $(HOME)/Library/LaunchAgents
PLIST := $(HOME)/Library/LaunchAgents/$(LABEL).plist
PLIST_POSTFLIGHT += -c "Set :WorkingDirectory $(DIR_FILES)"
PLIST_POSTFLIGHT += -c "Set :Label $(LABEL)"


PHONY += install
install: unload $(PLIST)

PHONY += uninstall
uninstall: unload
	rm -f -- $(PLIST_DEPENDENCIES) $(PLIST)

PHONY += unload
unload:
	@! test -e $(PLIST) || $(MAKE) force-uninstall
	@! launchctl list | grep -Fq $(LABEL) || $(MAKE) force-uninstall

PHONY += force-uninstall
force-uninstall:
	launchctl unload -F $(PLIST) || true

$(DIR_PLIST)/%: % $(PLIST_DEPENDENCIES)
	cp -- $< $@
	/usr/libexec/PlistBuddy $@ $(PLIST_POSTFLIGHT)
	launchctl load -F $@

$(DIR_FILES):
	@dirname $@ | xargs mkdir -p
	@rm -f -- $@
	ln -s -- $(SYM_FILES) $@

$(DIR_FILES)/%: %
	@dirname $@ | xargs mkdir -p
	cp -- $< $@

.PHONY: $(PHONY)
.PRECIOUS: $(DIR_FILES) $(FILES)
