#!/usr/bin/env bash

function success() {
  printf "\\033[32m ✔ SUCCESS\\033[0m $1\\n"
}

function fail() {
  printf "\\n\\033[31m ✖ FAIL\\033[0m $1\\n"
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
  neofetch \
  openssh-client \
  automake \
  unzip \
  build-essential \
  jq \
  xclip \
  nnn \
  tmux \
  bat \
  bash-completion
# make \ # included with build-essentials
# g++ \ # included with build-essentials
# gcc \ # included with build-essentials

sudo apt install -y \
  vim
sudo apt install -y \
  neovim

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
# export DOTFILES="$HOME/.dotfiles"
export DOTFILES="/workspace"
if [ ! -d "$DOTFILES" ]; then
  doing "Create and clone dotfile directory"
  # git clone -q https://github.com/natac13/dotfiles.git "$DOTFILES"
  success "Created dotfiles directory $DOTFILES"
fi

################################################################
# Handle vim / neovim setup
################################################################
doing "Setup vim and nvim configuration and install vim-plug"
if test $(which nvim); then
  # create nvim config directory if it does not exist
  if [ ! -d $HOME/.config/nvim/ ]; then
    mkdir -p $HOME/.config/nvim
  fi

  # link configuration to ~/.config/nvim/init.vim
  if [ -f $DOTFILES/nvim/.vimrc ]; then
    doing "Link .config/nvim/init.vim file"
    ln -fs $DOTFILES/nvim/.vimrc $HOME/.config/nvim/init.vim
  fi

  # link coc-settings.json if it exist
  if [ -f $DOTFILES/nvim/coc-settings.json ]; then
    ln -fs $DOTFILES/nvim/coc-settings.json $HOME/.config/nvim/coc-settings.json
  fi

  # Download vim-plug for nvim
  if [ ! -f "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim" ]; then

    doing "Install vim plug for nvim"
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
          https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  fi
else
  fail "Missing nvim command"
fi

if test $(which vim); then
  # link configuration to ~/.vimrc
  if [ -f $DOTFILES/nvim/.vimrc ]; then
    doing "Link .vimrc file"
    ln -fs $DOTFILES/nvim/.vimrc $HOME/.vimrc
  fi

  # Download vim-plug for vim
  if [ ! -f $HOME/.vim/autoload/plug.vim ]; then
    doing "Install vim plug for vim"
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    doing "Install vim plugins"
    vim -es -u ~/.vimrc -i NONE -c "PlugInstall" -c "qa"
    success "Installed vim plug and plugins"
  fi
else
  fail "Missing vim command"
fi

# link tmux config
if test $(which tmux); then
  # link configuration to ~/.vimrc
  if [ -f $DOTFILES/tmux/.tmux.conf ]; then
    doing "Link .tmux.conf file"
    ln -fs "$DOTFILES/tmux/.tmux.conf" "$HOME/.tmux.conf"
  fi
else
  fail "Missing tmux command"
fi

if [ -f "$DOTFILES/bash/.bashrc" ]; then
  doing "Link .bashrc file"
  ln -fs "$DOTFILES/bash/.bashrc" "$HOME/.bashrc"
fi

if ! test $(which node); then
  doing "Installing nvm and latest node lts"
  # download nvm package
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash

  # load nvm
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

  # install latest node lts
  nvm install --lts

  # install neovim package needed for nvim coc
  npm install -g neovim
fi

if [ -f $DOTFILES/git/.gitconfig ]; then
  doing "Link git config file"
  ln -fs $DOTFILES/git/.gitconfig $HOME/.gitconfig
fi

echo '==========================================================================='
success "Done! Run source ~/.profile or ~/.bashrc to reload your shell"
echo '==========================================================================='
