SRC_CSS_DIR:= src/css
SRC_JS_DIR:= src/js
WORK_DIR:= work

SRC_SCSS:= $(SRC_CSS_DIR)/style.scss
ENTRY_JS = $(SRC_JS_DIR)/index.js
SRC_JS:= $(SRC_JS_DIR)/*.js

JS_TARGET:= $(WORK_DIR)/bundle.js
JS_MAP:= $(WORK_DIR)/map.js
JS_TARGET_TEMP:= $(JS_TARGET).temp
JS_LIB_TARGET:= $(WORK_DIR)/bundle-lib.js

CSS_TARGET:= $(WORK_DIR)/bundle.css


RM := rm -f
RM_DIR := $(RM) -r

# Get ES6 + React compilation + type checking
BABELIFY_PACKAGES := babel-core babelify babel-preset-react babel-preset-env babel-plugin-transform-class-properties
BROWSERIFY_PACKAGES := browserify envify uglify-js uglifyify
ESLINT_PACKAGES := eslint babel-eslint eslint-plugin-react
REACT_PACKAGES := react react-dom

NPM_INSTALL := npm install --save-dev $(BABELIFY_PACKAGES) $(BROWSERIFY_PACKAGES) $(ESLINT_PACKAGES) $(REACT_PACKAGES)

ENV := NODE_END=dev

BR := $(ENV) browserify
EXORCIST := node_modules/exorcist/bin/exorcist.js

UGLIFY_FLAGS := --compress [ --warnings --unsafe --side_effects --join_vars --loops --evaluate --properties --sequences --comparisons --booleans --hoist_funs --hoist_vars if_return --dead_code --conditionals --unused --if_return ] --mangle --screw-ie8
UGLIFY := uglifyjs $(UGLIFY_FLAGS)

BABELIFY := babelify --presets [ env react ] --plugins [ transform-class-properties ]
BR_FLAGS := -d -t [ $(BABELIFY) ]



SHELL := /bin/bash
PWD := $(shell pwd)

# if windows, make sure 'make -v' returns 3.82 or higher
#  No? Download latest make.exe here (4.1 as of May 2016):
#  http://www.equation.com/servlet/equation.cmd?fa=make

# (c) 2016. All rights reserved.
# Makefile that installs and runs the project.

# Default; builds
all: prep $(JS_TARGET) $(CSS_TARGET)

# Builds + runs server
serve: all
	node webserver

clean:
	$(RM_DIR) $(WORK_DIR)

.PHONY: clean all serve 

install:
	$(NPM_INSTALL)

prep: $(WORK_DIR) # make sure build directories are present
$(WORK_DIR):
	mkdir -p $@

$(JS_TARGET): $(ENTRY_JS) $(SRC_JS)
	eslint $^ --fix
	$(BR) $< $(BR_FLAGS) | $(UGLIFY) > $@ 
#	$(BR) $< $(BR_FLAGS) | $(EXORCIST) $(JS_MAP) > $@ 

$(CSS_TARGET): $(SRC_SCSS)
	cat $^ >& $@
