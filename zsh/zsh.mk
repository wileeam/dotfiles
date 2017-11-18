# Install and configure Z shell
# Requirements: brew git

.PHONY: zsh zsh_install zsh_prezto
.SILENT: zsh_install zsh_prezto

BREW_BIN = $(shell command -v brew 2> /dev/null)

DOTFILES_HOME ?= ${HOME}
DOTFILES_DIR = $(DOTFILES_HOME)/.config
DOTFILES_ZSH_DIR = $(DOTFILES_DIR)/zsh

ZSH_BIN = $(shell command -v zsh 2> /dev/null)

ZSH_PREZTO = zprezto
ZSH_PREZTO_HOME = $(DOTFILES_ZSH_DIR)/.$(ZSH_PREZTO)
ZSH_PREZTO_FILES = zshenv zprofile zshrc zpreztorc zlogin zlogout

#print-%  : ; @echo $* = $($*)

zsh_install:
ifeq ($(strip $(ZSH_BIN)),)
	brew install zsh
endif

zsh_prezto_install:
	mkdir -p $(DOTFILES_ZSH_DIR)
	git clone --recursive https://github.com/sorin-ionescu/prezto.git "$(ZSH_PREZTO_HOME)"

zsh_prezto_configure:
	$(foreach f, $(ZSH_PREZTO_FILES), ln -fs $(ZSH_PREZTO_HOME)/runcoms/$(f) $(DOTFILES_HOME)/.$(f);)
	ln -fs $(ZSH_PREZTO_HOME) $(DOTFILES_HOME)/.$(ZSH_PREZTO)

zsh_prezto: zsh_prezto_install zsh_prezto_configure

zsh_shell:
	#sudo echo $(ZSH_BIN) >> /etc/shells
	chsh -s $(ZSH_BIN)

zsh:
ifneq ($(strip $(BREW_BIN)),)
zsh: zsh_install zsh_prezto zsh_shell
else
	$(error Homebrew not installed)
endif
