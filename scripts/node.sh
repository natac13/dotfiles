#!/bin/bash

DEFAULT='y'

read -p "Would you like to install NodeJS? [Y/n]" nodejs
nodejs=${nodejs:-${DEFAULT}}
case $nodejs in
 [Yy]* )
    Using Ubuntu
    curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
    sudo apt-get install -y nodejs
    npm i -g n
    ;;
  [Nn]* )
    echo 'Skip Node.js Install.'
    ;;
  * )
esac
# curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -


read -p "Would you like to install Yarn? [Y/n]" yarn
yarn=${yarn:-${DEFAULT}}
case $nodejs in
case $yarn in
 [Yy]* )
   # Install Yarn
   echo "Installing yarn"
   curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
   echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
   sudo apt-get install -y yarn
   ;;
 [Nn]* )
   echo "Skip yarn install."
   ;;
 * )
esac
