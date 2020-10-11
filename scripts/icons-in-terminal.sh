#!/bin/bash

if [ ! -d "$HOME/forks/" ]; then
  mkdir -p "$HOME/forks"
fi

cd $HOME/forks

# clone icons-in-terminal repo and install.
# need to edit the ~/.config/fontconfig/conf.d/30-icons.conf to target the font being used. ie MyOperatorMono
git clone --depth 1 https://github.com/sebastiencs/icons-in-terminal.git
cd icons-in-terminal
bash ./install.sh
# source ~/.local/share/icons-in-terminal/icons_bash.sh in .bashrc
# example usage echo -e $oct_location # note the '-e'

# link the config file to the one in dotfiles
if [ -f "$HOME/.config/fontconfig/conf.d/30-icons.conf" ]; then
  rm -f "$HOME/.config/fontconfig/conf.d/30-icons.conf"
fi
cp -u "$DOTFILES/bash/.config/fontconfig/conf.d/30-icons.conf" "$HOME/.config/fontconfig/conf.d/30-icons.conf"
