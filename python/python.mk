# Install and configure Python 3
# Requirements: brew

.PHONY: python python_install python_components_install
.SILENT: python_install python_components_install

BREW_BIN = $(shell command -v brew 2> /dev/null)

DOTFILES_HOME ?= ${HOME}
DOTFILES_DIR = $(DOTFILES_HOME)/.config
DOTFILES_DIR_ZSHRC = $(DOTFILES_HOME)/.zshrc

PYTHON_BIN = $(shell command -v python3 2> /dev/null)
PYTHON_COMPONENTS = pipenv

#print-%  : ; @echo $* = $($*)

python_install:
ifneq ($(strip $(BREW_BIN)),)
	brew install python
endif

python_components_install:
	PYTHON3_BIN := $(shell command -v python3 2> /dev/null)
ifneq 

python: python_install
