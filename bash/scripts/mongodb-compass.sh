#!/bin/bash

cd "$HOME"

printf "$(tput setaf 33)What is the lastest version of MongoDB Compass?\n"
xdg-open "https://www.mongodb.com/try/download/compass" > /dev/null 2>&1
read COMPASS_VERSION

curl -fLo mongodb-compass.deb "https://downloads.mongodb.com/compass/mongodb-compass_${COMPASS_VERSION}_amd64.deb"
sudo dpkg -i mongodb-compass.deb
rm ./mongodb-compass.deb
