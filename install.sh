#!/usr/bin/env bash

apt install \
  curl

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>$HOME/.zprofile
  # eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "Installing git..."
# Check for Oh My Zsh and install if we don't have it
if test ! $(which git); then
  # apt install git -y
  brew install git
  # /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
  git --version
fi

echo "Cloning dotfile directoy..."
# define dotfile locaiton
DOTFILES_DIR="$HOME/.dotfiles"

if [ ! -d "$DOTFILES_DIR" ]; then
  echo "Create and clone dotfile directory into ~/.dotfiles"
  mkdir $DOTFILES_DIR

  git clone -q https://github.com/natac13/dotfiles.git "$DOTFILES_DIR"
  echo 'Cloned dotfiles dir'
fi

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  echo 'Ubuntu OS detected'
elif [[ "$OSTYPE" == "darwin"* ]]; then
  echo 'Mac OS detected'
else
  echo "Unknown operating system ${OSTYPE}"
fi
