#!/usr/bin/bash

set -e

success () {
  printf "\\033[32m ✔ \\033[0m\\n"
}

fail () {
  printf "\\n\\033[31m ✖ \\033[0m $1\\n"
  exit 1
}

doing () {
  printf "\\033[33m ➜ \\033[0m $1"
}

# define dotfile locaiton
DOTFILES_DIR="$HOME/projects/dotfiles"

if [ ! -d $DOTFILES_DIR ]; then
  doing "Create and clone dotfile directory..."
  [ ! -d "$HOME/projects" ] && mkdir -p "$HOME/projects"
  git clone -q https://github.com/natac13/dotfiles.git $DOTFILES_DIR
fi
success