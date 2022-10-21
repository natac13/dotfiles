#!/bin/bash

function success() {
  printf "\\033[32m ✔ SUCCESS\\033[0m $1\\n"
}

function fail() {
  printf "\\n\\033[31m ✖ FAIL\\033[0m $1\\n"
  exit 1
}

function doing() {
  printf "\\033[33m ➜ DOING\\033[0m $1...\\n"
}

#To be able to use add-apt-repository you may need to install software-properties-common:
sudo apt install -y \
  software-properties-common

# Get the lastest version of neovim
##################################################
# Update ppa repositories.
##################################################
sudo add-apt-repository -y ppa:neovim-ppa/stable
sudo add-apt-repository -y ppa:git-core/ppa
sudo add-apt-repository -y ppa:jonathonf/vim

cd ~ && sudo apt-get update -y &&
  sudo apt-get upgrade -y

doing "Installing the basics: git, neovim etc..."
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
success

# define dotfile locaiton
DOTFILES_DIR="$HOME/.dotfiles"
# if [ ! -d "$DOTFILES_DIR" ]; then
#   doing "Create and clone dotfile directory"
#   # git clone -q https://github.com/natac13/dotfiles.git "$DOTFILES_DIR"
#   success
# fi

ln -fs /workspace/nvim/.vimrc $HOME/.vimrc

# Download vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

echo '==========================================================================='
echo "Done! You can now rm ~/intall.sh, and there is a copy in ~/projects/dotfiles for reference if you're interested. Please read the README to see further details. Enjoy..."
echo '==========================================================================='
