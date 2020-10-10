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
  libevents \ # tmux requirement
  ncurses \ # tmux requirement
  pkg-config \ # icons-in-terminal requirement
  libncursesw5-dev \ # icons-in-terminal requirement
  libreadline-dev \ # icons-in-terminal requirement
  # tmux \
  # fzf \ # Ubuntu 19.10+
  # ripgrep \ # Ubuntu 18.10+
  # tldr \
  # nnn \ # repository out of date!!! Download deb package of latest release
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
# tldr
curl -fsLo "$HOME/bin/tldr" https://raw.githubusercontent.com/raylee/tldr/master/tldr
chmod 755 "$HOME/bin/tldr"

# bat installation isn't through apt yet
curl -fLo bat.deb https://github.com/sharkdp/bat/releases/download/v0.15.4/bat-musl_0.15.4_amd64.deb
sudo dpkg -i ./bat.deb
rm ./bat.deb

# echo "As per https://github.com/junegunn/fzf/issues/1589 we'll have to install fzf manually on Ubuntu 18.04 at the moment";
curl -fLo fzf.deb http://mirrors.kernel.org/ubuntu/pool/universe/f/fzf/fzf_0.18.0-2_amd64.deb
sudo dpkg -i fzf.deb
rm ./fzf.deb

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

curl -fLo ripgrep.deb https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
sudo dpkg -i ripgrep.deb
rm ./ripgrep.deb

# https://github.com/jarun/nnn/releases/download/v3.4/nnn_3.4-1_ubuntu20.04.amd64.deb
# Ubuntu 20.10 has nnn v3.4 in apt repo
curl -fLo nnn.deb https://github.com/jarun/nnn/releases/download/v3.4/nnn_3.4-1_ubuntu18.04.amd64.deb
sudo dpkg -i nnn.deb
rm ./nnn.deb

# tmux


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
