PREFIX ?= /usr/local

_: pass

pass: puff/puff

puff/puff:
	$(MAKE) -C puff

puff_install: pass
	install puff/puff $(PREFIX)/bin

install: puff_install

uninstall:
	rm -fv $(PREFIX)/bin/puff

clean:
	$(MAKE) -C puff clean
.PHONY: clean
