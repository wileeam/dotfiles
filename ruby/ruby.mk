# Install and configure Ruby
# Requirements: brew

.PHONY: rbenv rbenv_install rbenv_config_install
.SILENT: rbenv_install rbenv_config_install

BREW_BIN = $(shell command -v brew 2> /dev/null)

DOTFILES_HOME ?= ${HOME}
DOTFILES_DIR := $(DOTFILES_HOME)/.config
DOTFILES_ZSHRC := $(DOTFILES_HOME)/.zshrc

RUBY_BIN := $(shell command -v rbenv 2> /dev/null)
RBENV_BIN := (shell command -v rbenv 2> /dev/null)

#print-%  : ; @echo $* = $($*)

rbenv_install:
ifeq ($(strip $(RBENV_BIN)),)
	brew install rbenv
endif

rbenv_config_install:
	@echo '# Ruby environment variable (installed due to rbenv)' > ${DOTFILES_ZSHRC}.tmp
	@echo 'export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"' >> ${DOTFILES_ZSHRC}.tmp
ifeq ($(wildcard $DOTFILES_ZSHRC),) # File does not exist
	@echo '${DOTFILES_ZSHRC} does not exist. Creating it and adding environment variable...'
	@cp ${DOTFILES_ZSHRC}.tmp ${DOTFILES_ZSHRC}
else # File does exist
	@echo '${DOTFILES_ZSHRC} does exist. Adding environment variable...'
	@cat ${DOTFILES_ZSHRC}.tmp >> ${DOTFILES_ZSHRC}
endif
	@rm ${DOTFILES_ZSHRC}.tmp

rbenv:
ifneq ($(strip $(BREW_BIN)),)
rbenv: rbenv_install rbenv_config_install
else
	$(error Homebrew not installed)
endif
