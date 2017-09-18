# Install and configure Neovim 
# Requirements: brew

.PHONY: nvim nvim_install nvim_create_config_dir nvim_plugins_install
.SILENT: nvim_install nvim_create_config_dir nvim_plugins_install

BREW_BIN = $(shell command -v brew 2> /dev/null)

DOTFILES_HOME ?= ${HOME}
DOTFILES_DIR = $(DOTFILES_HOME)/.config
DOTFILES_NVIM_DIR = $(DOTFILES_DIR)/nvim

NVIM_BIN = $(shell command -v nvim 2> /dev/null)

#print-%  : ; @echo $* = $($*)

nvim_install:
ifeq ($(strip $(NVIM_BIN)),)
	brew install neovim
endif

nvim_create_config_dir:
	mkdir -p $(DOTFILES_NVIM_DIR)

nvim_plugins_install:
	curl -fsSLo $(DOTFILES_NVIM_DIR)/site/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

nvim:
ifneq ($(strip $(BREW_BIN)),)
nvim: nvim_install nvim_create_config_dir nvim_plugins_install
else
	$(error Homebrew not installed)
endif
