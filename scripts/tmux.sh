#!/bin/bash
sudo apt-get install -y libevent-dev ncurses-dev build-essential bison pkg-config

cd "$HOME/Downloads"

printf "$(tput setaf 33)What is the lastest version of tmux?\n"
xdg-open "https://github.com/tmux/tmux/releases" > /dev/null 2>&1
read TMUX_VERSION
curl -fLo tmux.tar.gz "https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz"
# install instructions from https://github.com/tmux/tmux/wiki/Installing
tar -zxf tmux.tar.gz
cd tmux-*/
bash ./configure
make && sudo make install

