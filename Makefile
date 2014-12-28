SHELL := /bin/bash

RUBY := ruby
NODE := node

SASSC      := $(RUBY) -S bundle exec sass -rbourbon -Inode_modules -Isrc
COFFEEC    := $(NODE) node_modules/.bin/coffee
BROWSERIFY := $(NODE) node_modules/.bin/browserify -t coffeeify --extension=".coffee" -t envify
EXORCIST   := $(NODE) node_modules/.bin/exorcist

SRC = src
DST = dist
COFE = $(shell find $(SRC) -name '*.coffee')
SASS = $(shell find $(SRC) -name '*.sass')

default: js css

js: $(COFE)
	@mkdir -p $(DST)
	NODE_PATH="$(NODE_PATH):$(SRC)" $(BROWSERIFY) --debug $(SRC)/index.coffee | $(EXORCIST) $(DST)/sui.js.map > $(DST)/sui.js

css: $(SASS)
	@mkdir -p $(DST)
	$(SASSC) < $(SRC)/index.sass > $(DST)/sui.css

clean:
	rm -f $(DIST)/*.{js,css}
