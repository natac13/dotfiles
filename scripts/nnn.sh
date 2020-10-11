#!/bin/bash

# https://github.com/jarun/nnn/releases to find lastest .deb 
# install need apt packages to make nnn from source to create icon support
sudo apt-get install -y pkg-config libncursesw5-dev libreadline-dev

if [ ! -d ~/forks ]; then
  mkdir -p ~/forks
fi

cd ~/forks

git clone --depth 1 https://github.com/jarun/nnn.git
cd nnn
make O_NERD=1

sudo cp ./nnn $(which nnn)
