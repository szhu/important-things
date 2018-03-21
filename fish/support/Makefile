SRC_DIR := $(patsubst $(HOME)/%,%,$(PWD))
INV_SRC_DIR := $(echo $(SRC_DIR) | sed -E 's#([^/.]|[^/.][^/]+)#..#g')
ALL += ~/.bash_fish_launcher

PHONY += install
install: $(ALL)

# ~/.bash_fish_launcher:
# 	cp -- start-fish.bash $@

~/.bash_fish_launcher:
	$(eval DST := $(patsubst $(HOME)/%,%,$@))
	$(eval DST_DIR := $(shell dirname "$(DST)"))
	$(eval INV_DST_DIR := $(shell echo "$(DST_DIR)" | sed -E 's#([^/.]|[^/.][^/]+)#..#g'))
	mkdir -p "$(HOME)/$(DST_DIR)"
	ln -nsf -- "$(INV_DST_DIR)/$(SRC_DIR)"/start-fish.bash "$@"

PHONY += uninstall
uninstall:
	rm -- $(ALL)

.PHONY: $(PHONY)
