PHONY += all
all: Preferences.sublime-settings.last-normalized install


# Normalize Sublime settings

%.sublime-settings.last-normalized: %.sublime-settings
	bin/normalize_json $<
	touch $@

PHONY += clean
clean:
	rm -f -- *.last-normalized


# Install Sublime settings

SRC_DIR := $(patsubst $(HOME)/%,%,$(PWD))
INV_SRC_DIR := $(echo $(SRC_DIR) | sed -E 's#([^/.]|[^/.][^/]+)#..#g')
ALL += ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User

PHONY += install
install: $(ALL)

$(ALL):
	$(eval DST := $(patsubst $(HOME)/%,%,$@))
	$(eval DST_DIR := $(shell dirname "$(DST)"))
	$(eval INV_DST_DIR := $(shell echo "$(DST_DIR)" | sed -E 's#([^/.]|[^/.][^/]+)#..#g'))
	mkdir -p "$(HOME)/$(DST_DIR)"
	rm -f -- "$@"
	ln -nsf -- "$(INV_DST_DIR)/$(SRC_DIR)" "$@"

PHONY += uninstall
uninstall:
	rm -- $(ALL)

.PHONY: $(PHONY)
