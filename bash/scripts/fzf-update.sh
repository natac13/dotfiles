#!/bin/bash

if [ ! -d "$HOME/forks/fzf" ]; then
  printf "$(tput setaf 33)No fzf directory in ~/forks.. cannot update.\n"
  exit 0
fi

cd "$HOME/forks/fzf"
git pull
bash ./install.sh

cd $HOME

