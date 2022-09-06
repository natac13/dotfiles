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
  build-essential \
  jq \
  xclip \
  nnn \
  bash-completion
  # make \ # included with build-essentials
  # g++ \ # included with build-essentials
  # gcc \ # included with build-essentials

if [ ! -d "$HOME/bin" ]; then
  mkdir -p "$HOME/bin"
fi

# if there are errors with Chokidar and watching file limit; run the following
# echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p

doing "Downloading git-prompt and git-completions for bash"
cd $HOME
wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -O "$HOME/.git-prompt.sh"
wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -O "$HOME/.git-completion.bash"
echo "source ~/.git-prompt.sh" >> ~/.bashrc
echo "source ~/.git-completion.bash" >> ~/.bashrc
success "Done with git stuff"

doing "Set nvim as the default editor"
echo -e "if [ -x /usr/bin/nvim ]; then
  export EDITOR=nvim
  export VISUAL=nvim
else
  export EDITOR=vim
  export VISUAL=vim
fi" >> ~/.bashrc
success "Done with default editor"
