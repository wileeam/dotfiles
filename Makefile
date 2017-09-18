DOT_HOME ?= ${HOME}
DOTFILES := ${shell pwd}

.DEFAULT_GOAL := help

.PHONY: help
.SILENT: vim

help:
	@cat $(MAKEFILE_LIST) | grep -e "^[a-zA-Z_\-]*: *.*## *" | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
