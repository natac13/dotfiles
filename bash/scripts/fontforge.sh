#!/bin/bash

if [ ! -d "$HOME/forks" ]; then
  mkdir "$HOME/forks"
fi

cd "$HOME/forks"

# https://github.com/fontforge/fontforge/wiki/CMake-guide-for-FontForge
# install dependencies
sudo apt-get install \
  libjpeg-dev \
  libtiff5-dev \
  libpng-dev \
  libfreetype6-dev \
  libgif-dev \
  libgtk-3-dev \
  libxml2-dev \
  libpango1.0-dev \
  libcairo2-dev \
  libspiro-dev \
  libuninameslist-dev \
  python3-dev \
  ninja-build \
  cmake \
  build-essential \
  gettext

echo "$(tput setaf 33)Clone fontforge GitHub repo.$(tput sgr0)"
git clone --depth 1 https://github.com/fontforge/fontforge
cd fontforge && \
  mkdir build && \
  cd build

echo "$(tput setaf 33)Building fontforge...$(tput sgr0)"
cmake -GNinja ..
ninja
echo "$(tput setaf 33)Installing fontforge ....$(tput sgr0)"
sudo ninja install

echo "$(tput setaf 33)Cleaning up fontforge cloned repo....$(tput sgr0)"
cd $HOME/forks
rm -rf fontforge

cd $HOME
