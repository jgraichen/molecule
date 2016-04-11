SHELL = /bin/bash

NODE = node
RUBY = ruby

SLIMC        = $(RUBY) -S bundle exec slimrb
SASSC        = $(RUBY) -S bundle exec sass -r 'compass/import-once/activate'
COFFEEC      = $(NODE) node_modules/.bin/coffee
BROWSERIFY   = $(NODE) node_modules/.bin/browserify --extension=".coffee"
AUTOPREFIXER = $(NODE) node_modules/.bin/postcss -u autoprefixer

COFFEE_FILES = $(shell find lib -name '*.coffee')
SASS_FILES   = $(shell find css -name '*.sass')
SLIM_FILES   = $(shell find doc -name '*.slim')

EXAMPLES = $(SLIM_FILES:doc/%.slim=examples/%.html)

default: examples test

examples: examples/molecule.css examples/molecule.js $(EXAMPLES)

examples/molecule.js: $(COFFEE_FILES)
	@mkdir -p examples
	NODE_PATH=. NODE_ENV=development $(BROWSERIFY) -r lib/example -r sifter --debug > examples/molecule.js

examples/molecule.css: $(SASS_FILES)
	@mkdir -p examples
	$(SASSC) css/index.sass | cat - doc/example.css | $(AUTOPREFIXER) > examples/molecule.css

examples/%.html: doc/%.slim
	@mkdir -p $(@D)
	$(SLIMC) $< > $@

clean:
	rm -f examples/molecule.js examples/molecule.js.map examples/molecule.css
	rm -f $(EXAMPLES)
	rmdir --ignore-fail-on-non-empty $(shell dirname ${EXAMPLES} | sort | uniq | sort -r)

test:
	NODE_PATH=. npm test
