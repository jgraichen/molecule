SHELL = /bin/bash

NODE = node
RUBY = ruby

SLIMC        = $(RUBY) -S bundle exec slimrb
SASSC        = $(RUBY) -S bundle exec sass -r 'compass/import-once/activate'
COFFEEC      = $(NODE) node_modules/.bin/coffee
BROWSERIFY   = $(NODE) node_modules/.bin/browserify --extension=".coffee"
AUTOPREFIXER = $(NODE) node_modules/.bin/autoprefixer

COFFEE_FILES = $(shell find lib -name '*.coffee')
SASS_FILES   = $(shell find lib -name '*.sass')
SLIM_FILES   = $(shell find lib -name '*.slim')

EXAMPLES = $(SLIM_FILES:lib/%.slim=examples/%.html)

default: examples test

examples: examples/molecule.css examples/molecule.js $(EXAMPLES)

examples/molecule.js: $(COFFEE_FILES)
	@mkdir -p examples
	NODE_PATH=. NODE_ENV=development $(BROWSERIFY) -r lib -r react -r sifter --debug > examples/molecule.js

examples/molecule.css: $(SASS_FILES)
	@mkdir -p examples
	$(SASSC) lib/index.sass | $(AUTOPREFIXER) > examples/molecule.css

examples/%.html: lib/%.slim
	@mkdir -p $(@D)
	$(SLIMC) $< > $@

clean:
	rm -f examples/molecule.js examples/molecule.js.map examples/molecule.css
	rm -f $(EXAMPLES)
	rmdir --ignore-fail-on-non-empty $(shell dirname ${EXAMPLES} | sort | uniq | sort -r)

test:
	NODE_PATH=. npm test
