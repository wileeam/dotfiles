# Install and configure Z shell
# Requirements: brew git

.PHONY: zsh zsh_install zsh_prezto
.SILENT: zsh_install zsh_prezto

BREW_BIN = $(shell command -v brew 2> /dev/null)

DOTFILES_HOME ?= ${HOME}
DOTFILES_DIR := $(DOTFILES_HOME)/.config
DOTFILES_ZSH_DIR := $(DOTFILES_DIR)/zsh

ZSH_BIN := $(shell command -v zsh 2> /dev/null)

ZSH_PREZTO := zprezto
ZSH_PREZTO_HOME := $(DOTFILES_ZSH_DIR)/.$(ZSH_PREZTO)
ZSH_PREZTO_FILES := zlogin zlogout zpreztorc zprofile zshenv zshrc

# Get the parent process' shell: https://stackoverflow.com/a/16948099
# and split to get the shell's name: https://stackoverflow.com/a/43232900
DEFAULT_SHELL := $(shell command perl -e 'print((split "/", (getpwuid $$<)[8])[-1], "\n")')
# Split strings in make: https://stackoverflow.com/a/51405618
MAKE_SHELL    := $(lastword $(subst /, ,$(SHELL)))

# print-%  : ; @echo $* = $($*)

zsh_install:
ifeq (, $(shell which zsh))
	# $(error "No zsh in $(PATH), consider doing brew install zsh")
	@echo "No Z shell installed. Installing..."
	brew install zsh
else
	@echo "Z shell is already installed. Available in your path at $(ZSH_BIN)"
endif

zsh_prezto_install:
	mkdir -p $(DOTFILES_ZSH_DIR)
	git clone --recursive https://github.com/sorin-ionescu/prezto.git "$(ZSH_PREZTO_HOME)"

zsh_prezto_configure:
	$(foreach f, $(ZSH_PREZTO_FILES), ln -fs $(ZSH_PREZTO_HOME)/runcoms/$(f) $(DOTFILES_HOME)/.$(f);)
	ln -fs $(ZSH_PREZTO_HOME) $(DOTFILES_HOME)/.$(ZSH_PREZTO)

zsh_prezto: zsh_prezto_install zsh_prezto_configure

zsh_shell:
ifeq ($(DEFAULT_SHELL), "zsh")
	@echo "Setting Z shell as default shell"
	# sudo echo $(ZSH_BIN) >> /etc/shells
	chsh -s $(ZSH_BIN)
else
	@echo "Z shell is already your default shell"
endif

zsh:
ifneq ($(strip $(BREW_BIN)),)
zsh: zsh_install zsh_prezto zsh_shell
else
	$(error Homebrew not installed)
endif
