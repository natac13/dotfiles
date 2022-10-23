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

# To be able to use add-apt-repository you may need to install software-properties-common:
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

success 'Debian packages installed'

if [ ! -d "$HOME/bin" ]; then
  mkdir -p "$HOME/bin"
fi

# if there are errors with Chokidar and watching file limit; run the following
# echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p

################################################################
# Install git prompt & git completion
################################################################
doing "Downloading git-prompt and git-completions for bash"

curl -fLo "$HOME/.git-prompt.sh" --create-dirs https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh

curl -fLo "$HOME/.git-completion.bash" --create-dirs https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash

success 'Installed git-prompt and git-completion for bash'

# define dotfile locaiton
DOTFILES="$HOME/.dotfiles"
if [ ! -d "$DOTFILES" ]; then
  doing "Create and clone dotfile directory"
  git clone -q https://github.com/natac13/dotfiles.git "$DOTFILES"
  success
fi

################################################################
# Handle vim / neovim setup
################################################################
doing "Setup vim and nvim configuration and install vim-plug"
if test $(which nvim); then
  # link configuration to ~/.config/nvim/init.vim
  if [ -f $DOTFILES/nvim/.vimrc ]; then
    ln -fs $DOTFILES/nvim/.vimrc $HOME/.config/nvim/init.vim
  fi

  # Download vim-plug for nvim
  if [ ! -f "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim" ]; then

    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
          https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  fi
fi

if test $(which vim); then
  # link configuration to ~/.vimrc
  if [ -f $DOTFILES/nvim/.vimrc ]; then
    ln -fs $DOTFILES/nvim/.vimrc $HOME/.vimrc
  fi

  # Download vim-plug for vim
  if [ ! -f $HOME/.vim/autoload/plug.vim ]; then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  fi
fi

if [ -f "$DOTFILES/bash/.bashrc"]; then
  ln -fs $DOTFILES/bash/.bashrc $HOME/.bashrc
  source $HOME/.bashrc
fi

echo '==========================================================================='
success "Done! You can now rm ~/intall.sh, and there is a copy in ~/projects/dotfiles for reference if you're interested. Please read the README to see further details. Enjoy..."
echo '==========================================================================='
