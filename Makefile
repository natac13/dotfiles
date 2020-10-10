DOTFILES_DIR := $(shell echo $(HOME)/projects/dotfiles)
FONT_DIR     := $(shell echo $(HOME)/.local/share/fonts)
SHELL        := /bin/bash
UNAME        := $(shell uname -s)
USER         := $(shell whoami)
COC_EXT_PATH := $(shell echo $(HOME)/.config/coc/extensions)

IRed         := '\033[0;91m'
IGreen       := '\033[0;92m'
IBlue        := '\033[0;94m'
Color_Off    := '\033[0m'
White        := '\033[1m'
ifeq ($(UNAME), Linux)
  OS := linux
endif

.PHONY: all install

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
	  make nvim node git aws docker \\n\
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


.PHONY: install \
	nvim \
	node \
	git \
	docker \
	aws \
	fzf-install \
	fzf-update \
	bat \
	ripgrep \
	tldr \
	tmux

install:
	@bash ./scripts/install.sh

nvim:
	@bash ./scripts/nvim.sh

node:
	@bash ./scripts/node.sh

git:
	@bash ./scripts/git.sh

aws:
	@print "${IBlue}Setup aws cli${Color_Off}"
	@bash ./scripts/aws.sh

docker:
	@printf "${IBlue}Setup Docker...${Color_Off}\\nInstall \`apt\` packages.\\n"
	sudo apt-get -y install \
		apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
	@printf "Add Docker’s official GPG key.\\n"
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	@printf "Verify key fingerprint.\\n"
	sudo apt-key fingerprint 0EBFCD88
	sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
	sudo apt-get update
	sudo apt-get install docker-ce docker-ce-cli containerd.io
	@printf "Allow use of Docker without sudo.\\n"
	sudo groupadd docker
	sudo usermod -aG docker $(USER)
	newgrp dockeu
	sudo systemctl enable docker

fzf-install:
	@bash ./scripts/fzf-install.sh

fzf-update:
	@bash ./scripts/fzf-update.sh

bat:
	@bash ./scripts/bat.sh

ripgrep:
	@bash ./scripts/ripgrep.sh

tldr:
	@bash ./scripts/tldr.sh

tmux:
	@bash ./scripts/tmux.sh

all: nvim node git link aws
