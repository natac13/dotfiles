#!/bin/bash

read -p "Would you like to install NodeJS? [Y/n]" nodejs
case $nodejs in
 [Yy]* )
    Using Ubuntu
    curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
    sudo apt-get install -y nodejs
    npm i -g n
   ;;
  [Nn]* );;
  * )
esac
# curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -


read -p "Would you like to install Yarn? [Y/n]" yarn
case $yarn in
 [Yy]* )
   # Install Yarn
   echo "Installing yarn"
   curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
   echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
   sudo apt-get install -y yarn
   ;;
 [Nn]* );;
 * )
esac
