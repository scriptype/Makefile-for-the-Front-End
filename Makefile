BIN = ./node_modules/.bin
DIST = ./dist
SRC = ./src

HTML_INPUT = $(SRC)/index.html
HTML_OUTPUT = $(DIST)/index.html

CSS_INPUT_DIR = $(SRC)/stylesheets
CSS_INPUT = $(CSS_INPUT_DIR)/style.css
CSS_OUTPUT_MIN_DIR = $(DIST)
CSS_OUTPUT_MIN = $(CSS_OUTPUT_MIN_DIR)/style.min.css

JS_INPUT_DIR = $(SRC)/scripts
JS_INPUT = $(JS_INPUT_DIR)/app.js
JS_OUTPUT = $(DIST)/all.js
JS_OUTPUT_MIN = $(DIST)/all.min.js

PROD_CSS_PATH = style.min.css
PROD_JS_PATH = all.min.js

all: clean copy_static html js
	@echo "Finished $@. `date`"
	@make watch & node server dev

release: clean copy_static post_html post_css post_js
	@echo "Finished $@. `date`" & node server prod

clean:
	@echo "Cleaning..."
	@rm -rf $(DIST)
	@mkdir $(DIST)

watch:
	@make watch_js & $(BIN)/livereload "$(DIST), $(CSS_INPUT_DIR)"

html:
	@make replace_path \
		SCRIPT_FILE=$(JS_OUTPUT) \
		STYLE_FILE=$(CSS_INPUT) \
		LIVE_RELOAD='true'

post_html:
	@make replace_path \
		SCRIPT_FILE=$(PROD_JS_PATH) \
		STYLE_FILE=$(PROD_CSS_PATH) \
		LIVE_RELOAD='false'
	@echo "Minifying markup..."
	@$(BIN)/html-minifier \
		--collapse-whitespace \
		--remove-attribute-quotes \
		--remove-comments \
		--remove-empty-attributes \
		--remove-redundant-attributes \
		--output $(DIST)/tmp.index.html \
		$(HTML_OUTPUT)
	@mv $(DIST)/tmp.index.html $(HTML_OUTPUT)

post_css:
	@echo "PostCSS..."
	@$(BIN)/postcss \
		--use autoprefixer \
		--use postcss-import \
		--local-plugins \
		--output $(DIST)/tmp.style.css \
		$(CSS_INPUT)
	@echo "Minifying stylesheets..."
	@$(BIN)/cssnano $(DIST)/tmp.style.css $(CSS_OUTPUT_MIN)
	@rm $(DIST)/tmp.style.css

js:
	@echo "Browserify..."
	@$(BIN)/browserify \
		--delay=100 \
		--verbose \
		--transform [ babelify --presets [ es2015 react ] ] \
		--outfile $(JS_OUTPUT) \
		--debug \
		$(JS_INPUT)

watch_js:
	@echo "Started watching JS..."
	@$(BIN)/watchify \
		--delay=100 \
		--verbose \
		--transform [ babelify --presets [ es2015 react ] ] \
		--outfile $(JS_OUTPUT) \
		--debug \
		$(JS_INPUT)

post_js: js
	@echo "Minifying scripts..."
	@$(BIN)/uglifyjs $(JS_OUTPUT) -o $(JS_OUTPUT_MIN)
	@rm $(JS_OUTPUT)

copy_static:
	@echo "Copying static files..."
	@mkdir -p $(DIST)/fonts
	@mkdir -p $(DIST)/images
	@cp -r $(SRC)/fonts/ $(DIST)/fonts
	@cp -r $(SRC)/images/ $(DIST)/images

replace_path:
	@echo "Updating markup..."
	@$(BIN)/handlebars $(HTML_INPUT) -f $(DIST)/tmp.index.hbs.js
	@node -p " \
	  var Handlebars = require('handlebars'); \
	  var template = require('./$(DIST)/tmp.index.hbs.js'); \
	  Handlebars.templates['index.html']({ \
	    SCRIPT_FILE: '$(SCRIPT_FILE)', \
	    STYLE_FILE: '$(STYLE_FILE)', \
	    LIVE_RELOAD: $(LIVE_RELOAD) \
	  }) \
	" > $(HTML_OUTPUT)
	@rm $(DIST)/tmp.index.hbs.js

