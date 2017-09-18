# Install and configure Homebrew
# Requirements: ruby

.PHONY: brew brew_install brew_packages
.SILENT: brew_install brew_packages

BREW_BIN = $(shell command -v brew 2> /dev/null)
BREW_URL := https://raw.githubusercontent.com/Homebrew/install/master/install
BREW_INSTALL = $$(curl -fsSL $(BREW_URL))

DOTFILES_HOME ?= ${HOME}
DOTFILES_DIR = $(DOTFILES_HOME)/.config
DOTFILES_NVIM_DIR = $(DOTFILES_DIR)/nvim

RUBY_BIN := $(shell command -v ruby 2> /dev/null)

#print-%  : ; @echo $* = $($*)

brew_install:
ifneq ($(strip $(BREW_BIN)),)
	$(RUBY_BIN) -e "$(BREW_INSTALL)"
endif

brew_packages:
	brew install htop
	brew install jq
	
brew: brew_install brew_packages
