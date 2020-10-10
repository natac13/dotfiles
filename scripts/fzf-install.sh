#!/bin/bash

if [ ! -d "$HOME/forks" ]; then
  mkdir "$HOME/forks"
fi

cd "$HOME/forks"

git clone --depth 1 https://github.com/junegunn/fzf.git
bash ./fzf/install

cd $HOME
