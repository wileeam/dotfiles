# Install and configure Homebrew
# Requirements: ruby

.PHONY: brew brew_install brew_packages
.SILENT: brew_install brew_packages

BREW_BIN := $(shell command -v brew 2> /dev/null)
BREW_URL := https://raw.githubusercontent.com/Homebrew/install/master/install.sh
BREW_INSTALL := $$(curl -fsSL $(BREW_URL))

DOTFILES_HOME ?= ${HOME}
DOTFILES_DIR := $(DOTFILES_HOME)/.config
DOTFILES_NVIM_DIR := $(DOTFILES_DIR)/nvim

BASH_BIN := $(shell command -v bash 2> /dev/null)

#print-%  : ; @echo $* = $($*)

brew_install:
	echo "Installing Homebrew via URL: $(BREW_URL)"
	$(BASH_BIN) -c "$(BREW_INSTALL)"

brew_packages:
	brew install htop
	brew install jq

brew: brew_install brew_packages
