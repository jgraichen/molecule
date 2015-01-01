SHELL = /bin/bash

NODE = node

STYLC      = $(NODE) node_modules/.bin/stylus -I node_modules -I .
COFFEEC    = $(NODE) node_modules/.bin/coffee
BROWSERIFY = $(NODE) node_modules/.bin/browserify --extension=".coffee"
EXORCIST   = $(NODE) node_modules/.bin/exorcist

SRC = molecule
DST = dist

SRCF = $(shell find $(SRC) -name '*.coffee')
JLIB = $(SRCF:%.coffee=%.js)
STYL = $(shell find $(SRC) -name '*.styl')

dist: $(SRCF)
	@mkdir -p $(DST)
	NODE_PATH=. NODE_ENV=production $(BROWSERIFY) --debug molecule/index.coffee | $(EXORCIST) $(DST)/molecule.js.map > $(DST)/molecule.js

css: $(STYL)
	@mkdir -p $(DST)
	$(STYLC) < molecule/index.styl > $(DST)/molecule.css

compile: $(JLIB)

%.js: %.coffee
	$(COFFEEC) --compile --bare --map $<

clean:
	rm -rf $(JLIB) $(JLIB:=.map)

test:
	NODE_PATH=. npm test
