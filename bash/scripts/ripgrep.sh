#!/bin/bash

cd "$HOME"

printf "$(tput setaf 33)What is the lastest version of ripgrep?\n"
xdg-open "https://github.com/BurntSushi/ripgrep/releases" > /dev/null 2>&1
read RG_VERSION

curl -fLo ripgrep.deb "https://github.com/BurntSushi/ripgrep/releases/download/${RG_VERSION}/ripgrep_${RG_VERSION}_amd64.deb"
sudo dpkg -i ripgrep.deb
rm ./ripgrep.deb
