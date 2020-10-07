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
# sudo add-apt-repository -y ppa:neovim-ppa/stable

cd ~ && sudo apt-get update -y \
  && sudo apt-get upgrade -y;

echo "Installing the basics: git, neovim, tmux, fzf, ripgrep, etc..."
sudo apt-get install -y \
  ca-certificates \
  curl \
  wget \
  dirmngr \
  gpg \
  git \
  vim \
  neovim \
  tmux \
  # fzf \ Ubuntu 19.10+
  # ripgrep \ Ubuntu 18.10+
  tldr \
  nnn \
  neofetch \
  openssh-client \
  automake \
  make \
  unzip \
  g++ \
  gcc \
  jq \
  xclip 

# bat installation isn't through apt yet
curl -fLo bat.deb https://github.com/sharkdp/bat/releases/download/v0.15.4/bat-musl_0.15.4_amd64.deb
sudo dpkg -i ./bat.deb
rm ./bat.deb

# echo "As per https://github.com/junegunn/fzf/issues/1589 we'll have to install fzf manually on Ubuntu 18.04 at the moment";
curl -fLo fzf.deb http://mirrors.kernel.org/ubuntu/pool/universe/f/fzf/fzf_0.18.0-2_amd64.deb
sudo dpkg -i fzf.deb
rm ./fzf.deb

curl -fLo ripgrep.deb https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
sudo dpkg -i ripgrep.deb
rm ./ripgrep.deb

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install


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
