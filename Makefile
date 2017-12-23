# (c) 2017. All rights reserved.
# Makefile that installs and runs the project.

ENV := NODE_ENV=dev
SRC_DIR:= src
WORK_DIR:= work

SRC_SCSS:= $(SRC_DIR)/css/style.scss
ENTRY_JS = $(SRC_DIR)/js/index.js
SRC_JS:= $(SRC_DIR)/js/*.js webserver.js .eslintrc.json

JS_TARGET:= $(WORK_DIR)/bundle.js
JS_MAP:= $(WORK_DIR)/map.js
JS_LIB_TARGET:= $(WORK_DIR)/bundle-lib.js
CSS_TARGET:= $(WORK_DIR)/bundle.css

# Get ES6 + React compilation + type checking
BABELIFY_PACKAGES := babel-core babelify babel-preset-react babel-preset-env babel-plugin-transform-class-properties
BROWSERIFY_PACKAGES := browserify envify uglify-js uglifyify
ESLINT_PACKAGES := eslint babel-eslint eslint-plugin-react eslint-plugin-node
REACT_PACKAGES := react react-dom
NPM_INSTALL := npm install --save-dev $(BABELIFY_PACKAGES) $(BROWSERIFY_PACKAGES) $(ESLINT_PACKAGES) $(REACT_PACKAGES)

ESLINT := node_modules/eslint/bin/eslint.js
ESLINT_FLAGS := --fix

BROWSERIFY := $(ENV) node_modules/browserify/bin/cmd.js
BABELIFY := babelify --presets [ env react ] --plugins [ transform-class-properties ]
BROWSERIFY_FLAGS := -d -t [ $(BABELIFY) ]
#BROWSERIFY_FLAGS := -d -t [ $(BABELIFY) ] -g [ envify --$(ENV) ] -g uglifyify


UGLIFY := node_modules/uglify-js/bin/uglifyjs --compress --mangle

SHELL := /bin/bash
PWD := $(shell pwd)

# Default; builds
all: prep $(JS_TARGET) $(CSS_TARGET)

# Builds + runs server
serve: all
	node webserver

clean:
	rm -rf $(WORK_DIR)

.PHONY: clean all serve

install:
	$(NPM_INSTALL)

prep: $(WORK_DIR) # make sure build directories are present
$(WORK_DIR):
	mkdir -p $@

$(JS_TARGET): $(ENTRY_JS) $(SRC_JS)
	$(ESLINT) $^ $(ESLINT_FLAGS)
#	$(BROWSERIFY) $< $(BROWSERIFY_FLAGS) | $(UGLIFY) > $@
	$(BROWSERIFY) $< $(BROWSERIFY_FLAGS) > $@

$(CSS_TARGET): $(SRC_SCSS)
	cat $^ >& $@
