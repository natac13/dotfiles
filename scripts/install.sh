#!/bin/bash

function success () {
  printf "\\033[32m ✔ \\033[0m $1\\n"
}

function fail () {
  printf "\\n\\033[31m ✖ \\033[0m $1\\n"
  exit 1
}

function doing () {
  printf "\\033[33m ➜ \\033[0m $1...\\n"
}

# Get the lastest version of neovim
##################################################
# Update ppa repositories.
##################################################
sudo add-apt-repository -y ppa:neovim-ppa/stable
sudo add-apt-repository -y ppa:git-core/ppa
sudo add-apt-repository -y ppa:jonathonf/vim


cd ~ && sudo apt-get update -y \
  && sudo apt-get upgrade -y;

echo "Installing the basics: git, neovim etc..."
sudo apt-get install -y \
  ca-certificates \
  curl \
  wget \
  dirmngr \
  gpg \
  git \
  vim \
  neovim \
  neofetch \
  openssh-client \
  automake \
  unzip \
  build-essentials \
  # make \ # included with build-essentials
  # g++ \ # included with build-essentials
  # gcc \ # included with build-essentials
  jq \
  xclip \
  bash-completion

if [ ! -d "$HOME/bin" ]; then
  mkdir -p "$HOME/bin"
fi

# https://github.com/jarun/nnn/releases/download/v3.4/nnn_3.4-1_ubuntu20.04.amd64.deb
# Ubuntu 20.10 has nnn v3.4 in apt repo
curl -fLo nnn.deb https://github.com/jarun/nnn/releases/download/v3.4/nnn_3.4-1_ubuntu18.04.amd64.deb
sudo dpkg -i nnn.deb
rm ./nnn.deb

# if there are errors with Chokidar and watching file limit; run the following
# echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p

doing "Downloading git-prompt and git-completions for bash"
cd $HOME
wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -O "$HOME/.git-prompt.sh"
wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -O "$HOME/.git-completion.bash"
success


# define dotfile locaiton
DOTFILES_DIR="$HOME/projects/dotfiles"
if [ ! -d "$DOTFILES_DIR" ]; then
  doing "Create and clone dotfile directory"

  if [ ! -d "$HOME/projects" ]
  then
    mkdir -p "$HOME/projects"
  fi
  git clone -q https://github.com/natac13/dotfiles.git "$DOTFILES_DIR"
  success
fi

echo '==========================================================================='
echo "Done! You can now rm ~/intall.sh, and there is a copy in ~/projects/dotfiles for reference if you're interested. Please read the README to see further details. Enjoy..."
echo '==========================================================================='
