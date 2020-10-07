DOTFILES_DIR := $(shell echo $(HOME)/projects/dotfiles)
FONT_DIR     := $(shell echo $(HOME)/.local/share/fonts)
SHELL        := /bin/bash
UNAME        := $(shell uname -s)
USER         := $(shell whoami)
COC_EXT_PATH := $(shell echo $(HOME)/.config/coc/extensions)

ifeq ($(UNAME), Linux)
  OS := linux
endif

.PHONY: all install

all: install nvim node

install: $(OS)

.PHONY: help usage
.SILENT: help usage

help: usage

usage:
	printf "\\n\
	\\033[1mDOTFILES\\033[0m\\n\
	\\n\
	Custom settings and configurations for Unix-like environments.\\n\
	See README.md for detailed usage information.\\n\
	\\n\
	\\033[1mUSAGE:\\033[0m make [target]\\n\
	\\n\
	  make         Install all configurations and applications.\\n\
	\\n\
	  make link    Symlink only Bash, Git and Neovim configurations to the home directory.\\n\
	\\n\
	  make unlink  Remove symlinks created by \`make link\`.\\n\
	\\n\
	  make nvim  Install Neovim.\\n\
	\\n\
	  make ndoe Install node, npm and yarn.\\n\
	\\n\
	"

.PHONY: link unlink

link:
	mkdir -p $(FONT_DIR)
	ln -fs $(DOTFILES_DIR)/bash/.bash_profile $(HOME)/.bash_profile
	ln -fs $(DOTFILES_DIR)/bash/.bash_aliases $(HOME)/.bash_aliases
	ln -fs $(DOTFILES_DIR)/bash/.bashrc $(HOME)/.bashrc
	ln -fs $(DOTFILES_DIR)/bash/.curlrc $(HOME)/.curlrc
	ln -fs $(DOTFILES_DIR)/fonts/MyOperatorMono-Regular.otf $(FONT_DIR)/MyOperatorMono-Regular.otf
	ln -fs $(DOTFILES_DIR)/fonts/MyOperatorMono-Italic.otf $(FONT_DIR)/MyOperatorMono-Italic.otf
	ln -fs $(DOTFILES_DIR)/nvim/init.vim $(HOME)/.config/nvim/init.vim
	ln -fs $(DOTFILES_DIR)/nvim/coc-settings.json $(HOME)/.config/nvim/coc-settings.json
	ln -fs $(DOTFILES_DIR)/tmux/.tmux.conf $(HOME)/.tmux.conf
	ln -fs $(DOTFILES_DIR)/git/.gitconfig $(HOME)/.gitconfig
	@printf "\\033[32m✓\\033[0m Symlinks created.\\n"

unlink:
	unlink $(HOME)/.bash_profile
	unlink $(HOME)/.bash_aliases
	unlink $(HOME)/.bashrc
	unlink $(HOME)/.curlrc
	unlink $(FONT_DIR)/MyOperatorMono-Regular.otf
	unlink $(FONT_DIR)/MyOperatorMono-Italic.otf
	unlink $(HOME)/.config/nvim/init.vim
	unlink $(HOME)/.config/nvim/coc-settings.json
	unlink $(HOME)/.tmux.conf
	unlink $(HOME)/.gitconfig
	@printf "\\033[32m✓\\033[0m Symlinks removed. Manually remove ~/dotfiles directory if needed.\\n"


.PHONY: install nvim node

install:
	@bash ./scripts/install.sh

nvim:
	@bash ./scripts/nvim.sh

node:
	@bash ./scripts/node.sh