#!/bin/bash

cd "$HOME"

printf "$(tput setaf 33)What is the lastest version of bat?\n"
xdg-open "https://github.com/sharkdp/bat/releases" > /dev/null 2>&1
read BAT_VERSION

curl -fLo bat.deb "https://github.com/sharkdp/bat/releases/download/v${BAT_VERSION}/bat_${BAT_VERSION}_amd64.deb"
sudo dpkg -i bat.deb
rm ./bat.deb
