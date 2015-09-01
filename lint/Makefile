PHONY += install
install: ~/.haml-lint.yml ~/.rubocop.yml

~/.haml-lint.yml:
	ln -sf -- .local/opt/important-things/lint/haml-lint.yml $@

~/.rubocop.yml:
	ln -sf -- .local/opt/important-things/lint/rubocop.yml $@

PHONY += uninstall
uninstall:
	rm ~/.haml-lint.yml ~/.rubocop.yml

.PHONY: $(PHONY)
