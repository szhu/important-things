all: Preferences.sublime-settings.last-normalized

%.sublime-settings.last-normalized: %.sublime-settings
	bin/normalize_json $<
	touch $@

clean:
	rm -f -- *.last-normalized

.PHONY: all clean
