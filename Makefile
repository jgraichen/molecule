SHELL = /bin/bash

NODE = node
RUBY = ruby

SLIMRB     = $(RUBY) -S bundle exec slimrb
STYLC      = $(NODE) node_modules/.bin/stylus -I node_modules -I .
COFFEEC    = $(NODE) node_modules/.bin/coffee
BROWSERIFY = $(NODE) node_modules/.bin/browserify --extension=".coffee"
EXORCIST   = $(NODE) node_modules/.bin/exorcist

SOURCE   = molecule
LIB      = lib
DIST     = dist
EXAMPLES = examples

COFFEE_FILES = $(shell find $(SOURCE) -name '*.coffee')
STYLUS_FILES = $(shell find $(SOURCE) -name '*.styl')
SCRIPT_FILES = $(COFFEE_FILES:$(SOURCE)/%.coffee=$(LIB)/%.js)
SLIMRB_FILES = $(shell find $(SOURCE) -name '*.slim')
EXAMPLE_HTML = $(SLIMRB_FILES:$(SOURCE)/%.slim=$(EXAMPLES)/%.html)

examples: $(EXAMPLE_HTML) $(EXAMPLES)/molecule.js $(EXAMPLES)/molecule.css
	@mkdir -p $(EXAMPLES)

$(EXAMPLES)/molecule.js: $(COFFEE_FILES)
	@mkdir -p $(EXAMPLES)
	NODE_PATH=. NODE_ENV=development $(BROWSERIFY) -r "$(SOURCE)/index.coffee:molecule" -r react --debug | $(EXORCIST) $(EXAMPLES)/molecule.js.map > $(EXAMPLES)/molecule.js

$(EXAMPLES)/molecule.css: $(STYLUS_FILES)
	@mkdir -p $(EXAMPLES)
	$(STYLC) < $(SOURCE)/index.styl > $(EXAMPLES)/molecule.css

$(EXAMPLES)/%.html: $(SOURCE)/%.slim
	@mkdir -p $(@D)
	$(SLIMRB) $< > $@

compile: $(SCRIPT_FILES)

$(LIB)/%.js: $(SOURCE)/%.coffee
	@mkdir -p $(@D)
	$(COFFEEC) --compile --bare --map --output $(@D) $<

clean:
	rm -f $(EXAMPLES)/molecule.js $(EXAMPLES)/molecule.js.map $(EXAMPLES)/molecule.css
	rm -f $(EXAMPLE_HTML)
	rmdir $(shell dirname ${EXAMPLE_HTML} | sort | uniq | sort -r)

clean-lib:
	rm -f $(SCRIPT_FILES) $(SCRIPT_FILES:=.map)
	rmdir $(shell dirname ${SCRIPT_FILES} | sort | uniq | sort -r)

clean-all: clean clean-examples

test:
	NODE_PATH=. npm test
