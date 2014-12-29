SHELL = /bin/bash

RUBY = ruby
NODE = node

SASSC      = $(RUBY) -S bundle exec sass -rbourbon -Inode_modules -I.
COFFEEC    = $(NODE) node_modules/.bin/coffee
BROWSERIFY = $(NODE) node_modules/.bin/browserify -t coffeeify --extension=".coffee" -t envify
EXORCIST   = $(NODE) node_modules/.bin/exorcist

SRC = molecule
DST = dist

SRCF = $(shell find $(SRC) -name '*.coffee')
JLIB = $(SRCF:%.coffee=%.js)
SASS = $(shell find $(SRC) -name '*.sass')

dist: $(SRCF)
	@mkdir -p $(DST)
	NODE_PATH=lib NODE_ENV=production $(BROWSERIFY) --debug molecule/index.coffee | $(EXORCIST) $(DST)/molecule.js.map > $(DST)/molecule.js

css: $(SASS)
	@mkdir -p $(DST)
	$(SASSC) < molecule/index.sass > $(DST)/molecule.css

compile: $(JLIB)

%.js: %.coffee
	$(COFFEEC) --compile --bare --map $<

clean:
	rm -rf $(JLIB) $(JLIB:=.map)

test:
	npm test
