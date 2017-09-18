# Install and configure Google Cloud SDK
# Requirements: brew

.PHONY: gcp gcp_install gcp_config_files gcloud_components_install
.SILENT: gcp_install gcp_config_files gcloud_components_install

BREW_BIN = $(shell command -v brew 2> /dev/null)

DOTFILES_HOME ?= ${HOME}
DOTFILES_DIR = $(DOTFILES_HOME)/.config
DOTFILES_DIR_ZSHRC = $(DOTFILES_HOME)/.zshrc

GCLOUD_BIN = $(shell command -v gcloud 2> /dev/null)
GCLOUD_COMPONENTS = bq gsutil kubectl datalab pubsub-emulator alpha beta

#print-%  : ; @echo $* = $($*)

gcp_install:
ifneq ($(strip $(BREW_BIN)),)
	brew install caskroom/cask/google-cloud-sdk
endif

gcp_config_files:
	echo "source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'" >> $(DOTFILES_DIR_ZSHRC)
	echo "source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'" >> $(DOTFILES_DIR_ZSHRC)

gcloud_components_install:
ifneq ($(strip $(GCLOUD_BIN)),)
	gcloud components install $(GCLOUD_COMPONENTS)
endif

gcp:
ifneq ($(strip $(BREW_BIN)),)
gcp: gcp_install gcp_config_files
else
	$(error Homebrew not installed)
endif
